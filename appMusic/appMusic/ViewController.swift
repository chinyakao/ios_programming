//
//  ViewController.swift
//  appMusic
//
//  Created by mac23 on 2020/5/6.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let music = Bundle.main.url(forResource: "how have you been", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: music)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }


}

