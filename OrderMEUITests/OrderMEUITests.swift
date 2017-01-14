//
//  OrderMEUITests.swift
//  OrderMEUITests
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest

class Acceptance: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func waitForElementToAppear(format: String, element: AnyObject, time: Double){
        let exists = NSPredicate(format: format)
        expectation(for: exists, evaluatedWith:element, handler: nil)
        waitForExpectations(timeout: time, handler: nil)
    }
    
    func testCallWaiterForMenu() {
        
        let app = XCUIApplication()
        app.buttons["Log in later"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Hookah Place"].tap()
        tablesQuery.staticTexts["Detect table"].tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("3")
        app.buttons["Select table"].tap()
        tablesQuery.staticTexts["Call a waiter"].tap()
        app.alerts["The waiter is on his way"].buttons["Bring a menu"].tap()
        
        let gotItAlert = app.alerts["Got it!"]
        
        waitForElementToAppear(format: "exists == true ", element: gotItAlert, time: 3.0)
        
        XCTAssert(gotItAlert.staticTexts["The waiter is on his way"].exists)
        
    }
    
}
