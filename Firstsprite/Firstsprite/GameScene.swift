import SpriteKit

class GameScene: SKScene{
    let label = SKLabelNode(text: "hello world !")
    var txtchange: Bool = false
    
    override func didMove(to view: SKView) {
        label.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        label.fontSize = 45
        label.fontColor = SKColor.red
        label.fontName = "Avenir"
        label.speed = 5
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        let doubletaprecognizer = UITapGestureRecognizer(target: self, action: #selector(doubletap))
        doubletaprecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(recognizer)
        view.addGestureRecognizer(doubletaprecognizer)
        addChild(label)
    }
    
    @objc func tap(recognizer: UITapGestureRecognizer){
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        let moveToAction = SKAction.move(to: sceneLocation, duration: 1)
        label.run(moveToAction)
    }
    @objc func doubletap(doubletaprecognizer: UIGestureRecognizer){
        if txtchange == false{
            label.text = "I ❤️ SpiteKit"
            txtchange = true
        }
        else{
            label.text = "Hello world !"
            txtchange = false
        }
    }
}
