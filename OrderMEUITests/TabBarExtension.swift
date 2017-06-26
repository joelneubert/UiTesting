//
//  TabBarExtension.swift
//  orderMe
//
//  Created by Igor Dorovskikh on 6/25/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest

extension TabBar {
    private var homeButton: XCUIElement {
        return BaseScreen.app.tabBars.buttons["Home"]
    }
    
    @discardableResult 
    func goToHomeScreen() -> HomeScreen {
        homeButton.tap()
        return HomeScreen()
    }    
}
