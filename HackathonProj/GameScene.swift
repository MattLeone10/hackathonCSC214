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
            theBird.physicsBody?.isDynamic = true
        } else{
            print("assigning bird failed")
        }
        
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(theBird.position.y > 0){
            print("greater")
        } else {
            print("less than")
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

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
