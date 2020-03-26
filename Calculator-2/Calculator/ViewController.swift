//
//  ViewController.swift
//  Calculator
//
//  Created by evan on 2020/2/27.
//  Copyright © 2020 evan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var InTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if InTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else{
            display.text = digit
            InTheMiddleOfTyping = true
        }
    }
    
    var operand1 = 0.0
    var symbolOfOperation = ""
    
    @IBAction func performOperation(_ sender: UIButton) {
        let Operation = sender.currentTitle!
        switch Operation{
        case "AC":
            display.text = "0"
            InTheMiddleOfTyping = false
        case "√":
            let operand = Double(display.text!)!
            display.text = String(sqrt(operand))
            InTheMiddleOfTyping = false
        case "+":
            operand1 = Double(display.text!)!
            InTheMiddleOfTyping = false
            symbolOfOperation = "+"
        case "-":
            operand1 = Double(display.text!)!
            InTheMiddleOfTyping = false
            symbolOfOperation = "-"
        case "×":
            operand1 = Double(display.text!)!
            InTheMiddleOfTyping = false
            symbolOfOperation = "×"
        case "÷":
            operand1 = Double(display.text!)!
            InTheMiddleOfTyping = false
            symbolOfOperation = "÷"
        case "%":
            operand1 = Double(display.text!)!
            InTheMiddleOfTyping = false
            symbolOfOperation = "%"
        case "±":
            let operand = Double(display.text!)!
            display.text = String(-operand)
        case "=":
            if(symbolOfOperation != ""){
                let operand2 = Double(display.text!)!
                switch symbolOfOperation{
                case "+":
                    display.text = String(operand1 + operand2)
                case "-":
                    display.text = String(operand1 - operand2)
                case "×":
                    display.text = String(operand1 * operand2)
                case "÷":
                    display.text = String(operand1 / operand2)
                case "%":
                    display.text = String(Int(operand1) % Int(operand2))
                default:
                    break
                }
                InTheMiddleOfTyping = false
                symbolOfOperation = ""
            }
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

