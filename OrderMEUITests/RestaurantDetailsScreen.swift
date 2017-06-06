//
//  RestaurantDetailsScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/2/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import UIKit

class RestaurantDetailsScreen: TabBarScreen {
    
    private let detectTableCell = table.staticTexts["Detect table"]
    private let menuCell = table.staticTexts["Menu"]
    private let reservationCell = table.staticTexts["Reservation"]
    private let callAWaiterCell = table.staticTexts["Call a waiter"]
    
    override func visible() {
        detectTableCell.waitToExist()
    }
    
    func tapOnDetectTableCell() {
        tap(element: detectTableCell)
    }
    
    func tapOnMenuCell() {
        tap(element: menuCell)
    }
    
    func tapOnReservationCell() {
        tap(element: reservationCell)
    }
    
    func tapOnCallAWaiterCell() {
        tap(element: callAWaiterCell)
    }
}
