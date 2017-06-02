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
    
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    override func handleLocation() {
        super.handleLocation()
    }
    
    // some changes about day 3 homework!

    func testCallAWaiter() {
    
        let loginScreen = LoginScreen()
        loginScreen.tapOnLoginLaterButton()
        
        let tabBarScreen = TabBarScreen(name: placeName)
        tabBarScreen.visible()
        tabBarScreen.tapOnRestaurantCell()
        
        let restaurantDetailsScreen = RestaurantDetailsScreen()
        restaurantDetailsScreen.tapOnDetectTableCell()
        
        /*
        tablesQuery.staticTexts["Detect table"].tap()
        app.textFields["@table_number_textfield"].tap()
        app.textFields["@table_number_textfield"].typeText("5")
        app.buttons["Select table"].tap()
        app.tables.staticTexts["Call a waiter"].tap()
        app.alerts["The waiter is on his way"].buttons["Bring a menu"].tap()
        
        let gotItAlert = app.alerts["Got it!"]
        
        waitForElementToAppear(format: "exists == true", element: gotItAlert, time: 5.0)
        
        XCTAssert(gotItAlert.staticTexts["The waiter is on his way"].exists)
 */
        
    }
    
}

