//
//  OrderMEUITests.swift
//  OrderMEUITests
//
//  Created by Boris Gurtovyy on 5/23/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//



import XCTest

class OrderMEUITests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    

    override func tearDown() {
        super.tearDown()
    }
    

    func testCallAWaiter() {
    
        let app = XCUIApplication()
        app.buttons["Log in later"].tap()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Quince"].tap()
        tablesQuery.staticTexts["Detect table"].tap()
        app.textFields["@table_number_textfield"].tap()
        app.textFields["@table_number_textfield"].typeText("5")
        app.buttons["Select table"].tap()
        app.tables.staticTexts["Call a waiter"].tap()
        app.alerts["The waiter is on his way"].buttons["Bring a menu"].tap()
        
        let gotItAlert = app.alerts["Got it!"]
        sleep(2)
        XCTAssert(gotItAlert.staticTexts["The waiter is on his way"].exists)
        
    }
  
}

