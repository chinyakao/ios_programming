//
//  ViewController.swift
//  Queues
//
//  Created by mac23 on 2020/5/13.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

var inactiveQueue: DispatchQueue!
let globalQueue = DispatchQueue.global(qos: .userInitiated)

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        simpleQueues()
//        queuesWithQos()
//        concurrentQueues()
//        print("It's going to start")
//        if let queue = inactiveQueue{
//            queue.activate()
//        }
//        queueWithDelay()
//        globalQueues()
        fetchImage()
    }
//    func simpleQueues() {
//        let queue = DispatchQueue(label: "simpleQueue")
//        queue.async{
//            for i in 0..<10{
//                print("aaa: ", i)
//            }
//        }
//        for i in 100..<110{
//            print("bbb: ", i)
//        }
//    }
    
    
//    func queuesWithQos(){
//        let queue1 = DispatchQueue(label: "queue1", qos: DispatchQoS.background)
//        let queue2 = DispatchQueue(label: "queue2", qos: DispatchQoS.unspecified)
//        queue1.async {
//            for i in 0..<10{
//                print("⚫️", i)
//            }
//        }
//        queue2.async {
//            for i in 100..<110{
//                print("🔴", i)
//            }
//        }
//        for i in 1000..<1010{
//            print("🔵", i)
//        }
//    }
    
//    func concurrentQueues(){
////        let anotherQueue = DispatchQueue(label: "anotherQueue", qos: .utility, attributes: .concurrent)
//        let anotherQueue = DispatchQueue(label: "anotherQueue", qos: .utility, attributes: [.concurrent, .initiallyInactive])
//        inactiveQueue = anotherQueue
//        anotherQueue.async {
//            for i in 0..<10{
//                print("🔴", i)
//            }
//        }
//
//        anotherQueue.async {
//            for i in 100..<110{
//                print("🔵", i)
//            }
//        }
//        anotherQueue.async {
//            for i in 1000..<1010{
//                print("⚫️", i)
//            }
//        }
//    }
    
//    func queueWithDelay(){
//        let delayQueue = DispatchQueue(label: "delayqueue", qos: .userInitiated)
//        print(Date())
//        let additionalTime: DispatchTimeInterval = .seconds(2)
//        delayQueue.asyncAfter(deadline: .now() + additionalTime){
//            print(Date())
//        }
//    }
    
//    func globalQueues () {
//        globalQueue.async {
//            for i in 0..<10{
//                print("🔴", i)
//            }
//        }
//        DispatchQueue.main.async{
//            for i in 100..<110{
//                print("🔵", i)
//            }
//        }
//    }
    
    func fetchImage() {
        let imageURL: URL = URL(string: "https://m.metro.taipei/img/routemap2020.png")!
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: {(imageData, response, error) in
            if let data = imageData{
                print("Did download image data")
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
            }).resume()
    }
}

