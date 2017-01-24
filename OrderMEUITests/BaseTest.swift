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
    
    func waitForElementToAppear(format: String, element: AnyObject, time: Double){
        let exists = NSPredicate(format: format)
        expectation(for: exists, evaluatedWith:element, handler: nil)
        waitForExpectations(timeout: time, handler: nil)
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
}






