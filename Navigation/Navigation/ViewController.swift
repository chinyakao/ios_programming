//
//  ViewController.swift
//  Navigation
//
//  Created by mac23 on 2020/3/18.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func toSecondView(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController"){
            show(vc, sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首頁"
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }


}

