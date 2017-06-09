//
//  OrderMEUITests.swift
//  OrderMEUITests
//
//  Created by Boris Gurtovyy on 5/23/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//



import XCTest

class OrderMEUITests: BaseTest {
    
    private let placeName = "Test Restaurant"
    private let numberOfTable = 5
    private var idPlace : Int?
    
    
    override func setUp() {
        super.setUp()
        addPlaceToServer()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    override func handleLocation() {
        super.handleLocation()
    }
    
    func addPlaceToServer() {
        let placeJson : [String: String] = [
            "name" : placeName,
            "address" : "Wilshire blvd, LA, CA",
            "phone" : "1234567",
            "latitude": "12.1231",
            "longitude": "13.1231",
            "imagepath": "http://www.gafollowers.com/wp-content/uploads/2014/06/hl4.jpg"
        ]
        let place = ServerManager.addPlace(placeJson: placeJson)
        self.idPlace = place?.id
        
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

