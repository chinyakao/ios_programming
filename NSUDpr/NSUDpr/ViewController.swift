//
//  ViewController.swift
//  NSUDpr
//
//  Created by mac23 on 2020/4/22.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userDefault : UserDefaults = UserDefaults.standard
    @IBOutlet weak var textName: UITextField!
    
    @IBAction func saveClick(_ sender: UIButton) {
        userDefault.set(textName.text, forKey: "userName")
        userDefault.synchronize()
        alertBtn("write data",  Message: "Data has been written !", BtnTitle: "Yes")
    }
    @IBAction func deleteClick(_ sender: UIButton) {
        userDefault.removeObject(forKey: "userName")
        textName.text = ""
        alertBtn("clear data", Message: "Data has been cleared !", BtnTitle: "Yes")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let name:String? = userDefault.object(forKey: "userName") as! String?
        if name == nil{
            alertBtn("Enter the name", Message: "welcom to this app !", BtnTitle: "Yes")
        }else{
            let msg:String = "Hello " + name!
            alertBtn("welcome", Message: msg, BtnTitle: "Yes")
        }
    }
    
    func alertBtn(_ Title: String, Message: String, BtnTitle:String){
        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let action = UIAlertAction(title: BtnTitle, style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }


}

