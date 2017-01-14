//
//  DishCell.swift
//  iOrder
//
//  Created by Boris Gurtovyy on 03.04.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit

class DishCell: UITableViewCell {
    
    @IBOutlet weak var dishName: UILabel!
    
    var numberOfItems = 0
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var dish : Dish!
    
    var cellDelegate : BucketCellProtocolAddDelete?
    
    var infoD : InfoDishProtocol?
    
    @IBAction func addItem(_ sender: AnyObject) {
        numberOfItems += 1
        numberOfItemsLabel.text = String(numberOfItems)
        addToBucket(sender) // add to Bucket
    }
    
    @IBAction func infoBut(_ sender: AnyObject) {
        infoD?.showInfoDish(self.dish)
    }
    
    
    @IBAction func deleteItem(_ sender: AnyObject) {
        if numberOfItems > 0 {
            numberOfItems -= 1
            numberOfItemsLabel.text = String(numberOfItems)
            deleteFromBucket(sender)
        }
    }
    
    func addToBucket(_ sender: AnyObject) {
        guard let dish = dish else { return }
        Bucket.shareInstance.addDish(dish: dish)
        cellDelegate?.addDish(dish)
    }
    
    func deleteFromBucket(_ sender: AnyObject) {
        guard let dish = dish else { return }
        Bucket.shareInstance.deleteDish(dish: dish)
        cellDelegate?.deleteDish(dish)
    }
}
