//
//  TwoButtons.swift
//  iOrder
//
//  Created by Boris Gurtovyy on 29.03.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit
import MapKit

class PlaceMainMenu: UIViewController {
    
    let sTone = SingleTone.shareInstance
    
    @IBOutlet weak var myTableView: UITableView!
    var place : Place?
    
    @IBOutlet weak var placeImage: UIImageView!
    
    // names of buttons in rows in static table
    var actions : [String] = []
    
    // photos in rows in static table
    var photosOfAction : [String] = []
    
    // menu, that will be downloaded async later
    var menu : Menu? = nil
    
    @IBOutlet weak var labelName: UILabel!
    
    override func viewDidLoad() {
        
        self.title = place?.name
        
        let address = place?.address ?? ""
        let phoneNumber = place?.phone ?? ""
        
        // titles of main buttons
        actions = ["Detect table","Menu", "Reservation", "Call a waiter", phoneNumber, address]
        
        // icons of main buttons
        photosOfAction = ["qrcode","list","folkandknife","waiter","phone","adress"]
        myTableView.dataSource = self
        myTableView.delegate = self
        if let plImage = place?.image  {
            placeImage.image = plImage
        }
        else {
            downloadImage(place?.imagePath)
        }
        
        // async loading Menu For next Viewcontroller
        loadMenu()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.isNavigationBarHidden = true
        //self.prefersStatusBarHidden
        labelName.text = place?.name
        myTableView.reloadData()
        labelName.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
    }
    
    
    // downloading an image (only if app did not downloaded it in the previous VC )
    func downloadImage(_ urlOpt : String?) {
        guard let url = urlOpt else { return }
        NetworkClient.downloadImage(url: url) { (imageOpt, error) in
            if error != nil {
                return
            }
            guard let image = imageOpt else {
                return
            }
            
            
            //DispatchQueue.main.async {
            self.place?.image = imageOpt
            self.placeImage.image = image
            //}
        }
    }
    
    
    
    // ask about reason
    func callAWaiter() {
        // 1 - bring a menu
        // 2 - bring a check
        // 3 - clean the table
        // 4 - other
        // 5 - cancel
        
        let alertController = UIAlertController(title: "The waiter is on his way", message: "How can he help you?", preferredStyle: .alert)
        
        
        let menuAction = UIAlertAction(title: "Bring a menu", style: .default) { (action:UIAlertAction!) in
            self.callWaiterRequest(1)
        }
        let checkAction = UIAlertAction(title: "Bring a bill", style: .default) { (action:UIAlertAction!) in
            self.callWaiterRequest(2)
        }
        let cleanAction = UIAlertAction(title: "Clean the table", style: .default) { (action:UIAlertAction!) in
            self.callWaiterRequest(3)
        }
        let shishaAction = UIAlertAction(title: "Call a hookah man", style: .default) { (action:UIAlertAction!) in
            self.callWaiterRequest(4)
        }
        let otherAction = UIAlertAction(title: "Other", style: .default) { (action:UIAlertAction!) in
            self.callWaiterRequest(5)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(menuAction)
        alertController.addAction(checkAction)
        alertController.addAction(cleanAction)
        alertController.addAction(shishaAction)
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    
    // Send request with specific reason of calling waiter
    func callWaiterRequest(_ reason: Int) {
        
        let placeId = place?.id
        let date = Date()
        let idTable = SingleTone.shareInstance.tableID
        
        NetworkClient.callAWaiter(placeId: placeId!, idTable: idTable, date: date, reason: reason) { (success, error) in
            if error != nil {
                self.showAlert(title: "Ooops", message: "Some problems with connection")
            }
            else {
                self.showAlert(title: "Got it!", message: "The waiter is on his way")
            }
        }
        
    }
    
    
    // general AlertController with OK action
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    @IBAction func backButton(_ sender: AnyObject) {
        _ =  navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gest(_ sender: AnyObject) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
    func openMapForPlace() {
        
        guard let lat1  = place?.latitude ,
            let lng1  = place?.longitude  else {
                return
        }
        
        guard let latitute: CLLocationDegrees =  Double(lat1),
            let longitute: CLLocationDegrees =  Double(lng1) else {
                return
        }
        
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        if let name = self.place?.name {
            mapItem.name = "\(name)"
        }
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    
    func loadMenu(){ // async downloading menu for newxt VC
        guard let id = place?.id else { return }
        NetworkClient.getMenu(placeId: id) { (menu, error) in
            if error != nil {
                self.showAlert(title: "Ooops", message: "Check the connection, please")
            }
            
            self.menu = menu
            // TODO make delegate to pass the menu even if user is already on the next ViewController
            
        }
    }
    
    
}

// Mark: UITableViewDataSource

extension PlaceMainMenu : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "actionCell",for: indexPath) as? ActionCell {
            
            cell.actionName!.text = actions[(indexPath as NSIndexPath).row]
            
            let imageName : String = photosOfAction[(indexPath as NSIndexPath).row]
            cell.actionPhoto?.image = UIImage(named: imageName)
            
            if (indexPath as NSIndexPath).row == 0 {
                if sTone.tableID != -1 {
                    
                    cell.actionName.text = "Table #" + sTone.tableID.description
                }
            }
            
            
            return cell
        }
        
        return UITableViewCell()
        
    }
}



// Mark : UITableViewDelegate


/*
 1) Detect table
 2) Menu
 3) Reservation
 4) Call a waiter
 5) Phone number
 6) Adress
 */
extension PlaceMainMenu : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        let pressedButton = (indexPath as NSIndexPath).row
        
        
        
        switch pressedButton {
            
        case 0 :  // Detecting table ID -  if app runs on simulator go to SimulatorTableId,
            // else go to GetTableIdVc (QRcode scanner )
            
            if Platform.isSimulator {
                self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "simulatorTable") as! SimulatorTableId, animated: true)
                
            }
            else {
                self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "getTable") as! GetTableIdVC, animated: true)
            }
            
            
        case 1 : // open CategoriesVC for chosing menu
            if let CategoriesVC = self.storyboard!.instantiateViewController(withIdentifier: "CatVC") as? CategoriesVC {
                CategoriesVC.menu = self.menu
                self.navigationController!.pushViewController(CategoriesVC, animated: true)
            }
            
        case 2 : // open ReserveVC for reserving table
            self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "reserveVC") as! ReserveVC, animated: true)
            
            
        case 3 :
            if sTone.tableID != -1 {
                callAWaiter()
            }
            else {
                let alertController = UIAlertController(title: "Pick the table, please", message: "Capture QR code on your table, please", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
                    self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "getTable") as! GetTableIdVC, animated: true)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion:nil)
            }
            
            
        case 4 :
            let phoneNumber = actions[4]
            guard let placeName = place?.name else { return }
            let alertController = UIAlertController(title: "Call \(placeName)", message: "Call \(phoneNumber)?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                
                if let phoneCallURL:URL = URL(string: "tel://\(phoneNumber)") {
                    let application:UIApplication = UIApplication.shared
                    if (application.canOpenURL(phoneCallURL)) {
                        application.openURL(phoneCallURL);
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction!) in
                
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion:nil)
            
            
        case 5 :
            openMapForPlace()
            
        default : break
        }
        
    }
    
}




