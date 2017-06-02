//
//  TabBarScreen.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/2/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import UIKit
import XCTest

class TabBarScreen : BaseScreen  {

    private var restaurantCell : XCUIElement!
    
    override init() {
        
    }
    
    init(name : String) {
        restaurantCell = BaseScreen.table.staticTexts[name]
        
    }
    
    func visible() {
        restaurantCell.waitToExist()
    }
    
    func tapOnRestaurantCell() {
        tap(element: restaurantCell)
    }
    
    
}
