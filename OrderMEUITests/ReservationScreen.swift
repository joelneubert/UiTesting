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
    
    private let pickerWheelDate = XCUIApplication().datePickers.pickerWheels.element(boundBy: 0)
    
    func selectDate(month: String, day: String) {
        pickerWheelDate.adjust(toPickerWheelValue: "\(month) \(day)")
    }
}
