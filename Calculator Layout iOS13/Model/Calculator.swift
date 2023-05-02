//
//  Calculator.swift
//  Calculator Layout iOS13
//
//  Created by Anastasia Lenina on 27.04.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
class Calculator {
    var resStringA : String = ""
    var resStringB : String = ""
    var isFirstNum : Bool = true
    let formatter = NumberFormatter()
    enum operation {
        case plus
        case minus
        case divide
        case multiply
        case none
        
    }
    func toogleSignA() {
        formatter.minimumFractionDigits = 0
        resStringA = String(formatter.string(from: (Float(resStringA)! * -1) as NSNumber)!)
    }
    func toogleSignB() {
        formatter.minimumFractionDigits = 0
        resStringB = String(formatter.string(from: (Float(resStringB)! * -1) as NSNumber)!)
    }
    var operationPressed : operation = .none
    
    func getResult() -> String {
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        isFirstNum = true
        var res = ""
        switch operationPressed {
        case .plus:
            if let a = Float(resStringA), let b = Float(resStringB) {
                res =  String(formatter.string(from:(a + b) as NSNumber) ?? "")
            }
            
        case .minus:
            if let a = Float(resStringA), let b = Float(resStringB) {
                res =  String(formatter.string(from:(a - b) as NSNumber) ?? "")
            }
        case .divide:
            if let a = Float(resStringA), let b = Float(resStringB) {
                res =  String(formatter.string(from:(a / b) as NSNumber) ?? "")
            }
        case .multiply:
            if let a = Float(resStringA), let b = Float(resStringB) {
                res =  String(formatter.string(from:(a * b) as NSNumber) ?? "")
                
            }
        case .none:
            return ""
        }
        setToDefault()
        resStringA  = res
        return res
    }
    func getPercentfromNumA(){
        formatter.minimumFractionDigits = -1
        
        let res = Float(resStringA)! / 100.0
        resStringA = String(formatter.string(from: res as NSNumber)!)
        
        
    }
    func getPercentfromNumB(){
        formatter.minimumFractionDigits = -1
        if let a = Float(resStringA), let b = Float(resStringB){
            let res = a * b / 100.0
            resStringB = String(formatter.string(from: res as NSNumber)!)
        }
        
    }
    func setToDefault(){
        resStringA  = ""
        resStringB  = ""
        isFirstNum  = true
    }
    
    func chainOperationCheck() -> Bool{
        if !resStringB.isEmpty{
            isFirstNum = false
            return true
        }
        return false
    }
    
}
