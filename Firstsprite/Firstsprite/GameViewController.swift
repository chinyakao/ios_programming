//
//  GameViewController.swift
//  Firstsprite
//
//  Created by mac23 on 2020/4/1.
//  Copyright © 2020 mac23. All rights reserved.
//

import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
    }
}
