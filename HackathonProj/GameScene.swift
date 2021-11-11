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
    }
    
    func resetGame() {
        //self.theBird.frame.origin.x = self.birdInitX
        
        
        self.theBird.position.x = self.birdInitX
        self.theBird.position.y = self.birdInitY
        self.theCoin.position.x = self.coinInitX
        self.theCoin.position.y = self.coinInitY
        
        self.theCoin.isHidden = false
        
      
    }
    
    func checkCollisions(objA : SKSpriteNode, objB : SKSpriteNode) -> Bool {
        if ((objA.frame.origin.x) >= objB.frame.origin.x - (objB.frame.width*0.5) && objA.frame.origin.x <= (objB.frame.origin.x + objB.frame.width) + (objB.frame.width*0.5)) {
            if ((objA.frame.origin.y) >= objB.frame.origin.y - (objB.frame.origin.y*0.5) && objA.frame.origin.y <= objB.frame.origin.y + 1.5*objB.frame.height) {
                return true
            }
        }
        return false
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if (self.checkCollisions(objA: theBird, objB: theCoin)){
            let hitAnimation : SKAction = SKAction(named: "HitBird")!
            
           // let sequence : SKAction = SKAction.sequence ([hitAnimation, self.resetGame()])
            
            theCoin.isHidden = true
            
            theBird.run(hitAnimation, completion: {
                self.resetGame()
            })
            
            
            
           // resetGame()
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
