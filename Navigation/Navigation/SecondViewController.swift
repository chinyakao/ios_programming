//
//  SecondViewController.swift
//  Navigation
//
//  Created by mac23 on 2020/3/18.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func backToMain(_ sender: UIButton) {
        if let vc =  storyboard?.instantiateViewController(withIdentifier:"ViewController"){
            show(vc, sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "2nd VC"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
