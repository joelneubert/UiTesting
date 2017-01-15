//
//  BaseScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest

class BaseScreen {
    
    static let app = XCUIApplication()
    static let table = XCUIApplication().tables
    
    func tablesQuery() -> XCUIElementQuery{
        return BaseScreen.table
    }
    
    
    func tap(element: XCUIElement){
        element.tap()
    }
    
    func swipeLeft(element: XCUIElement){
        element.swipeLeft()
    }
    
    func type(string : String, field : XCUIElement){
        tap(element: field)
        field.typeText(string)
    }
}
