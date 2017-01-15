//
//  TabBar.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import Foundation


class TabBarScreen : BaseScreen {
    
    private let restaurantCell = table.staticTexts["Hookah Place"]
    
    func tapOnRestaurantCell(){
        tap(element: restaurantCell)
    }
    
}
