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
    var musics = [URL]()
    var count = 0
    
    @IBOutlet weak var songLength: UILabel!
    @IBOutlet weak var songVolumeSlider: UISlider!
    @IBOutlet weak var songProgressSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let music = Bundle.main.url(forResource: "how have you been", withExtension: "mp3")!
        musics.append(Bundle.main.url(forResource: "how have you been", withExtension: "mp3")!)
        musics.append(Bundle.main.url(forResource: "Whistle", withExtension: "mp3")!)
        
        songVolumeSlider.value = player.volume
        
//        let playerItem = AVPlayerItem(url: music)
        let playerItem = AVPlayerItem(url: musics[count])
        player.replaceCurrentItem(with: playerItem)
        let duration = playerItem.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        songLength.text = formatConversion(time: 0)
        songProgressSlider.minimumValue = 0
        songProgressSlider.maximumValue = Float(seconds)
        
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: {(CMTime) in let currentTime = CMTimeGetSeconds(self.player.currentTime())
            self.songProgressSlider.value = Float(currentTime)
            self.songLength.text = self.formatConversion(time: currentTime)
        })
        player.play()
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
    }
    
    @objc func playerItemDidReachEnd(notification: Notification){
        if let playerItem = notification.object as? AVPlayerItem{
            playerItem.seek(to: CMTime.zero)
        }
    }
    
    @IBAction func previous(_ sender: UIButton) {
        count-=1
        if count < 0{
            count = musics.count - 1
        }
        let playerItem = AVPlayerItem(url: musics[count])
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    @IBAction func next(_ sender: UIButton) {
        count+=1
        if count >= musics.count{
            count = 0
        }
        let playerItem = AVPlayerItem(url: musics[count])
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    @IBAction func pause(_ sender: UIButton) {
        player.pause()
    }
    @IBAction func play(_ sender: UIButton) {
        player.play()
    }
    @IBAction func musicVolume(_ sender: UISlider) {
        player.volume = sender.value
    }
    @IBAction func changeCurrentTime(_ sender: UISlider) {
        let seconds = Int64(songProgressSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
    }
    func formatConversion(time: Float64) -> String {
        let songLength = Int(time)
        let minutes = Int(songLength / 60)
        let seconds = Int(songLength % 60)
        
        var time = ""
        if minutes < 10 {
            time = "0\(minutes):"
        }else{
            time = "\(minutes)"
        }
        if seconds < 10 {
            time += "0\(seconds)"
        }else{
            time += "\(seconds)"
        }
        return time
    }
    

}

