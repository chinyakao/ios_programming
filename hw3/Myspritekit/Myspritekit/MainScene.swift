import UIKit
import SpriteKit

class MainScene: SKScene, SKPhysicsContactDelegate {
    var score = 0
    var lblScore: SKLabelNode!
    override func didMove(to view: SKView){
       
        self.physicsWorld.contactDelegate = self
        createScene()
        let panrecognizer = UIPanGestureRecognizer(target: self, action: #selector(handpan))
        view.addGestureRecognizer(panrecognizer)
    }
    func createScene() {
        let mainbgd = SKSpriteNode(imageNamed: "mainbgd.png")
        mainbgd.size.width = self.size.width
        mainbgd.size.height = self.size.height
        mainbgd.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        mainbgd.zPosition = -1
        
        let spaceship = newSpaceship()
        spaceship.position = CGPoint(x:self.frame.midX, y:self.frame.midY-150)
        
        lblScore = SKLabelNode(fontNamed: "Avenir-Oblique")
        lblScore.fontSize = 30
        lblScore.fontColor = SKColor.white
        lblScore.position = CGPoint(x: self.frame.midX-100, y: self.frame.midY-400)
        lblScore.zPosition = 1000
        lblScore.text = "Score: " + String(score)
        
        self.addChild(mainbgd)
        self.addChild(spaceship)
        self.addChild(lblScore)
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(newRock), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(newCoin), userInfo: nil, repeats: true)
        
    }
  
    func newSpaceship() -> SKSpriteNode{
        let ship = SKSpriteNode(imageNamed: "spaceship.png")
        ship.size = CGSize(width: 75, height: 75)
        ship.name = "ships"
        
        let leftlight = newLight()
        leftlight.position = CGPoint(x: -20, y: 6)
        ship.addChild(leftlight)
        
        let rightlight = newLight()
        rightlight.position = CGPoint(x:20, y: 6)
        ship.addChild(rightlight)

        ship.physicsBody = SKPhysicsBody(circleOfRadius: ship.size.width/2)
        ship.physicsBody?.usesPreciseCollisionDetection = true
        ship.physicsBody?.isDynamic = false
        ship.physicsBody?.categoryBitMask = 0x1 << 1
        ship.physicsBody?.contactTestBitMask = 0x1 << 2
        
        return ship
    }
    func newLight() -> SKShapeNode {
        let light = SKShapeNode()
        light.path = CGPath(rect: CGRect(x: -2, y: -4, width: 4, height: 8), transform: nil)
        light.strokeColor = SKColor.white
        light.fillColor = SKColor.yellow
        
        let blink = SKAction.sequence([SKAction.fadeOut(withDuration: 0.25),SKAction.fadeIn(withDuration: 0.25)
        ])
        let blinkForever = SKAction.repeatForever(blink)
        light.run(blinkForever)
        return light
    }
    @objc func newRock(){
        let rock = SKSpriteNode(imageNamed: "rock.png")
        rock.size = CGSize(width: 40, height: 40)
        let remove = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent()])
        let w = self.size.width
        let h = self.size.height
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        rock.position = CGPoint(x: x, y:h)
        rock.name = "rocks"
        rock.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        rock.physicsBody?.usesPreciseCollisionDetection = true
        rock.run(remove)
        self.addChild(rock)
    }
    @objc func newCoin(){
        let coin = SKSpriteNode(imageNamed: "coin.png")
        coin.size = CGSize(width: 30, height: 30)
        let remove = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent()])
        let w = self.size.width
        let h = self.size.height
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        coin.position = CGPoint(x: x, y:h)
        coin.name = "coins"
        coin.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.run(remove)
        self.addChild(coin)
    }
    @objc func handpan(recognizer: UIPanGestureRecognizer){
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        let moveAction = SKAction.moveTo(x: sceneLocation.x, duration: 0.1)
        self.childNode(withName: "ships")!.run(moveAction)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        if contact.bodyA.node?.name == "ships"{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.node?.name == "ships" && secondBody.node?.name == "rocks"){
            let gameoverScene = GameOverScene(size: self.size)
            gameoverScene.finalScore = score
            let doors = SKTransition.fade(with: SKColor.black, duration: 0.5)
            self.view?.presentScene(gameoverScene, transition: doors)

        }else if(firstBody.node?.name == "ships" && secondBody.node?.name == "coins"){
            score = score + 100
            lblScore.text = "Score: " + String(score)
            print("Get point 100 !\n")
        }
    }
    // save score to next scene

}
