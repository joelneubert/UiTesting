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
    
    func tap(element: XCUIElement) {
        element.tap()
    }
    
    
    func tablesQuery() -> XCUIElementQuery {
        return BaseScreen.table
    }
    
    
    

}
