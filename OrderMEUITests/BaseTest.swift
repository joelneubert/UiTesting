//
//  BaseTest.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 5/26/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//


import XCTest

class BaseTest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func waitForElementToAppear(format: String, element: AnyObject, time: Double){
        let exists = NSPredicate(format: format)
        expectation(for: exists, evaluatedWith:element, handler: nil)
        waitForExpectations(timeout: time, handler: nil)
    }
    
}

// this is my change

// MARK : handleLocation
extension BaseTest {
    func handleLocation(){
        addUIInterruptionMonitor(withDescription: "Allow Location") { (alert) -> Bool in
            alert.buttons["Allow"].tap()
            return true
        }
        XCUIApplication().tap()
    }
}


// MARK : facebook authorization
extension BaseTest {
    func facebookLogin() {
        //let app = XCUIApplication()
        let user = TestUser()
        app.buttons["Continue with Facebook"].tap()
        
        let webViewsQuery = app.webViews
        //let emailOrPhoneTextField = webViewsQuery.textFields["Email or Phone"]
        //emailOrPhoneTextField.tap()
        //emailOrPhoneTextField.typeText(user.email)
        webViewsQuery.secureTextFields["Facebook Password"].typeText(user.password)
        webViewsQuery.buttons["Log In"].tap()
    
        app.webViews.buttons["Log In"].tap()
        app.buttons["OK"].tap()
    }
    
}


