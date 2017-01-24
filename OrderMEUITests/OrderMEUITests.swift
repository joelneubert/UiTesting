//
//  OrderMEUITests.swift
//  OrderMEUITests
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest
@testable import OrderME

class OrderMEUITests: BaseTest {
    private let placeName = "Test Place"
    
    private var idPlace : Int?
    
    override func setUp() {
        super.setUp()
        addPlaceToServer()
    }
    
    override func tearDown() {
        super.tearDown()
        guard let idOfPlace = idPlace else {
            XCTFail()
            return
        }
        if !NetworkClient.deletePlace(id: idOfPlace) {
            XCTFail()
        }
    }
    
    func addPlaceToServer() {
        let placeJson : [String : String] = [
            "name" : placeName,
            "address" : "Wilshire blvd, LA, CA",
            "phone" : "3236756008",
            "latitude" : "12.3123",
            "longitude" : "23.1312",
            "imagepath" : "http://www.gafollowers.com/wp-content/uploads/2014/06/hl4.jpg"
        ]
        let place = NetworkClient.addPlace(placeJson: placeJson)
        self.idPlace = place?.id
    }
    
    func testCallWaiterForMenu() {
        let loginScreen = LoginScreen()
        loginScreen.tapOnLoginLaterButton()
        
        let tabBarScreen = TabBarScreen(name: placeName)
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
