//
//  RestaurantDetailsScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import Foundation
import XCTest

class RestaurantDetailsScreen: TabBarScreen {
    
    private let detectTableCell = table.staticTexts["Detect table"]
    
    private let callWaiterCell = table.staticTexts["Call a waiter"]
    
    func tapOnDetectTableCell() {
        tap(element: detectTableCell)
    }

    
}

class TableNumberSelector: RestaurantDetailsScreen{
    private let selectTableField = app.textFields["@table_number_textfield"]
    private let selectTableButton = app.buttons["Select table"]
    
    func tapOnSelectTableField() {
        tap(element: selectTableField)
    }
    
    func typeIntoSelectTableField(text: String) {
        tapOnSelectTableField()
        type(string: text, field: selectTableField)
    }
    
    func tapOnSelectTableButton() {
        tap(element: selectTableButton)
    }
}

