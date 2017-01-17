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
        tabBarScreen.visible()
        tabBarScreen.tapOnRestaurantCell()
        
        let restaurantDetailScreen = RestaurantDetailsScreen()
        restaurantDetailScreen.tapOnDetectTableCell()
        
        let tableNumberSelector = TableNumberSelector()
        tableNumberSelector.typeIntoSelectTableField(text: "3")
        tableNumberSelector.tapOnSelectTableButton()
        
        restaurantDetailScreen.tapOnCallWaiterCell()
        
        let callWaiterAlert = CallWaiterAlert()
        callWaiterAlert.tapOnButtonBringAMenu()
        
        let gotItAlert = XCUIApplication().alerts["Got it!"]
       
        gotItAlert.waitToExist()
        XCTAssert(gotItAlert.staticTexts["The waiter is on his way"].exists)
    }
    
}
