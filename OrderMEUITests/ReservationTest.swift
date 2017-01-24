//
//  ReservationTest.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/22/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest


class ReservationTest : BaseTest {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testMakeFutureReservation() {
        //setting future day and month
        let (day, month) = getDate(daysFromToday: 2)
        print ("++++++++++++++Future day is \(day) and month is \(month)++++++++++++++++")
  
        let reservationScreen = ReservationScreen()
        
        
  //      XCTAssert(expenseDetails.getDateFromCell().contains("\(day) \(month)"), "found instead: \(expenseDetails.getDateFromCell())")
    
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Octopus Japaneese Restaurant"].tap()
        tablesQuery.staticTexts["Reservation"].tap()
        
        let phoneNumberTextField = app.textFields["Phone number"]
        phoneNumberTextField.tap()
        phoneNumberTextField.typeText("3236756008")
        
        let numberOfPeopleTextField = app.textFields["Number of people"]
        numberOfPeopleTextField.tap()
        numberOfPeopleTextField.tap()
        numberOfPeopleTextField.typeText("4")
        reservationScreen.selectDate(month: month, day: day)
        app.buttons["Book"].tap()
        app.alerts["Success!"].buttons["OK"].tap()
        
        // TODO get reservations and check this reservation
        
    }
    
}
