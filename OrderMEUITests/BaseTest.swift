//
//  BaseTest.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest


class BaseTest: XCTestCase{
    
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
        expectation(for: exists, evaluatedWith:element, handler: nil)
        waitForExpectations(timeout: time, handler: nil)
    }
    
    func handleLocation(){
        addUIInterruptionMonitor(withDescription: "Allow Location") { (alert) -> Bool in
            alert.buttons["Allow"].tap()
            return true
        }
        XCUIApplication().tap()
    }

    
    func getDate(daysFromToday: Int) -> (day : String, month : String){
        var components = DateComponents()
        components.setValue(daysFromToday, for: .day)
        
        let today = NSDate()
        let futureDate = NSCalendar.current.date(byAdding: components, to: today as Date)
        let futureDay = NSCalendar.current.component(.day, from: futureDate!)
        let futureDayString = String(futureDay)
        let futureMonth = NSCalendar.current.component( .month, from: futureDate!)
        
        let dateFormat = DateFormatter()
        let futureMonthString = dateFormat.shortMonthSymbols[futureMonth as Int - 1]
        
        return(futureDayString, futureMonthString )
    }
    
    func facebookLogin(){
        let app = XCUIApplication()
        let user = TestUser()
        app.buttons["Log in with Facebook"].tap()
        
        
        let emailOrPhoneTextField = app.textFields["Email or Phone"]
        emailOrPhoneTextField.tap()
        emailOrPhoneTextField.typeText(user.email)
        
        let facebookPasswordSecureTextField = app.secureTextFields["Facebook Password"]
        facebookPasswordSecureTextField.tap()
        facebookPasswordSecureTextField.typeText(user.password)
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["OK"].tap()
    }

}






