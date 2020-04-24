//
//  HelloScene.swift
//  Myspritekit
//
//  Created by mac23 on 2020/4/1.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit
import SpriteKit

class HelloScene: SKScene {
    override func didMove(to view: SKView) {
        createScene()
    }
    func createScene(){
        let bgd = SKSpriteNode(imageNamed: "hellobgd.jpg")
        bgd.size.width = self.size.width
        bgd.size.height = self.size.height
        bgd.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        bgd.zPosition = -1
        
        let hellolabel = SKLabelNode(text: "Space 🚀 Adventure")
        hellolabel.name = "label"
        hellolabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        hellolabel.fontName = "Avenir-Oblique"
        hellolabel.fontSize = 28
        
        let spaceship = newSpaceship()
        spaceship.position = CGPoint(x:self.frame.midX, y:self.frame.midY-150)
        
        self.addChild(bgd)
        self.addChild(hellolabel)
        self.addChild(spaceship)
    }
    func newSpaceship() -> SKSpriteNode{
        let ship = SKSpriteNode(imageNamed: "spaceship.png")
        ship.size = CGSize(width: 75, height: 75)
        ship.name = "ships"

        ship.physicsBody = SKPhysicsBody(circleOfRadius: ship.size.width/2)
        ship.physicsBody?.usesPreciseCollisionDetection = true
        ship.physicsBody?.isDynamic = false
        
        return ship
    }
    func newFire() -> SKShapeNode{
        //fire points
        var points = [
            CGPoint(x: -10, y: -40),
            CGPoint(x: -20, y: -70),
            CGPoint(x: -7, y: -55),
            CGPoint(x: 0, y: -70),
            CGPoint(x: 7, y: -55),
            CGPoint(x: 20, y: -70),
            CGPoint(x: 10, y: -40),
            CGPoint(x: -10, y: -40)]
        //draw fire
        let fire = SKShapeNode(points: &points, count: points.count)
        
        fire.strokeColor = SKColor.white
        fire.fillColor = SKColor.orange
        let blink = SKAction.sequence([SKAction.fadeOut(withDuration: 0.25),SKAction.fadeIn(withDuration: 0.25)
        ])
        let blinkForever = SKAction.repeatForever(blink)
        fire.run(blinkForever)
        return fire
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Action
        let shipslowmoveup = SKAction.moveBy(x: 0, y: 200, duration: 1)
        let shipfastmoveup = SKAction.moveBy(x: 0, y: 1000, duration: 0.5)
        // let labelmoveup = SKAction.moveBy(x: 0, y: 200, duration: 1)
        let zoomin = SKAction.scale(to: 2.0, duration: 0.5)
        let pause = SKAction.wait(forDuration: 0.5)
        let zoomout = SKAction.scale(by: 0.5, duration: 0.25)
        let fadeaway = SKAction.fadeOut(withDuration: 0.25)
        let remove = SKAction.removeFromParent()
        
        //Nodes
        let labelNode = self.childNode(withName: "label")
        let shipNode = self.childNode(withName: "ships")
        let startfire = newFire()
        startfire.position = CGPoint(x: 0, y: 0)
        shipNode?.addChild(startfire)
        
        //getAction
        let shipmovesequence = SKAction.sequence([shipslowmoveup, shipfastmoveup,fadeaway,remove])
        let labelmovesequence = SKAction.sequence([zoomin, pause, zoomout, pause, fadeaway, remove])
        
        shipNode?.run(shipmovesequence)
        labelNode?.run(labelmovesequence, completion: {
            let mainScene = MainScene(size: self.size)
            let doors = SKTransition.fade(with: SKColor.white, duration: 0.5)
            self.view?.presentScene(mainScene, transition: doors)
        })
    }

}
