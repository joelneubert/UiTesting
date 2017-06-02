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
    
    
    override func visible() {
        detectTableCell.waitToExist()
    }
    
    
    func tapOnDetectTableCell() {
        tap(element: detectTableCell)
    }

}
