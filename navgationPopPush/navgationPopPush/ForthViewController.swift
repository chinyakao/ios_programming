//
//  ForthViewController.swift
//  navgationPopPush
//
//  Created by mac23 on 2020/3/19.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController {

    @IBAction func toNext(_ sender: UIButton) {
        guard (self.navigationController?.popToRootViewController(animated: true)) != nil else{
            print("no nav controller")
            return
        }
    }
    @IBAction func Back(_ sender: UIButton) {
        guard (self.navigationController?.popViewController(animated: true)) != nil else{
            print("no nav controller")
            return
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
