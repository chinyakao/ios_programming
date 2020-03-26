//
//  ThirdViewController.swift
//  navgationPopPush
//
//  Created by mac23 on 2020/3/19.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBAction func toNext(_ sender: UIButton) {
        let mystoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mystoryBoard.instantiateViewController(withIdentifier: "forthVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Back(_ sender: UIButton) {
        guard (self.navigationController?.popViewController(animated: true)) != nil else{
            print("no nav controller")
            return
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"cat.jpg")!)
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
