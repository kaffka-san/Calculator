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
        // Do any additional setup after loading the view.
        calc.setToDefault()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if resultTextLabel.text?.count ?? 0 >= maxInputCount{
            return
        }
       
        resultTextLabel.text =  calc.numberEntered(number: sender.titleLabel?.text ?? "", maxInput: maxInputCount)
       /* if calc.isFirstNum{
            if let str = sender.titleLabel?.text{
                if  calc.resStringA.count < maxInputCount {
                    calc.resStringA.append(str)
                    resultTextLabel.text = calc.resStringA
                }
            }
        }
        else {
            
            if let str = sender.titleLabel?.text {
                if  calc.resStringB.count < maxInputCount {
                    calc.resStringB.append(str)
                    resultTextLabel.text = calc.resStringB
                }
            }
        }
        */
    }
  /*  @IBAction func signButtonPressed(_ sender: UIButton) {
        if calc.isFirstNum{
            calc.toogleSignA()
            resultTextLabel.text = calc.resStringA
        }
        else {
            calc.toogleSignB()
            resultTextLabel.text = calc.resStringB
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        resultTextLabel.text = "0"
        calc.setToDefault()
    }
    
    @IBAction func percentButtonPressed(_ sender: UIButton) {
        if calc.isFirstNum {
            calc.getPercentfromNumA()
            resultTextLabel.text = calc.resStringA
        }
        else {
            calc.getPercentfromNumB()
            resultTextLabel.text = calc.resStringB
        }
        
    }
   */
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
            case "+/-":
                currentOperation = operation.sign
            case "AC":
                currentOperation = operation.clear
            case "%":
                currentOperation = operation.percent
                
            default:
                currentOperation = operation.none
            }
        }
        if currentOperation != operation.none{
            calc.operationEntered(operationName: currentOperation)
            resultTextLabel.text = calc.getResult(isResultPressed: false)
        }
        /*
        if calc.chainOperationCheck(){
            resultTextLabel.text = calc.getResult()
        }
        calc.isFirstNum = false
        */
    }
    
    
    
    @IBAction func getResultPressed(_ sender: UIButton) {
        resultTextLabel.text = calc.getResult(isResultPressed: true)
    }
}

