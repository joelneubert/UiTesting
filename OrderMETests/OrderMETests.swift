//
//  OrderMETests.swift
//  OrderMETests
//
//  Created by Boris Gurtovyy on 1/14/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import XCTest
@testable import OrderME

class OrderMETests: XCTestCase {
    
    var token : String!
    
    override func setUp() {
        token = "Aslkd123djw5li" // token in database for tests
    }
    
    
    func testAPIAddPlace() {
        let parameters = [
            "name" : "The Burger",
            "address" : "9 east street, LA, CA",
            "phone" : "3236756008",
            "latitude" : "12.3123",
            "longitude" : "23.1312",
            "imagepath" : "https://www.likealocalguide.com/media/cache/02/a5/02a557280558360b54b730c5941dfea4.jpg"
        ]
        NetworkClient.send(api: "/places", method: .post, parameters: parameters, token: token) { (result, error) in
            XCTAssert(error == nil)
        }
        
    }
    
}
