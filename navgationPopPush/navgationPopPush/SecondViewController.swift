//
//  SecondViewController.swift
//  navgationPopPush
//
//  Created by mac23 on 2020/3/19.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    func createGradientLayer()
    {
        gradientLayer.startPoint = CGPoint(x:0, y:0)
        gradientLayer.endPoint = CGPoint(x:1, y:1)
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.green.cgColor]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func toNext(_ sender: UIButton) {
        let mystoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mystoryBoard.instantiateViewController(withIdentifier: "thirdVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Back(_ sender: UIButton) {
        guard (self.navigationController?.popViewController(animated: true)) != nil else{
            print("no nav controller")
            return
        }
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           createGradientLayer()
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
