//
//  ReservationScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/22/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import Foundation
import XCTest

class ReservationScreen : TabBarScreen{
    
    private let pickerWheelDateMonthDays = XCUIApplication().datePickers.pickerWheels.element(boundBy: 0)
    private let pickerWheelDateHours = XCUIApplication().datePickers.pickerWheels.element(boundBy: 1)
    private let pickerWheelDateMinutes = XCUIApplication().datePickers.pickerWheels.element(boundBy: 2)
    private let pickerWheelDateAmPm = XCUIApplication().datePickers.pickerWheels.element(boundBy: 3)
    
    private let phoneNumber = app.textFields["Phone number"]
    
    private let numberOfPeople = app.textFields["Number of people"]
    
    private let bookButton =  app.buttons["Book"]
    
    private let successAlert =  app.alerts["Success!"].buttons["OK"]
    
    func typePhoneNumber(_ number: String) {
        tap(element: phoneNumber)
        type(string: number, field: phoneNumber)
    }
    
    
    func typeNumberOfPeople(_ number: String) {
        tap(element: numberOfPeople)
        type(string: number, field: numberOfPeople)
    }
    
    func tapBookButton(){
        tap(element: bookButton)
    }
    
    func tapOkButton(){
        tap(element: successAlert)
    }
    
    func selectDate(month: String, day: String) {
        pickerWheelDateMonthDays.adjust(toPickerWheelValue: "\(month) \(day)")
        pickerWheelDateHours.adjust(toPickerWheelValue: "12")
        pickerWheelDateMinutes.adjust(toPickerWheelValue: "30")
        pickerWheelDateAmPm.adjust(toPickerWheelValue: "AM")
    }
}
