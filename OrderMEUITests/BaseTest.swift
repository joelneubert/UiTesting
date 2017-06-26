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
        app.launchArguments = ["deleteAllData"]
        app.launch()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func waitForElementToAppear(format: String, element: AnyObject, time: Double){
        let exists = NSPredicate(format: format)
        let myExpectation = expectation(for: exists, evaluatedWith:element, handler: nil)
        XCTWaiter().wait(for: [myExpectation], timeout: time)
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


// MARK : Calendar
extension BaseTest {
    func getDate(daysFromToday : Int) -> (day: String, month: String) {
        var components = DateComponents()
        components.setValue(daysFromToday, for: .day)
        
        let today = NSDate()
        let futureDate = NSCalendar.current.date(byAdding: components, to: today as Date)
        guard let fDate = futureDate else {
            return ("","")
        }
        let futureDay = NSCalendar.current.component(.day, from: fDate)
        let futureDayString = String(futureDay)
        let futureMonth = NSCalendar.current.component(.month, from: fDate)
        
        let dateFormat = DateFormatter()
        let futureMonthString = dateFormat.shortMonthSymbols[futureMonth - 1]
        
        return (futureDayString, futureMonthString)
        
    }
}


