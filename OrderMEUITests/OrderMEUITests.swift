//
//  OrderMEUITests.swift
//  OrderMEUITests
//
//  Created by Boris Gurtovyy on 5/23/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//



import XCTest

class OrderMEUITests: BaseTest {
    
    private let placeName = "Quince"
    private let numberOfTable = "5"
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    override func handleLocation() {
        super.handleLocation()
    }

    func testCallAWaiter() {
    
        let loginScreen = LoginScreen()
        loginScreen.tapOnLoginLaterButton()
        
        let tabBarScreen = TabBarScreen(name: placeName)
        tabBarScreen.visible()
        tabBarScreen.tapOnRestaurantCell()
        
        let restaurantDetailsScreen = RestaurantDetailsScreen()
        restaurantDetailsScreen.tapOnDetectTableCell()
        
        let tableDetection = TableDetection()
        tableDetection.typeIntoSelectTableField(text: numberOfTable.description)
        tableDetection.tapOnSelectTableButton()
        
        restaurantDetailsScreen.tapOnCallAWaiterCell()
        
        let callWaiterAlert = CallWaiterAlert()
        callWaiterAlert.tapOnBringAMenuButton()
        
        let gotItAlert = app.alerts["Got it!"]
        gotItAlert.waitToExist()
        
        XCTAssert(gotItAlert.staticTexts["The waiter is on his way"].exists)
        
    }
    
}

