//
//  Login.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import Foundation


class LoginScreen : BaseScreen {
    
    private let loginLaterButton = app.buttons["Log in later"]
    
    func tapOnLoginLaterButton() {
        tap(element: loginLaterButton)
    }
}