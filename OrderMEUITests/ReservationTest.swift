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
    var idOfReservation : Int?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        guard let id = idOfReservation else {
            XCTFail()
            return
        }
        if !ServerManager.deleteReserve(id: id) {
            XCTFail()
            return
        }
    }

    override func handleLocation() {
        super.handleLocation()
    }
    
    
    
    func testMakeFutureReservation() { 
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
        

        let reservationsOpt = ServerManager.getReservations()
        guard let reservations = reservationsOpt else {
            XCTFail()
            return
        }
   
        let reserve = reservations.last
        guard let date = reserve?.date,
              let id = reserve?.id else {
            XCTFail()
            return
        }
        self.idOfReservation = id
        
        let calendar = Calendar.current
        let hourReservation = calendar.component(.hour, from: date)
        let minutesReservation = calendar.component(.minute, from: date)
        let dayReservation = calendar.component(.day, from: date)
//        let monthReservation = calendar.component(.month, from: date)

        guard let dayReserve = Int(day) else {
            XCTFail()
            return
        }
        guard  dayReservation == dayReserve,
              hourReservation == 0,
            minutesReservation == 30 else {
                XCTFail()
                return
        }
    }
    
}
