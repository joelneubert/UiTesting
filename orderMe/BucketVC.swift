//
//  BucketVC.swift
//  iOrder
//
//  Created by Boris Gurtovyy on 05.04.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit
import Foundation

class BucketVC : UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    
    @IBOutlet weak var sumLabel: UILabel!  // sum of order
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var commentText: UITextView!  // place for comment
    
    var dishesInBucket : [Dish]?
    var amountOfDishesInBucket : [Int]?
    
    var myOrder : Order?
    
    override func viewDidLoad() {
        sumLabel.text = Bucket.shareInstance.allSum.description  // show current sum from Bucket
        makeBucket()
        commentText.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        myTableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0)
        myTableView.dataSource = self
        commentText.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // transfer from current Bucket array of dishes and array of amounts of same dishes
    func makeBucket(){
        let bucket = Bucket.shareInstance.myBucket
        let dishes = bucket.keys
        dishesInBucket = Array(dishes)
        let amount = bucket.values
        amountOfDishesInBucket = Array(amount)
    }
    
    // Hide keyboard after writing comment
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    // delete everything in the Bucket and on the current ViewController
    @IBAction func deleteAll(_ sender: AnyObject) {
        Bucket.shareInstance.myBucket = [:]
        Bucket.shareInstance.allSum = 0
        dishesInBucket = []
        amountOfDishesInBucket = []
        sumLabel.text = "0"
        commentText.text = ""
        myTableView.reloadData()
    }
    
    
    @IBAction func makeAnOrder(_ sender: AnyObject) {
        
        // if the user did not scan the QR code yet, program forces him to do that before ordering
        if SingleTone.shareInstance.tableID == -1 {
            let alertController = UIAlertController(title: "Choose a table", message: "Scan the QR code, please and the program will detect the number of your table", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "getTable") as! GetTableIdVC, animated: true)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion:nil)
        }
            
        else { // user scanned QR code
            if Bucket.shareInstance.myBucket.isEmpty { // user did not select any dishes
                showAlertWithOkButton(title: "Empty order", message: "You did not choose any dishes, try again")
            }
            else if SingleTone.shareInstance.user == nil {
                showAlertWithLoginFacebookOption()
            }
            else { // make a request Order
                makeRequestOrder()
            }
        }
    }
    
    func showAlertWithLoginFacebookOption() {
        let alertController = UIAlertController(title: "You did not login", message: "You need to login for reservations", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction!) in
            
        }
        let toFacebookAction = UIAlertAction(title: "Login", style: .default) { (action: UIAlertAction) in
            if let LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController {
                LoginVC.cameFromReserveOrOrderProcess = true
                self.navigationController?.pushViewController(LoginVC, animated: true)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(toFacebookAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func makeRequestOrder() {
        guard let place = SingleTone.shareInstance.place else { return }
        
        
        
        var extraComments = ""
        
        if let comments = commentText.text {
            if comments != "Your comments: " {
                extraComments = comments
            }
        }
        
        let order = Order(id: -1, place: place, idTable: SingleTone.shareInstance.tableID, bucket: Bucket.shareInstance.myBucket, comments: extraComments, created: Date(), sum: Bucket.shareInstance.allSum)
        
        NetworkClient.makeOrder(order: order) { (id, error) in
            if error != nil {
                self.errorAlert()
                return
            }
            order.id = id
            self.myOrder = order
            self.succesAlert()
            SingleTone.shareInstance.newOrder?.addNewOrder(order: order)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let comments = commentText.text {
            if comments == "Your comments: " {
                commentText.text = ""
            }
        }
        
    }
    
    
    @IBAction func backButton(_ sender: AnyObject) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gest(_ sender: AnyObject) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
}

// Mark : UITableViewDataSource

extension BucketVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bucket.shareInstance.myBucket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell",for: indexPath) as? BucketCell {
            cell.dishName.text = dishesInBucket?[(indexPath as NSIndexPath).row].name
            cell.amountLabel.text = amountOfDishesInBucket?[(indexPath as NSIndexPath).row].description
            
            guard let priceOfOneDish = dishesInBucket?[(indexPath as NSIndexPath).row].price,
                let amountOfDish = amountOfDishesInBucket?[(indexPath as NSIndexPath).row]
                else {
                    return UITableViewCell()
            }
            let price = priceOfOneDish * Double(amountOfDish)
            cell.priceLabel.text = price.description
            cell.dish = dishesInBucket?[(indexPath as NSIndexPath).row]
            
            cell.bucketCellDelegateAddDelete = self
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0)
            return cell
        }
        
        return UITableViewCell()
    }
}

// Mark : BucketCellProtocolAddDelete

extension BucketVC : BucketCellProtocolAddDelete {
    func addDish(_ dish: Dish) {
        let newPrice = Bucket.shareInstance.allSum
        sumLabel.text = newPrice.description
    }
    
    func deleteDish(_ dish: Dish) {
        let newPrice = Bucket.shareInstance.allSum
        sumLabel.text = newPrice.description
    }
    
}

// Mark : Alerts after request
extension BucketVC {
    func succesAlert(){
        deleteAll(0 as AnyObject)
        showAlertWithOkButton(title: "Success!", message: "Your order was successfully sent to the kitchen")
    }
    
    func errorAlert(){
        showAlertWithOkButton(title: "Oooops", message: "Some problem with connection. Try again.")
    }
}

// general Alert with OK button
extension BucketVC {
    func showAlertWithOkButton(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
