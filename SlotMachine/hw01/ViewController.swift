//
//  ViewController.swift
//  hw01
//
//  Created by mac23 on 2020/3/18.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var score = 0
    var symbol = [String]()
    var col1 = [Int]()
    var col2 = [Int]()
    var col3 = [Int]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 100
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        if component == 0 {
            pickerLabel.text = symbol[(Int)(col1[row])]
        } else if component == 1 {
            pickerLabel.text = symbol[(Int)(col2[row])]
        } else {
            pickerLabel.text = symbol[(Int)(col3[row])]
        }
        
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.center
     
        return pickerLabel
    }
    @IBAction func buttonClicked(sender: AnyObject) {
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 2, animated: true)
     
        if(col1[pickerView.selectedRow(inComponent: 0)] == col2[pickerView.selectedRow(inComponent: 1)] &&
            col2[pickerView.selectedRow(inComponent: 1)] == col3[pickerView.selectedRow(inComponent: 2)]) {
            
            score = score + 10
            scoreLabel.text = String(score)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        symbol = ["🍎","🍐","🍊","🍋","🍉","🍇"]
        for _ in 1...100{
            col1.append((Int)(arc4random() % 6))
            col2.append((Int)(arc4random() % 6))
            col3.append((Int)(arc4random() % 6))

        }
        scoreLabel.text = String(score)
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        func login(){
            let alert = UIAlertController(title: "登入", message: "請輸入帳號密碼", preferredStyle:.alert)
            let tryAgain = UIAlertController(title: "", message: "", preferredStyle:.alert)
            alert.addTextField {(textField) in
                textField.placeholder = "Account"
            }
            alert.addTextField {(textField) in
                textField.placeholder = "Password"
                textField.isSecureTextEntry = true
            }
            
            let loginAction = UIAlertAction(title: "登入", style: .default){(_) in
                let account = alert.textFields?[0].text
                let password = alert.textFields?[1].text
                if account == "" {
                    tryAgain.message = "帳號不可空白"
                    self.present(tryAgain, animated: true, completion: nil)
                }
                else if password == "" {
                    tryAgain.message = "密碼不可空白"
                    self.present(tryAgain, animated: true, completion: nil)
                }else{
                    self.titleLabel.text = "您好, " + account!
                }
                
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel){(_) in
                tryAgain.message = "請輸入帳號密碼"
                self.present(tryAgain, animated: true, completion: nil)
            }
            let tryAgainAction = UIAlertAction(title: "OK", style: .default){(_) in
                self.present(alert, animated: true, completion:nil)
            }
            alert.addAction(cancelAction)
            alert.addAction(loginAction)
            tryAgain.addAction(tryAgainAction)
            
            
            self.present(alert, animated: true, completion:nil)
        }
        login()
        titleLabel.text = "您好"
    }


}

