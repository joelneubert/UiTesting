//
//  DetectTableScreen.swift
//  orderMe
//
//  Created by Ilya Ovesnov on 6/3/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import UIKit

class DetectTableScreen : RestaurantDetailsScreen {
    
    private let detectTableTextField = app.textFields["@table_number_textfield"]
    private let selectTableButton = app.buttons["Select table"]

    override func visible() {
        detectTableTextField.waitToExist()
    }
    
    func tapOnDetectTableTextField() {
        tap(element: detectTableTextField)
    }
    
    func typeTextInDetectTableTextField(text: String){
        detectTableTextField.typeText(text)
    }
    
    func tapOnSelectTableButton() {
        tap(element: selectTableButton)
    }

    
}


