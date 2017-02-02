//
//  ReservationTest.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/22/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest
@testable import OrderME


class ReservationTest : BaseTest {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    override func handleLocation() {
        super.handleLocation()
    }
    
    func testMakeFutureReservation() { // USER MUST TO BE LOGGED IN
        facebookLogin()
        let tabBarScreen = TabBarScreen(name: "The Burger")
        tabBarScreen.visible()
        tabBarScreen.tapOnRestaurantCell()
        
        let restaurantDetailsScreen = RestaurantDetailsScreen()
        restaurantDetailsScreen.tapOnReservationCell()
        
        let reservationScreen = ReservationScreen()
        reservationScreen.typePhoneNumber("3236756008")
        reservationScreen.typeNumberOfPeople("4")
        
        //setting future day and month
        let (day, month) = getDate(daysFromToday: 2)
        
        reservationScreen.selectDate(month: month, day: day)
        reservationScreen.tapBookButton()
        reservationScreen.tapOkButton()
        
/*       * next code checks the last reservation to be equal with the one is created by our test.
         * However, server gives back only reservations, that were booked by the user that is asking for reservations.
         * So we need to implement facebook login first and then merge this 2 tests
        
        
        let reservationsOpt = ServerManager.getReservations()
        guard let reservations = reservationsOpt else {
            XCTFail()
            return
        }
   
        let reserve = reservations.last
        guard let date = reserve?.date else {
            XCTFail()
            return
        }
        let calendar = Calendar.current
        let hourReservation = calendar.component(.hour, from: date)
        let minutesReservation = calendar.component(.minute, from: date)
        let dayReservation = calendar.component(.day, from: date)
        let monthReservation = calendar.component(.month, from: date)
        
        guard monthReservation == Int(month),
              dayReservation == Int(day),
              hourReservation == 12,
            minutesReservation == 30 else {
                XCTFail()
                return
        }
     */
        
    }
    
}
