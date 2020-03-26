//
//  secondViewController.swift
//  0318_ios_practice
//
//  Created by mac23 on 2020/3/18.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    var receiveStr: String? = nil
    var sendBackStr: String? = nil
    
    @IBOutlet weak var secondLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let str = receiveStr{
            secondLabel.text = str
        }
        sendBackStr = "Back from second View"
        
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
