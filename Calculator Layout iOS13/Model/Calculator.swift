//
//  Calculator.swift
//  Calculator Layout iOS13
//
//  Created by Anastasia Lenina on 27.04.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//
import Foundation

enum operation {
    case plus
    case minus
    case divide
    case multiply
    case percent
    case sign
    case clear
    case compute
    case none
}


struct Calculator {
    private var resStringA : String = ""
    private var operationPressed : operation = .none
    private var resStringB : String = ""
    

    private var isShowingSecondNumber : Bool {
        get {
            !resStringA.isEmpty && operationPressed != operation.none && !resStringB.isEmpty
        }
    }
    
    private let formatter = NumberFormatter()
    
    mutating func numberEntered(_ number: String, _ maxInput: Int = 12) {
        if number.isEmpty || resStringA.count >= maxInput {
            return
        }
        
        if operationPressed == .none {
            resStringA.append(number)
        } else {
            resStringB.append(number)
        }
    }
    
    func getResult() -> String {
        return isShowingSecondNumber ? resStringB : resStringA
    }
    
    func getState() -> (String, operation, String) {
        return (resStringA, operationPressed, resStringB)
    }
    
    mutating func operationEntered(operationName: operation) {
        if (operationName == .clear) {
            clear()
            return
        }
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        
        if (operationPressed == .none) {
            if (operationName == .sign) {
                resStringA = resStringA.contains("-") ? resStringA.replacingOccurrences(of: "-", with: "") : "-" + resStringA
                return
            }
            
            if (operationName == .percent) {
                // TODO: MOVE THE DOT
                if let a = Float(resStringA) {
                    let numberResult = a / 100.0
                    resStringA = String(formatter.string(from: numberResult as NSNumber) ?? "")
                }
                return
            }
            
            operationPressed = operationName
            return
        }
        
        // else compute, set result into resStringA, clear resStringB, replace operation witn new one
        
        if (operationName == .percent) {
            if let a = Float(resStringA), let b = Float(resStringB) {
                let numberResult = a * b / 100.0
                resStringB = String(formatter.string(from: numberResult as NSNumber) ?? "")
            }
            return
        }
        
        if (operationName == .sign) {
            if let b = Float(resStringB)  {
                let numberResult = b * (-1)
                resStringB = String(formatter.string(from: numberResult as NSNumber) ?? "")
            }
            return
        }
        
        if resStringB.isEmpty {
            operationPressed = operationName
            return
        }
        
        var numberResult : Float = 0.0
        
        switch operationPressed {
        case .compute:
            operationEntered(operationName: .none)
            return
            
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
            
        default:
            return
        }
        
        resStringA = String(formatter.string(from: numberResult as NSNumber) ?? "")
        resStringB = ""
        operationPressed = operationName
    }
    
    mutating func clear(){
        resStringA  = ""
        resStringB  = ""
        operationPressed = .none
    }
}
