//
//  ReservesController.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/2/16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit

class ReservesController: UIViewController, RepeatQuestionProtocol {
    
    @IBOutlet weak var reservesTable: UITableView!
    
    var pastReserves :[Reserve] = []
    var futureReserves: [Reserve] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reservesTable.dataSource = self
        if SingleTone.shareInstance.user != nil {
            loadData()
            SingleTone.shareInstance.newReservation = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SingleTone.shareInstance.user == nil {
            showAlertWithLoginFacebookOption()
        }
    }
    
    func loadData(){
        NetworkClient.getReservations { (reservations, error) in
            if error != nil {
                return
            }
            guard let reservs = reservations else { return }
            
            for reserve in reservs {
                guard let dateOfReserve = reserve.date else { return }
                if dateOfReserve > Date() {
                    self.futureReserves.append(reserve)
                } else {
                    self.pastReserves.append(reserve)
                }
            }
            self.reservesTable.reloadData()
        }
        
    }
    
    
    func repeatQuestion(_ reserve: Reserve){
        guard let name = reserve.place?.name else { return }
        let alertController = UIAlertController(title: "Cancel", message: "Are you sure that you want to cancel your reservation in \(name)?" , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes, cancel", style: .default) { (action:UIAlertAction!) in
            guard let id = reserve.id else { return }
            NetworkClient.deleteReservation(id: id, completion: { (success, error) in
                if error != nil {
                    self.notOkAlert()
                }
                self.okAlert()
                var i = 0
                for futureReserve in self.futureReserves {
                    guard let reserveId = reserve.id,
                        let futureReserveId = futureReserve.id else {
                            return
                    }
                    if reserveId == futureReserveId {
                        self.futureReserves.remove(at: i)
                        self.reservesTable.reloadData()
                        break
                    }
                    i += 1
                }
                
            })
            
        }
        let cancelAction = UIAlertAction(title: "I don`t want to cancel", style: .default, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    
    func okAlert(){
        showAlert(title: "Cancelation", message: "Thank you! Your reservation was canceled")
    }
    
    func notOkAlert() {
        showAlert(title: "Ooops", message: "Some problems with connection")
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func showAlertWithLoginFacebookOption() {
        let alertController = UIAlertController(title: "You did not login", message: "You need to login for viewing your reservations", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction!) in
            self.tabBarController?.selectedIndex = 1
        }
        let toFacebookAction = UIAlertAction(title: "Login", style: .default) { (action: UIAlertAction) in
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(toFacebookAction)
        self.present(alertController, animated: true, completion:nil)
    }
}


// Mark : UITableViewDataSource
extension ReservesController : UITableViewDataSource{
    
    // 1 section - Future reservatoins
    // 2 section - Past reservations
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Future reservations"
        }
        return "History of reservations"
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return futureReserves.count
        }
        else {
            return pastReserves.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ((indexPath as NSIndexPath).section) {
        case 0  :  // Future cells
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FutureCell",for: indexPath) as? FutureReserve {
                let myreserve = futureReserves[(indexPath as NSIndexPath).row]
                
                cell.placename.text = myreserve.place?.name
                guard let dateOfReservation = myreserve.date else {
                    return UITableViewCell()
                }
                cell.data.text = dateOfReservation.makeDateRepresentation()
                cell.reserve = myreserve
                cell.repquestion = self
                return cell
            }
            
        case 1  : // Past cells
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PastCell",for: indexPath) as? PastReserve {
                let numberOfPastReserveInArray = (indexPath as NSIndexPath).row
                let myreserve = pastReserves[numberOfPastReserveInArray]
                cell.placeName.text = myreserve.place?.name
                guard let dateOfReservation = myreserve.date else {
                    return UITableViewCell()
                }
                cell.data.text = dateOfReservation.makeDateRepresentation()
                
                return cell
            }
            
        default : return UITableViewCell()
        }
        return UITableViewCell()
    }
    
}

//MARK: NewReservationProtocol
extension ReservesController : NewReservationProtocol {
    func addNewReservation(reserve: Reserve) {
        self.futureReserves.append(reserve)
        self.reservesTable.reloadData()
    }
}

extension Date {
    func makeDateRepresentation() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        return "\(month).\(day).\(year)  \(hour):\(minutes)"
    }
}
