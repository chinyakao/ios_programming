//
//  GameViewController.swift
//  SpaceMan3D
//
//  Created by mac23 on 2020/6/3.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import CoreMotion

class GameViewController: UIViewController, SCNSceneRendererDelegate, SCNPhysicsContactDelegate {
    var sceneView: SCNView!
    var mainScene: SCNScene!
    var cameraNode: SCNNode!
    var touchCount: Int?
    var motionManager: CMMotionManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScene = createMainScene()
        createMainCamera()
        sceneView = self.view as? SCNView
        sceneView.scene = mainScene
        sceneView.backgroundColor = UIColor.black
        sceneView.showsStatistics = true
//        sceneView.allowsCameraControl = true
        
        sceneView.delegate = self
        
        
        setupHeroBody()
        
        /*// create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        // animate the 3d object
        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let taps = event?.allTouches
        touchCount = taps?.count
        print(touchCount!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCount = 0
        print(touchCount!)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        let moveDistance = Float(10.0)
        let moveSpeed = TimeInterval(1.0)
        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)
        let currentX = heroNode?.position.x
        let currentY = heroNode?.position.y
        let currentZ = heroNode?.position.z
        if touchCount == 1 {
            let action = SCNAction.move(to: SCNVector3(currentX!, currentY!, currentZ! - moveDistance), duration: moveSpeed)
            heroNode?.runAction(action)
        }else if touchCount == 2 {
            let action = SCNAction.move(to: SCNVector3(currentX!, currentY!, currentZ! + moveDistance), duration: moveSpeed)
            heroNode?.runAction(action)
        }else if touchCount == 4 {
            let action = SCNAction.move(to: SCNVector3(0,0,0), duration: moveSpeed)
            heroNode?.runAction(action)
        }
    }
    
    func setupHeroBody() {
        let heroNode = mainScene?.rootNode.childNode(withName: "hero", recursively: true)
        heroNode?.position = SCNVector3(x:0, y:10, z:0)
        heroNode?.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        heroNode?.physicsBody?.isAffectedByGravity = false
        heroNode?.physicsBody?.categoryBitMask = CollisionCategoryHero
        heroNode?.physicsBody?.contactTestBitMask = CollisionCategoryCollectibleLowValue | CollisionCategoryCollectibleMidValue | CollisionCategoryCollectibleHighValue | CollisionCategoryEnemy
    }
    
    func setupAccelerometer(){
        motionManager = CMMotionManager()
        if motionManager.isAccelerometerActive{
            motionManager.accelerometerUpdateInterval = 1/60.0
            motionManager.startAccelerometerUpdates(to: OperationQueue.main){(data, error)
                in
                let heroNode = self.mainScene.rootNode.childNode(withName: "hero", recursively: true)?.presentation
                let currentX = heroNode?.position.x
                let currentY = heroNode?.position.y
                let currentZ = heroNode?.position.z
                let threshold = 0.20
                
                if (data?.acceleration.y)! < -threshold {
                    let destinationX = (Float((data?.acceleration.y)!) * 10.0 + Float(currentX!))
                    let destinationY = Float(currentY!)
                    let destinationZ = Float(currentZ!)
                    let aciton = SCNAction.move(to: SCNVector3(destinationX, destinationY, destinationZ), duration: 1)
                    heroNode?.runAction(aciton)
                }
                
            }
        }
    }
    
    func createMainCamera(){
        cameraNode = SCNNode()
        cameraNode.name = "mainCamera"
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 1000
        cameraNode.position = SCNVector3(x: 0, y: 15, z: 50)
        mainScene.rootNode.childNode(withName: "hero", recursively: true)?.addChildNode(cameraNode)
    }
    
    func createMainScene() -> SCNScene{
        let mainScene = SCNScene(named: "art.scnassets/hero.dae")
        mainScene!.rootNode.addChildNode(createFloorNode())
        mainScene?.rootNode.addChildNode(createEnemy())
        mainScene!.rootNode.addChildNode(Collectable.pyramidNode())
        mainScene!.rootNode.addChildNode(Collectable.sphereNode())
        mainScene!.rootNode.addChildNode(Collectable.boxNode())
        mainScene!.rootNode.addChildNode(Collectable.tubeNode())
        mainScene!.rootNode.addChildNode(Collectable.cylinderNode())
        mainScene!.rootNode.addChildNode(Collectable.torusNode())
    
        mainScene!.rootNode.addChildNode(Collectable.icecreamNode())
        setupLighting(mainScene!)
        mainScene?.physicsWorld.contactDelegate = self
        return mainScene!
    }
    func createFloorNode() -> SCNNode {
        let floorNode = SCNNode()
        floorNode.geometry = SCNFloor()
        floorNode.geometry?.firstMaterial?.diffuse.contents = "Floor"
        return floorNode
    }
    func createEnemy() -> SCNNode {
        let enemyScene = SCNScene(named: "art.scnassets/enemy.dae")
        let enemyNode = enemyScene!.rootNode.childNode(withName: "enemy", recursively: true)
        enemyNode!.name = "enemy"
        enemyNode!.position = SCNVector3(x: 40, y: 10, z: 30)
        enemyNode!.rotation = SCNVector4(x:0, y:1, z:0, w:Float(.pi/4/2.8))
        let action = SCNAction.repeatForever(SCNAction.sequence([SCNAction.rotateBy(x: 0, y: 10, z: 0, duration: 1), SCNAction.rotateBy(x: 0, y: -10, z: 0, duration: 1)]))
        enemyNode!.runAction(action)
        return enemyNode!
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    func setupLighting(_ scene: SCNScene) {
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light!.type = SCNLight.LightType.ambient
        ambientLight.light!.color = UIColor.gray
        scene.rootNode.addChildNode(ambientLight)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.spot
        lightNode.light!.castsShadow = true
        lightNode.light!.color = UIColor(white: 1, alpha: 1.0)
        lightNode.position = SCNVector3Make(30, 10, 15)
        lightNode.light!.spotInnerAngle = 0
        lightNode.light!.spotOuterAngle = 60
        lightNode.light!.zFar = 1000
        scene.rootNode.addChildNode(lightNode)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
