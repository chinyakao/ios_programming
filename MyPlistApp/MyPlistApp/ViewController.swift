//
//  ViewController.swift
//  MyPlistApp
//
//  Created by mac23 on 2020/4/22.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var path:String = ""
    @IBOutlet weak var chgLabel: UILabel!
    @IBAction func chgtoRed(_ sender: UIButton) {
        if let plist = NSMutableDictionary(contentsOfFile: path){
            plist["Color"] = "Red"
            if let color = plist["Color"]{
                if plist.write(toFile: path, atomically: true){
                    chgLabel.text = "the color is changed to \(color)"
                }
                
            }
        }
    }
    @IBAction func chgtoGreen(_ sender: UIButton) {
        if let plist = NSMutableDictionary(contentsOfFile: path){
            plist["Color"] = "Green"
            if let color = plist["Color"]{
                if plist.write(toFile: path, atomically: true){
                    chgLabel.text = "the color is changed to \(color)"
                }
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        path = NSHomeDirectory() + "/Documents/Property List.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path){
            if let color = plist["Color"]{
                chgLabel.text = "the color is \(color)"
            }
        }
    }


}

