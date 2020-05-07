//
//  ViewController.swift
//  videoPlayer
//
//  Created by mac23 on 2020/5/7.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
 
class ViewController: UIViewController {
    let player = AVPlayer()
    var videos = [URL]()
    var count = 0
//    若是暫停換下一首 會直接開始播 但是bool值沒改到
    var playornot = true
    
    @IBOutlet weak var ProgressLabel: UILabel!
    @IBOutlet weak var ProgressSlider: UISlider!
    @IBOutlet weak var VolumeSlider: UISlider!
    @IBOutlet weak var VolumeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videos.append(Bundle.main.url(forResource: "CaptainMarvel", withExtension: "mp4")!)
        videos.append(Bundle.main.url(forResource: "TheFastAndTheFurious", withExtension: "mp4")!)
        videos.append(Bundle.main.url(forResource: "Wreck-ItRalph", withExtension: "mp4")!)

        VolumeSlider.value = player.volume
        VolumeLabel.text = String(Int(player.volume * 100))
        
        let playerItem = AVPlayerItem(url: videos[count])
        player.replaceCurrentItem(with: playerItem)
        
        let duration = playerItem.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        ProgressLabel.text = formatConversion(time: 0)
        ProgressSlider.minimumValue = 0
        ProgressSlider.maximumValue = Float(seconds)
        
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: {(CMTime) in let currentTime = CMTimeGetSeconds(self.player.currentTime())
                   self.ProgressSlider.value = Float(currentTime)
                   self.ProgressLabel.text = self.formatConversion(time: currentTime)
               })
        

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        
        //开始播放
        player.play()
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification){
       if let playerItem = notification.object as? AVPlayerItem{
        
        let targetTime: CMTime = CMTimeMake(value: 0, timescale: 1)
        playerItem.seek(to: targetTime)
       }
    }
    
    @IBAction func videoVolume(_ sender: UISlider) {
        player.volume = sender.value
        VolumeLabel.text = String(Int(player.volume * 100))
    }
    @IBAction func previous(_ sender: UIButton) {
        count-=1
        if count < 0{
            count = videos.count - 1
        }
        let playerItem = AVPlayerItem(url: videos[count])
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    @IBAction func next(_ sender: UIButton) {
        count+=1
        if count >= videos.count{
            count = 0
        }
        let playerItem = AVPlayerItem(url: videos[count])
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    @IBAction func playPause(_ sender: UIButton) {
        if(playornot){
            player.pause()
            playornot = false
        }else{
            player.play()
            playornot = true
        }
        
    }
    @IBAction func changeCurrentTime(_ sender: UISlider) {
        let seconds = Int64(ProgressSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
    }
    @IBAction func back5s(_ sender: UIButton) {
        let seconds = Int64(ProgressSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds-5, timescale: 1)
        player.seek(to: targetTime)
    }
    @IBAction func forward5s(_ sender: UIButton) {
        let seconds = Int64(ProgressSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds+5, timescale: 1)
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
