//
//  ViewController.swift
//  Gesture
//
//  Created by mac23 on 2020/4/29.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        for i in 0..<sender.numberOfTouches{
            let point = sender.location(ofTouch: i, in: sender.view)
            print("Tap\n第 \(i)根手指座標為(\(point.x),\(point.y))")
        }
    }
    @IBAction func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .changed:
            // scale > 1 是放大
            // scale < 1 是縮小
            print("Pinch\n\(sender.scale)")
        default:
            break
        }
    }
    @IBAction func handleRotationGesture(_ sender: UIRotationGestureRecognizer) {
        let rad = Float(sender.rotation)
        let deg = rad * 180 / Float(Double.pi)
        
        if deg >= 0 {
            print("順時針")
        } else{
            print("逆時針")
        }
        print("弧度: \(rad) 角度:\(deg)")
    }
    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.right:
            print("向右滑")
        case UISwipeGestureRecognizer.Direction.left:
            print("向左滑")
        default:
            break
        }
    }
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        for i in 0 ..< sender.numberOfTouches{
            let point = sender.location(ofTouch: i, in: sender.view)
            print("Pan\n第 \(i)根手指座標為(\(point.x), \(point.y))")
        }
    }
    @IBAction func handleLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        for i in 0..<sender.numberOfTouches{
            let point = sender.location(ofTouch: i, in: sender.view)
            print("LongPress\n第 \(i)根手指座標為(\(point.x),\(point.y))")
        }
    }
    @IBAction func handleEdgepanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        for i in 0 ..< sender.numberOfTouches{
            let point = sender.location(ofTouch: i, in: sender.view)
            print("EdgePan\n第 \(i)根手指座標為(\(point.x),\(point.y))")
        }
    }
    

}

