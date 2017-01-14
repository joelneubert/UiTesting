//
//  DateVC.swift
//  iOrder
//
//  Created by Boris Gurtovyy on 30.03.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit

class ReserveVC: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var numberOfPeople: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bookButton: UIButton!
    
    var chosenDate : String?
    var reserve : Reserve?
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        if let place = SingleTone.shareInstance.place {
            myImageView.image = place.image
            nameLabel.text = SingleTone.shareInstance.place?.name
            nameLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
     navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func bookTable(_ sender: AnyObject) {
        
        if phoneText.text == "" {
            showAlertWithOkButton(title: "We need your phone number", message: "Write your phone number, please")
            return
        }
        if numberOfPeople.text == "" {
            showAlertWithOkButton(title: "We need the number of people", message: "How many of you are going to visit \(SingleTone.shareInstance.place), please")
            return
        }
        if SingleTone.shareInstance.user == nil {
            showAlertWithLoginFacebookOption()
            return
        }
        guard let phoneNumber = phoneText.text,
              let numberPeople = Int(numberOfPeople.text!) else {
                return
        }
        let date = datePicker.date
        if date < Date() {
            showAlertWithOkButton(title: "Error", message: "Incorrect date")
            return
        }
        
        guard let place = SingleTone.shareInstance.place else { return }

        let myReserve = Reserve(id: 0, place: place, date: date, created: Date(), phoneNumber: phoneNumber, numberOfPeople: numberPeople)
        bookButton.isEnabled = false
        NetworkClient.makeReservation(reserve: myReserve) { (id, error) in
            self.bookButton.isEnabled = true
            if error != nil {
                self.errorAlert()
                return
            }
            myReserve.id = id
            self.reserve = myReserve
            self.successAlert()
            self.phoneText.text = ""
            self.numberOfPeople.text = ""
            SingleTone.shareInstance.newReservation?.addNewReservation(reserve: myReserve)
        }

    }
    
    func showAlertWithLoginFacebookOption() {
        let alertController = UIAlertController(title: "You did not login", message: "You need to login for making orders", preferredStyle: .alert)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
      _ =  self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gest(_ sender: AnyObject) {
      _ =   self.navigationController?.popViewController(animated: true)
    }
    
    
}

// Alerts after request 
extension ReserveVC {
    func errorAlert(){
        showAlertWithOkButton(title: "Ooops", message: "Some problems with connection. Try again")
    }
    
    func successAlert() {
        showAlertWithOkButton(title: "Success!", message: "Your table was successfully booked")
    }
}

// general Alert with OK button
extension ReserveVC {
    func showAlertWithOkButton(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
