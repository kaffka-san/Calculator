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
        calc.isFirstNum = true
        resultTextLabel.text = "0"
    }
   
    @IBAction func numberPressed(_ sender: UIButton) {
        if calc.isFirstNum{
            if let str = sender.titleLabel?.text {
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

    }
    @IBAction func signButtonPressed(_ sender: UIButton) {
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
    @IBAction func operationButtonPressed(_ sender: UIButton) {
       
        if let operationSign = sender.titleLabel?.text{
            switch operationSign {
            case "×" :
                calc.operationPressed = Calculator.operation.multiply
            case "-" :
                calc.operationPressed = Calculator.operation.minus
            case "+" :
                calc.operationPressed = Calculator.operation.plus
               
            case "÷":
                calc.operationPressed = Calculator.operation.divide      
            default:
                calc.operationPressed = Calculator.operation.none
            }
        }
        if calc.chainOperationCheck(){
            resultTextLabel.text = calc.getResult()
        }
        calc.isFirstNum = false
     
    }
    

    
    @IBAction func getResultPressed(_ sender: UIButton) {
        resultTextLabel.text = calc.getResult()
    }
}

