//
//  ViewController.swift
//  navgationPopPush
//
//  Created by mac23 on 2020/3/19.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    func createGradientLayer(){
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.blue.cgColor]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func toSecond(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "secondVC"){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func toThird(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "thirdVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientLayer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

