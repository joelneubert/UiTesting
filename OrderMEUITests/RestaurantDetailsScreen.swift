//
//  RestaurantDetailsScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/2/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import UIKit

class RestaurantDetailsScreen: BaseScreen, TabBar {
    
    private let detectTableCell = table.staticTexts["Detect table"]
    private let callAWaiterCell = table.staticTexts["Call a waiter"]
    private let reservationCell = table.staticTexts["Reservation"]
    
    
    required init() {
        detectTableCell.waitToExist()
    }
    
    func tapOnDetectTableCell() {
        tap(element: detectTableCell)
    }
    
    func tapOnCallAWaiterCell() {
        tap(element: callAWaiterCell)
    }
    
    func tapOnReservation() {
        tap(element: reservationCell)
    }
    
}

class TableDetection : BaseScreen, TabBar {
    private let selectTableField = app.textFields["@table_number_textfield"]
    private let selectTableButton = app.buttons["Select table"]
    
    required init() {
        super.init()
        visible()
    }
    
    func visible() {
        selectTableField.waitToExist()
    }
    
    func tapOnSelectTableField() {
        tap(element: selectTableField)
    }
    
    func typeIntoSelectTableField(text: String){
        type(string: text, field: selectTableField)
    }
    
    func tapOnSelectTableButton() {
        tap(element: selectTableButton)
    }
    
}

class CallWaiterAlert : BaseScreen, TabBar {
    private let bringAMenuButton = app.alerts["The waiter is on his way"].buttons["Bring a menu"]
    
    func tapOnBringAMenuButton() {
        tap(element: bringAMenuButton)
    }
}