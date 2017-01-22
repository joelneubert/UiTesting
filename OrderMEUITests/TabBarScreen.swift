//
//  TabBar.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest


class TabBarScreen : BaseScreen {
    
    private var restaurantCell : XCUIElement!
    
    override init(){
        
    }
    
     init(name: String) {
        restaurantCell = BaseScreen.table.staticTexts[name]
    }
    
    func visible(){
        restaurantCell.waitToExist()
    }
    
    func tapOnRestaurantCell(){
        tap(element: restaurantCell)
    }
    
}
