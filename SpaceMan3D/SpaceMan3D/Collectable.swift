//
//  Collectable.swift
//  SpaceMan3D
//
//  Created by mac23 on 2020/6/3.
//  Copyright © 2020 mac23. All rights reserved.
//

import SceneKit
import Foundation

class Collectable {
    class func pyramidNode() -> SCNNode {
        let pyramid = SCNPyramid(width: 31.6, height: 20, length: 30)
        let pyramidNode = SCNNode(geometry: pyramid)
        pyramidNode.name = "pyramid"
        let position = SCNVector3Make(30, 0, -40)
        pyramidNode.position = position
//        pyramidNode.geometry?.firstMaterial?.transparency = 0.5
//        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = "boxSide3"
        pyramidNode.geometry?.firstMaterial?.shininess = 1.0
        return pyramidNode
    }
    class func sphereNode() -> SCNNode {
        let sphere = SCNSphere(radius: 30.0)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.name = "sphere"
        let position = SCNVector3(0, 40, -100)
        sphereNode.position = position
        sphereNode.geometry?.firstMaterial?.diffuse.contents = "earthDiffuse"
        let action = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 10, z: 0, duration: 5))
        sphereNode.runAction(action)
        return sphereNode
    }
    class func boxNode() -> SCNNode {
        let box = SCNBox(width: 6, height: 6, length: 6, chamferRadius: 0)
        let boxNode = SCNNode(geometry: box)
        boxNode.name = "box"
        let position = SCNVector3Make(30, 10, 20)
        boxNode.position = position
        boxNode.geometry?.firstMaterial?.diffuse.contents = "boxSide2"
        boxNode.geometry?.firstMaterial?.shininess = 1.0
        return boxNode
    }
    class func tubeNode () -> SCNNode{
        let tube = SCNTube(innerRadius: 8, outerRadius: 10.0, height: 30.0)
        let tubeNode = SCNNode(geometry: tube)
        tubeNode.name = "tube"
        let position = SCNVector3Make(-50, 20, 0)
        tubeNode.position = position
        tubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        tubeNode.geometry?.firstMaterial?.shininess = 1.0
        return tubeNode
    }
    class func cylinderNode() -> SCNNode {
        let cylinder = SCNCylinder(radius: 6, height: 30)
        let cylinderNode = SCNNode(geometry: cylinder)
        cylinderNode.name = "cylinder"
        let position = SCNVector3Make(30, 15, 50)
        cylinderNode.position = position
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = "boxSide4"
        cylinderNode.geometry?.firstMaterial?.shininess = 1.0
        return cylinderNode
    }
    class func torusNode() -> SCNNode {
        let torus = SCNTorus(ringRadius: 12, pipeRadius: 5)
        let torusNode = SCNNode(geometry: torus)
        torusNode.name = "torus"
        let position = SCNVector3Make(-40, 15, 50)
        torusNode.position = position
        torusNode.geometry?.firstMaterial?.diffuse.contents = "boxSide4"
        torusNode.geometry?.firstMaterial?.shininess = 1.0
        return torusNode
    }
    class func icecreamNode() -> SCNNode {
        let cone = SCNCone(topRadius: 3, bottomRadius: 0, height: 10)
        let coneNode = SCNNode(geometry: cone)
        coneNode.name = "cone"
        let position = SCNVector3Make(10, 5, 0)
        coneNode.position = position
//        coneNode.geometry?.firstMaterial?.diffuse.contents = "boxSide4"
        coneNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        coneNode.geometry?.firstMaterial?.shininess = 1.0
//        let action = SCNAction.repeatForever(SCNAction.rotateBy(x: 3, y: 3, z: 0, duration: 1))
//        coneNode.runAction(action)
        
        let cream = SCNSphere(radius: 3.0)
        let creamNode = SCNNode(geometry: cream)
        creamNode.name = "cream"
        let cream_position = SCNVector3(0, 6, 0)
        creamNode.position = cream_position
        creamNode.geometry?.firstMaterial?.diffuse.contents = "ImageA"
        
        let cream1 = SCNSphere(radius: 3.0)
        let creamNode1 = SCNNode(geometry: cream1)
        creamNode1.name = "cream1"
        let cream_position1 = SCNVector3(0, 10, 0)
        creamNode1.position = cream_position1
        creamNode1.geometry?.firstMaterial?.diffuse.contents = "ImageA"
        
        let sphere = SCNSphere(radius: 30.0)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.name = "sphere"
        let s_position = SCNVector3(0, 40, -100)
        sphereNode.position = s_position
        sphereNode.geometry?.firstMaterial?.diffuse.contents = "earthDiffuse"
        let s_action = SCNAction.rotateBy(x: 0, y: 0, z: 0, duration: 5)
        sphereNode.runAction(s_action)
        
//        coneNode.addChildNode(sphereNode)
        coneNode.addChildNode(creamNode1)
        coneNode.addChildNode(creamNode)
        
        return coneNode
    }
}
