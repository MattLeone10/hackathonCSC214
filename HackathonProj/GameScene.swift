//
//  GameScene.swift
//  HackathonProj
//
//  Created by Leone, Matthew on 11/10/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var theBird : SKSpriteNode = SKSpriteNode()
    var theCoin : SKSpriteNode = SKSpriteNode()
    var winTag : SKLabelNode = SKLabelNode()
    var loseTag : SKLabelNode = SKLabelNode()
    var wall1 : SKSpriteNode = SKSpriteNode()
    var wall2 : SKSpriteNode = SKSpriteNode()
    var wall3 : SKSpriteNode = SKSpriteNode()
    var wall4 : SKSpriteNode = SKSpriteNode()
    var wall5 : SKSpriteNode = SKSpriteNode()
    var wall6 : SKSpriteNode = SKSpriteNode()
    var wall7 : SKSpriteNode = SKSpriteNode()
    var wallAssetArray : [SKSpriteNode] = []
    
    var birdInitX : CGFloat = 0
    var birdInitY : CGFloat = 0
    var coinInitX : CGFloat = 0
    var coinInitY : CGFloat = 0
    
    var didLoad : Bool = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        if let someBird:SKSpriteNode = self.childNode(withName: "BlueBird") as? SKSpriteNode{
            theBird = someBird
        }
        if let someCoin:SKSpriteNode = self.childNode(withName: "Coin") as? SKSpriteNode{
            theCoin = someCoin
        }
        if let someWall:SKSpriteNode = self.childNode(withName: "wall1") as? SKSpriteNode{
            wall1 = someWall
            wallAssetArray.append(wall1)
        }
        if let someWall:SKSpriteNode = self.childNode(withName: "wall2") as? SKSpriteNode{
            wall2 = someWall
            wallAssetArray.append(wall2)
        }
        if let someWall:SKSpriteNode = self.childNode(withName: "wall3") as? SKSpriteNode{
            wall3 = someWall
            wallAssetArray.append(wall3)
        }
        if let someWall:SKSpriteNode = self.childNode(withName: "wall4") as? SKSpriteNode{
            wall4 = someWall
            wallAssetArray.append(wall4)
        }
        if let someWall:SKSpriteNode = self.childNode(withName: "wall5") as? SKSpriteNode{
            wall5 = someWall
            wallAssetArray.append(wall5)
        }
        if let someWall:SKSpriteNode = self.childNode(withName: "wall6") as? SKSpriteNode{
            wall6 = someWall
            wallAssetArray.append(wall6)
        }
        if let someWall:SKSpriteNode = self.childNode(withName: "wall7") as? SKSpriteNode{
            wall7 = someWall
            wallAssetArray.append(wall7)
        }
        if let someTag:SKLabelNode = self.childNode(withName: "winTag") as? SKLabelNode{
            winTag = someTag
            winTag.isHidden = true
            winTag.text = "You've won the game!"
            winTag.fontSize = 60
        }
        if let someTag:SKLabelNode = self.childNode(withName: "loseTag") as? SKLabelNode{
            loseTag = someTag
            loseTag.isHidden = true
            loseTag.text = "You've lost the game!"
            loseTag.fontSize = 60
        }
    }
    
    func resetGame() {
        //self.theBird.frame.origin.x = self.birdInitX
        
        
        self.theBird.position.x = self.birdInitX
        self.theBird.position.y = self.birdInitY
        self.theCoin.position.x = self.coinInitX
        self.theCoin.position.y = self.coinInitY
        
        self.theCoin.isHidden = false
        self.winTag.isHidden = true
        self.loseTag.isHidden = true
      
    }
    
    func checkCollisions(objA : SKSpriteNode, objB : SKSpriteNode) -> Bool {
        if (objB.contains(objA.position)){
            return true
        }
        return false
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if (self.checkCollisions(objA: theBird, objB: theCoin)){
            let hitAnimation : SKAction = SKAction(named: "HitBird")!
            let wait:SKAction = SKAction.wait(forDuration: 3)
           // let sequence : SKAction = SKAction.sequence ([hitAnimation, self.resetGame()])
            theCoin.isHidden = true
            winTag.isHidden = false
            theBird.run(hitAnimation)
            theBird.run(wait, completion: {
                self.resetGame()
            })
           // resetGame()
        }
        for wall in wallAssetArray{
            if (self.checkCollisions(objA: theBird, objB: wall)){
                let loseBird : SKAction = SKAction(named: "loseBird")!
                loseTag.isHidden = false
                theBird.run(loseBird)
                let wait:SKAction = SKAction.wait(forDuration: 1)
                theBird.run(wait, completion: {
                    self.resetGame()
                })
            }
        }
        
        if (!self.didLoad) {
            
            self.birdInitX = self.theBird.frame.origin.x
            self.birdInitY = self.theBird.frame.origin.y
            self.coinInitX = self.theCoin.frame.origin.x
            self.coinInitY = self.theCoin.frame.origin.y
            
            self.didLoad = true
        }
        
    }
    func moveDown(){
        let moveAction:SKAction = SKAction.moveBy(x: 0, y: -50, duration: 1)
        theBird.run(moveAction)
    }
    func moveUp(){
        let moveAction:SKAction = SKAction.moveBy(x: 0, y: 50, duration: 1)
        theBird.run(moveAction)
    }
    func moveRight(){
        let moveAction:SKAction = SKAction.moveBy(x: 50, y: 0, duration: 1)
        theBird.run(moveAction)
    }
    func moveLeft(){
        let moveAction:SKAction = SKAction.moveBy(x: -50, y: 0, duration: 1)
        theBird.run(moveAction)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let birdX = theBird.frame.origin.x
        let birdY = theBird.frame.origin.y
        if ( pos.y > birdY){
            moveUp()
        } else {
            moveDown()
        }
        if ( pos.x > birdX){
            moveRight()
        }else{
            moveLeft()
        }

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            break
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
}
