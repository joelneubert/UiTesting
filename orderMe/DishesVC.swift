//
//  MakeOrderVC.swift
//  iOrder
//
//  Created by Boris Gurtovyy on 02.04.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit

class DishesVC: UIViewController, BucketCellProtocolAddDelete, InfoDishProtocol {
    
    @IBOutlet weak var orderTableView: UITableView!

    @IBOutlet weak var sumLabel: UILabel! // sum of bucket
    
    @IBOutlet weak var myImage: UIImageView!  // image of Place
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var menu : [Dish]?  // array of dishes, that chosen category contains

    let bucket = Bucket.shareInstance
    var category : Category?
    
    
    override func viewDidLoad() {
        if let place = SingleTone.shareInstance.place {
            myImage.image = place.image
        }
        
        self.orderTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        nameLabel.text = SingleTone.shareInstance.place?.name
        sumLabel.text = bucket.allSum.description
        nameLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        orderTableView.reloadData()
    }
    
    func getNumberofItems(_ myCell: UITableViewCell){
        if let cell = myCell as? DishCell {
            cell.numberOfItems = 0
            for d in bucket.myBucket.keys {
                if d.id == cell.dish.id {
                    cell.numberOfItems = bucket.myBucket[d]!
                    break
                }
            }
        }
    }
    
    func addDish(_ dish: Dish) {
       // bucket.allSum += dish.price!  // TODO delete "!"
        sumLabel.text = bucket.allSum.description
    }
    func deleteDish(_ dish: Dish) {
      //  bucket.allSum -= dish.price!   // TODO delete "!"
        sumLabel.text = bucket.allSum.description
    }
    
    
    
    func showInfoDish(_ d: Dish) {
        let alertController = UIAlertController(title: "Information", message: d.dishDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
    
    
    @IBAction func backButton(_ sender: AnyObject) {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gest(_ sender: AnyObject) {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
}


// Mark : UITableViewDelegate, UITableViewDataSource

extension DishesVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let menu = menu else { return 0 }
        return menu.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menu = menu,
              let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell",for: indexPath) as? DishCell else { return UITableViewCell() }

            cell.dishName.text = menu[(indexPath as NSIndexPath).row].name
            cell.dish = menu[(indexPath as NSIndexPath).row]
            cell.priceLabel.text = menu[(indexPath as NSIndexPath).row].price?.description
            getNumberofItems(cell)  // TODO count in more elegant way
            cell.numberOfItemsLabel.text = cell.numberOfItems.description
            cell.cellDelegate = self
            cell.infoD = self
            
            return cell
    
    }

}
