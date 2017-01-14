//
//  BucketCell.swift
//  iOrder
//
//  Created by Boris Gurtovyy on 06.04.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit

class BucketCell: UITableViewCell {
    
    @IBOutlet weak var dishName: UILabel!  // name of the dish
    @IBOutlet weak var amountLabel: UILabel!   // amount of this dish (label)
    @IBOutlet weak var priceLabel: UILabel!  // price of this dish * amount of dish
    
    var dish : Dish?
    
    var numberOfItems = 0   // amount of dish (number)
    
    var bucketCellDelegateAddDelete : BucketCellProtocolAddDelete?
    
    
    @IBAction func addDishBut(_ sender: AnyObject) {
        
        guard let dish = dish else { return }
        guard let amount = Int(amountLabel.text!) else { return }
        
        let newAmount = amount + 1
        amountLabel.text = newAmount.description
        
        guard let oldPrice = Double(priceLabel.text!) else { return }
        
        let newPrice = newAmount != 1 ? oldPrice * Double(newAmount) / Double(newAmount - 1) : dish.price
        
        priceLabel.text = newPrice?.description
        
        Bucket.shareInstance.addDish(dish: dish) // updating Bucket
        bucketCellDelegateAddDelete?.addDish(dish)  // updating sum label in Categories
    }
    
    @IBAction func delDishBut(_ sender: AnyObject) {
        
        guard let dish = dish else { return }
        guard let amount = Int(amountLabel.text!) else { return }
        guard amount > 0 else { return }
        
        let newAmount = amount - 1
        amountLabel.text = newAmount.description
        
        guard let oldPrice = Double(priceLabel.text!) else { return }
        
        let newPrice = oldPrice * Double(newAmount) / (Double(newAmount) + 1)
        
        priceLabel.text = newPrice.description
        
        Bucket.shareInstance.deleteDish(dish: dish) // updating Bucket
    bucketCellDelegateAddDelete?.deleteDish(dish) // updating sum label in Categories
        
    }
 
}
