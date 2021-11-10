//
//  GameScene.swift
//  HackathonProj
//
//  Created by Leone, Matthew on 11/10/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var theBird:SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        if let someBird:SKSpriteNode = self.childNode(withName: "BlueBird") as? SKSpriteNode{
            theBird = someBird
            theBird.physicsBody?.isDynamic = false
        } else{
            print("assigning bird failed")
        }
        
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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
        let birdX = theBird.position.x
        let birdY = theBird.position.y
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
