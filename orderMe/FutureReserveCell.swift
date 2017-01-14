//
//  FutureReserve.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/2/16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit

class FutureReserve: UITableViewCell{
    
    @IBOutlet weak var placename: UILabel!

    @IBOutlet weak var data: UILabel!
    
    var reserve : Reserve!
    
    var repquestion: RepeatQuestionProtocol?
    
    
    
    @IBAction func deleteReserve(_ sender: AnyObject) {
        repquestion?.repeatQuestion(reserve)
    }
    


    
}
