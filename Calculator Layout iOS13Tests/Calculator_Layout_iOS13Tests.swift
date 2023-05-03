//
//  Calculator_Layout_iOS13Tests.swift
//  Calculator Layout iOS13Tests
//
//  Created by Anastasia Lenina on 03.05.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import XCTest
@testable import Calculator_Layout_iOS13

final class CalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldPersistEnteredNumber() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        var calc = Calculator()
        XCTAssert(calc.getResult() == "")
        XCTAssert(calc.getState() == ("", .none, ""))
        
        calc.numberEntered("3")
        XCTAssert(calc.getState() == ("3", .none, ""))
        XCTAssert(calc.getResult() == "3")
        
        calc.operationEntered(operationName: .multiply)
        XCTAssert(calc.getState() == ("3", .multiply, ""))
        XCTAssert(calc.getResult() == "3")
        
        calc.numberEntered("4")
        XCTAssert(calc.getState() == ("3", .multiply, "4"))
        XCTAssert(calc.getResult() == "4")

        calc.operationEntered(operationName: .plus)
        XCTAssert(calc.getState() == ("12", .plus, ""))
        XCTAssert(calc.getResult() == "12")
        
        calc.numberEntered("3")
        
        calc.operationEntered(operationName: .plus)
        calc.operationEntered(operationName: .minus)
        calc.operationEntered(operationName: .minus)
        calc.numberEntered("2")
        
        
        calc.operationEntered(operationName: .divide)
        
        XCTAssert(calc.getResult() == "13")
        XCTAssert(calc.getState() == ("13", .divide, ""))
        
        calc.numberEntered("2")
        calc.operationEntered(operationName: .compute)
        XCTAssert(calc.getResult() == "6.5")
    }
}
