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
        calc.setToDefault()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if resultTextLabel.text?.count ?? 0 >= maxInputCount{
            return
        }
        
        resultTextLabel.text =  calc.numberEntered(number: sender.titleLabel?.text ?? "", maxInput: maxInputCount)
    }
    @IBAction func singleOperationButtonPressed(_ sender: UIButton) {
        var currentSymbolPressed = symbol.none
        if let enteredSymbol = sender.titleLabel?.text{
            switch enteredSymbol{
            case "AC":
                currentSymbolPressed = symbol.clear
            case "%":
                currentSymbolPressed = symbol.percent
            case "+/-":
                currentSymbolPressed = symbol.sign
            default:
                currentSymbolPressed = symbol.none
            }
        }
        if currentSymbolPressed != symbol.none{
            calc.symbolEntered(symbolName: currentSymbolPressed)
            resultTextLabel.text = calc.applySymbol()
        }
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
                
            default:
                currentOperation = operation.none
            }
        }
        if currentOperation != operation.none{
            calc.operationEntered(operationName: currentOperation)
            resultTextLabel.text = calc.getResult(isResultPressed: false)
        }
    }

    @IBAction func getResultPressed(_ sender: UIButton) {
        resultTextLabel.text = calc.getResult(isResultPressed: true)
    }
}

