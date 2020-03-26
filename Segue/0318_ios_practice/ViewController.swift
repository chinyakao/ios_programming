//
//  ViewController.swift
//  0318_ios_practice
//
//  Created by mac23 on 2020/3/18.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!
    @IBAction func unwindSegue(for segue:UIStoryboardSegue){
        if segue.identifier == "unwind_segue"{
            let vc = segue.source as! secondViewController
            if let str = vc.sendBackStr{
                firstLabel.text = str
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_1to2"{
            let vc = segue.destination as? secondViewController
            vc!.receiveStr = "Hello, secondView"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

