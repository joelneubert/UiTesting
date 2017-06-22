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
    
//    func waitForElementToAppear(format: String, element: AnyObject, time: Double){
//        let exists = NSPredicate(format: format)
//        expectation(for: exists, evaluatedWith:element, handler: nil)
//        waitForExpectations(timeout: time, handler: nil)
//    }
    
// Alternative way to use XCTWaiter()
    
    func waitForElementToAppear(format: String, element: AnyObject, time: Double){
        let exists = NSPredicate(format: format)
        let myExpectation = XCTNSPredicateExpectation(predicate: exists, object: element)
        XCTWaiter().wait(for: [myExpectation], timeout: time)
    }

}

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

