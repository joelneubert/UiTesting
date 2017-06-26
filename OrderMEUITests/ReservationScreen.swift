//
//  ReservationScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/16/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest

class ReservationScreen: BaseScreen, TabBar {
    
    private let pickerWheelDateMonthDays: XCUIElement = app.datePickers.pickerWheels.element(boundBy: 0)
    private let pickerWheelDateHours: XCUIElement = app.datePickers.pickerWheels.element(boundBy: 1)
    private let pickerWheelDateMinutes: XCUIElement = app.datePickers.pickerWheels.element(boundBy: 2)
    private let pickerWheelDateAmPm: XCUIElement  = app.datePickers.pickerWheels.element(boundBy: 3)
    
    
    func selectDate(month: String, day: String ) {
        pickerWheelDateMonthDays.adjust(toPickerWheelValue: "\(month) \(day)")
        pickerWheelDateHours.adjust(toPickerWheelValue: "12")
        pickerWheelDateMinutes.adjust(toPickerWheelValue: "30")
        pickerWheelDateAmPm.adjust(toPickerWheelValue: "PM")
    }

}
