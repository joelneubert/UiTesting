//
//  SimulatorTableId.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 13.04.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit


// due to unability to use camera for QR_CODE in simulator
class SimulatorTableId: UIViewController {

    @IBOutlet weak var tid: UITextField!
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    
    @IBAction func button(_ sender: AnyObject) {
        if let myTableId = Int(tid.text!){
            let sTone = SingleTone.shareInstance
            sTone.tableID = myTableId
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    

}
