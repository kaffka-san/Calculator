//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var calc = Calculator()
    var maxInputCount = 12
    @IBOutlet weak var resultTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if resultTextLabel.text?.count ?? 0 >= maxInputCount{
            return
        }
        
        calc.numberEntered(sender.titleLabel?.text ?? "", maxInputCount)
        resultTextLabel.text = calc.getResult()
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        var currentOperation = operation.none
        if let enteredOperation = sender.titleLabel?.text{
            switch enteredOperation {
            case "×" :
                currentOperation = operation.multiply
            case "-" :
                currentOperation = operation.minus
            case "+" :
                currentOperation = operation.plus
            case "÷":
                currentOperation = operation.divide
                
            case "AC":
                currentOperation = operation.clear
            case "%":
                currentOperation = operation.percent
            case "+/-":
                currentOperation = operation.sign
            case "=":
                currentOperation = operation.compute
                
            default:
                currentOperation = operation.none
            }
        }
        
        if currentOperation != operation.none{
            calc.operationEntered(operationName: currentOperation)
            resultTextLabel.text = calc.getResult()
        }
    }
}

