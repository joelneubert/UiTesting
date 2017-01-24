//
//  FacebookAuthentication.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/22/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import Foundation
import XCTest

class FacebookAuthentication: BaseTest {
   
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFacebookLoginLogout(){ 
        let app = XCUIApplication()
        app.buttons["Log in with Facebook"].tap()
        app.links["//button[@name='__CONFIRM__']"].tap()
        app.tabBars.buttons["My orders"].tap()
        app.navigationBars["OrderME.MyOrders"].buttons["Log out"].tap()
        app.sheets["Logged in as Boris Gurtovoy"].buttons["Log Out"].tap()
        //write assertion that we came back to login screen
    }
}
