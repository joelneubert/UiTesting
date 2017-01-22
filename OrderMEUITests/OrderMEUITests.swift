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
    }
    
    override func tearDown() {
        super.tearDown()
        guard let idOfPlace = idPlace else {
            XCTFail()
            return
        }
        NetworkClient.deletePlace(id: idOfPlace) { (success, error) in
            if error != nil {
                XCTFail()
                return
            }
        }
    }
    
    func addPlaceToServer() {
//        NetworkClient.addPlace(placeJson: placeJson) { (place, error) in
//            if error != nil {
//                XCTFail()
//                return
//            }
//            guard let place = place else {
//                XCTFail()
//                return
//            }
//            self.idPlace = place.id
//        }
        
        let placeJson : [String : AnyObject] = [
            "name" : placeName as AnyObject,
            "address" : "Wilshire blvd, LA, CA" as AnyObject,
            "phone" : "3236756008" as AnyObject,
            "latitude" : "12.3123" as AnyObject,
            "longitude" : "23.1312" as AnyObject,
            "imagepath" : "http://www.gafollowers.com/wp-content/uploads/2014/06/hl4.jpg" as AnyObject
        ]
        
        let place = NetworkClient.addPlace(placeJson: placeJson)
        print(place?.id)
        self.idPlace = place?.id
    }
    
    func testCallWaiterForMenu() {
        addPlaceToServer()

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
