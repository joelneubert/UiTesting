//
//  BaseScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/2/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest


class BaseScreen  {
    
    static let app = XCUIApplication()
    static let table = XCUIApplication().tables
    
    required init() {}
    
    func tap(element: XCUIElement) {
        element.tap()
    }
    
    func type(string: String, field: XCUIElement){
        tap(element: field)
        field.typeText(string)
    }
    
    func tablesQuery() -> XCUIElementQuery {
        return BaseScreen.table
    }
    
}
