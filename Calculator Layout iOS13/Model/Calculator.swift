//
//  Calculator.swift
//  Calculator Layout iOS13
//
//  Created by Anastasia Lenina on 27.04.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//
enum operation {
    case plus
    case minus
    case divide
    case multiply
    case none
}
enum symbol{
    case percent
    case sign
    case clear
    case none
}
import Foundation
struct Calculator {
    private var resStringA : String = ""
    private var resStringB : String = ""
    private var isFirstNum : Bool = true
    private let formatter = NumberFormatter()
    private var operationPressed : operation = .none
    private var prevOperationPressed : operation = .none
    private var futureOperationPressed : operation = .none
    private var symbolPressed : symbol = .none
    
    mutating func numberEntered(number: String, maxInput: Int)->String{
        if !number.isEmpty &&  resStringA.count < maxInput {
            if isFirstNum{
                resStringA.append(number)
                return resStringA
            }
            else{
                resStringB.append(number)
                return resStringB
            }
        }
        return ""
    }
    
    mutating func operationEntered(operationName: operation ){
        //futureOperationPressed = operationName
        operationPressed = operationName
       
    }
    mutating func symbolEntered(symbolName: symbol ){
        symbolPressed = symbolName
    }
    
    //MARK: - old Funcionality
    mutating func setStringA (strA : String){
        resStringA = strA
    }
    mutating func setStringB (strB : String){
        resStringB = strB
    }
    mutating func applySymbol() -> String{
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        var numberResult : Float = 0.0
        switch symbolPressed {
        case .percent:
            if let a = Float(resStringA), isFirstNum {
                numberResult = a / 100.0
                resStringA = String(formatter.string(from: numberResult as NSNumber) ?? "")
                return resStringA
            }
            if let a = Float(resStringA), let b = Float(resStringB), !isFirstNum {
                numberResult = a * b / 100.0
                resStringB = String(formatter.string(from: numberResult as NSNumber) ?? "")
                return resStringB
                
            }
       case .sign:
            if let a = Float(resStringA), isFirstNum {
                numberResult = a * (-1)
                resStringA = String(formatter.string(from: numberResult as NSNumber) ?? "")
                return resStringA
            }
            if let b = Float(resStringB), !isFirstNum  {
                numberResult = b * (-1)
                resStringB = String(formatter.string(from: numberResult as NSNumber) ?? "")
                return resStringB
            }
            
            return String(formatter.string(from: numberResult as NSNumber) ?? "")
        case .clear:
            setToDefault()
            return "0"
        case .none:
            return ""
        }
        return ""
    }
    mutating func getResult(isResultPressed: Bool) -> String {
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
   
        var numberResult : Float = 0.0
        var stringResult = ""
      
        switch operationPressed {
        case .plus:
            if let a = Float(resStringA), let b = Float(resStringB) {
                numberResult =  a + b
            }
        case .minus:
            if let a = Float(resStringA), let b = Float(resStringB) {
                numberResult = a - b
            }
        case .divide:
            if let a = Float(resStringA), let b = Float(resStringB) {
                numberResult =  a / b
              
            }
        case .multiply:
            if let a = Float(resStringA), let b = Float(resStringB) {
                numberResult =  a * b
            }
        case .none:
            return ""
        }
        if isFirstNum {
            isFirstNum = false
            return resStringA
        }
        stringResult = String(formatter.string(from: numberResult as NSNumber) ?? "")
       
        if isResultPressed {
            setToDefault()
            resStringA  = stringResult
            return stringResult
        }
        else if chainOperationCheck(){
            isFirstNum = false
            resStringB  = ""
        }
        prevOperationPressed = operationPressed
        resStringA  = stringResult
        return stringResult
    }

    mutating func setToDefault(){
        resStringA  = ""
        resStringB  = ""
        isFirstNum  = true
    }
    mutating func chainOperationCheck() -> Bool{
        return  !resStringB.isEmpty
    }
}
