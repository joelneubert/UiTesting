//
//  BaseTest.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest

class BaseTest: XCTestCase{
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func waitForElementToAppear(format: String, element: AnyObject, time: Double){
//        let exists = NSPredicate(format: format)
//        expectation(for: exists, evaluatedWith:element, handler: nil)
//        waitForExpectations(timeout: time, handler: nil)
//    }
    
}

extension XCUIElement {
    @discardableResult func waitToExist() -> XCUIElement {
        
        let doesElementExist: () -> Bool = {
            return self.exists
        }
        waitFor(doesElementExist, failureMessage: "Timed out waiting for element to exist.")
        return self
    }
    
    private func waitFor(_ expression: () -> Bool, failureMessage: String) {
        let defaultTimeoutInSeconds = 5.0
        let startTime = NSDate.timeIntervalSinceReferenceDate
        
        while !expression() {
            if NSDate.timeIntervalSinceReferenceDate - startTime > defaultTimeoutInSeconds {
                NSException(name: NSExceptionName(rawValue: "Timeout"), reason: failureMessage, userInfo: nil).raise()
            }
            CFRunLoopRunInMode(CFRunLoopMode.defaultMode, 0.1, true)
        }
}
}




