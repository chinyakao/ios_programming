//
//  GameOverScene.swift
//  Myspritekit
//
//  Created by mac23 on 2020/4/23.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    var finalScore: Int!
    override func didMove(to view: SKView) {
        createScene()
        let tryAgain = UIAlertController(title: "", message: "Score: " + String(finalScore), preferredStyle:.alert)
        let restartAction = UIAlertAction(title: "Again", style: .default){(_) in
            let helloScene = HelloScene(size: self.size)
            let doors = SKTransition.fade(with: SKColor.black, duration: 0.5)
            self.view?.presentScene(helloScene, transition: doors)
        }
        tryAgain.addAction(restartAction)
        self.view?.window?.rootViewController?.present(tryAgain, animated: true, completion: nil)
    }
    func createScene(){
        let bgd = SKSpriteNode(imageNamed: "gameoverbgd.jpg")
        bgd.size.width = self.size.width
        bgd.size.height = self.size.height
        bgd.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        bgd.zPosition = -1
        
        let gameoverlabel = SKLabelNode(text: "You loss !!")
        gameoverlabel.name = "overlabel"
        gameoverlabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY+50)
        gameoverlabel.fontName = "Avenir-Oblique"
        gameoverlabel.fontSize = 30
        
        
        
        self.addChild(bgd)
        self.addChild(gameoverlabel)
    }
}
