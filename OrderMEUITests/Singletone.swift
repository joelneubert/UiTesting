//
//  Singletone.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 2/2/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import Foundation
import Foundation

class Singletone : NSObject {
    
    fileprivate override init(){}
    
    static let shareInstance = Singletone()
    
    var token : String?

}
