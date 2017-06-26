//
//  TabBarScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/2/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import UIKit
import XCTest

class HomeScreen : BaseScreen, TabBar {

    private var restaurantCell : XCUIElement!
    
    override init() {
        
    }
    
    init(name : String) {
        super.init()
        restaurantCell = BaseScreen.table.staticTexts[name]
        visible()
    }
    
    func visible() {
        restaurantCell.waitToExist()
    }
    
    func tapOnRestaurantCell() {
        tap(element: restaurantCell)
    }
    
    
}
