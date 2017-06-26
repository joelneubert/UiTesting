//
//  ReservationTest.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/13/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import UIKit
import XCTest

class ReservationTest: BaseTest {
    
    let placeName = "Quince"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMakeReservation() {
        
//        let loginScreen = LoginScreen()
//        loginScreen.tapOnLoginLaterButton()
        facebookLogin()
        
        let homeScreen = HomeScreen(name: placeName)
        homeScreen.tapOnRestaurantCell()
        let restaurantDetailsScreen = RestaurantDetailsScreen()
        restaurantDetailsScreen.tapOnReservation()
       
        let (day, month) = getDate(daysFromToday: 2)
        let reservationScreen = ReservationScreen()
        reservationScreen.selectDate(month: month, day: day)
//       reservationScreen.goToHomeScreen()
//       back(to: HomeScreen.self)
        
        facebookLogOut()  
        
    }
    
    
}
