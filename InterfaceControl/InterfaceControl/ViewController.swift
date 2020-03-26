//
//  ViewController.swift
//  InterfaceControl
//
//  Created by mac23 on 2020/3/11.
//  Copyright © 2020 mac23. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    let fontName = ["Symbol", "Timess New Roman", "Zapfino", "Chalkduster"]
    let fontSize = ["20", "21","22", "23", "24", "25", "26"]
    var currentSize:CGFloat = 20.0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return fontName.count
        }
        return fontSize.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return fontName[row]
        }
        return fontSize[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            name.font = UIFont(name:fontName[row], size: currentSize)
            number.font = UIFont(name: fontName[row], size: currentSize)
        }else{
            currentSize = CGFloat(Double(fontSize[row])!)
            name.font = name.font.withSize(CGFloat(Double(fontSize[row])!))
            number.font = number.font.withSize(CGFloat(Double(fontSize[row])!))
        }
    }
    

    @IBOutlet weak var NTUST: UIImageView!
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numTextField: UITextField!
    
    @IBOutlet weak var alpha: UILabel!
    
    @IBOutlet weak var sliderValue: UISlider!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var pickView: UIPickerView!
    
    @IBAction func nameTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func bgTouchDown(_ sender: UIControl) {
        numTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    @IBAction func alphaSlider(_ sender: UISlider) {
        alpha.text = String(format: "%.1f", sender.value)
        NTUST.alpha = CGFloat(sender.value)
        NTUST.image = UIImage(named: "NTUST.jpg")
    }

    @IBAction func secureText(_ sender: UISwitch) {
        if sender.isOn{
            numTextField.isSecureTextEntry = true
        }else{
            numTextField.isSecureTextEntry = false
        }
    }
    
    @IBAction func segmentCtrl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            slider.isHidden = false
            `switch`.isHidden = false
            alpha.isHidden = false
        }else{
            slider.isHidden = true
            `switch`.isHidden = true
            alpha.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NTUST.contentMode = .scaleAspectFit
        NTUST.image = UIImage(named: "NTUST.jpg")
        alpha.text = String(format: "%.1f", sliderValue.value)
        
    }


}

