//
//  OrderMEUITests.swift
//  OrderMEUITests
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest

class OrderMEUITests: BaseTest {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCallWaiterForMenu() {
        
        let loginScreen = LoginScreen()
        loginScreen.tapOnLoginLaterButton()
        
        let tabBarScreen = TabBarScreen()
        tabBarScreen.tapOnRestaurantCell()
        
        let restaurantDetailScreen = RestaurantDetailsScreen()
        restaurantDetailScreen.tapOnDetectTableCell()
        
        let tableNumberSelector = TableNumberSelector()
        tableNumberSelector.typeIntoSelectTableField(text: "3")
        tableNumberSelector.tapOnSelectTableButton()
        
        
//        tablesQuery.staticTexts["Call a waiter"].tap()
//        app.alerts["The waiter is on his way"].buttons["Bring a menu"].tap()
//        
//        let gotItAlert = app.alerts["Got it!"]
//        
//        waitForElementToAppear(format: "exists == true ", element: gotItAlert, time: 3.0)
//        
//        XCTAssert(gotItAlert.staticTexts["The waiter is on his way"].exists)
//        
    }
    
}
