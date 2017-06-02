//
//  XCUIElementExtension.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/2/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest

private let defaultTimeoutInSeconds = 10.0

extension XCUIElement {
    @discardableResult func waitToExist() -> XCUIElement {
        
        let doesElementExist: () -> Bool = {
            return self.exists
        }
        waitFor(doesElementExist, failureMessage: "Timed out waiting for element to exist.")
        return self
    }
    
    private func waitFor(_ expression: () -> Bool, failureMessage: String) {
        let startTime = NSDate.timeIntervalSinceReferenceDate
        
        while !expression() {
            if NSDate.timeIntervalSinceReferenceDate - startTime > defaultTimeoutInSeconds {
                NSException(name: NSExceptionName(rawValue: "Timeout"), reason: failureMessage, userInfo: nil).raise()
            }
            CFRunLoopRunInMode(CFRunLoopMode.defaultMode, 0.1, true)
        }
    }
}
