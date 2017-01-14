//
//  PlacesList.swift
//  iOrder
//
//  Created by Boris Gurtovyy on 29.03.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class PlacesList: UITableViewController, CLLocationManagerDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // all Places
    var places = [Place]()
    
    // Places after Search
    var filteredPlaces = [Place]()
    
    // User location
    let locationManager = CLLocationManager()
    var firstLocation = true
    var lastLocation = CLLocation()
    
    
    override func viewDidLoad() {
        
        // LocationManager initializing
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        // async Places downloading
        getPlaces()
        
        // searchControllerDelegate
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        let logo = UIImage(named: "orderme")
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRect(x: 0,y: 0,  width: 21, height: 21)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
        navigationController?.isNavigationBarHidden = false

        // General Case, user did NOT read the QR code
        if !SingleTone.shareInstance.qrcodeWasDetected{
            Bucket.shareInstance.myBucket = [:]
            Bucket.shareInstance.allSum = 0
            SingleTone.shareInstance.tableID = -1
        }
        
        // If User read QRCODE
        if SingleTone.shareInstance.qrcodeWasDetected {
            SingleTone.shareInstance.qrcodeWasDetected = false
            if let PlaceMainMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "PlaceMainMenu") as? PlaceMainMenu {
                PlaceMainMenuVC.place = SingleTone.shareInstance.place
                self.navigationController?.pushViewController(PlaceMainMenuVC, animated: true)
            }
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    
    
    
    // async getting Array of places from API
    func getPlaces(){
        NetworkClient.getPlaces { (placesOpt, error) in
            if error != nil {
                print("error")
                return
            }
            guard let places = placesOpt else {
                return
            }
            self.places = places
            SingleTone.shareInstance.allplaces = self.places
            self.tableView.reloadData()
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as? PlaceCell
        if let PlaceMenu = segue.destination as? PlaceMainMenu {
            PlaceMenu.place = cell!.place
            SingleTone.shareInstance.place = cell!.place
            guard let id = cell?.place.id else {
                return
            }
            SingleTone.shareInstance.placeIdValidation = id
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
        
        if let QrCoder = segue.destination as? GetTableIdVC {
            QrCoder.noPlace = true
        }
        
    }
    
    // Mark :  CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myLocation = locations.last
        
        // update only if user moved more than on 100
        if firstLocation || lastLocation.distance(from: myLocation!) > 100  {
            for place in self.places{
                guard let placeLatitude = place.latitude,
                    let placeLongitute = place.longitude else {
                        return
                }
                let lat1 : NSString = placeLatitude as NSString
                let lng1 : NSString = placeLongitute as NSString
                
                let latitute: CLLocationDegrees =  lat1.doubleValue
                let longitute: CLLocationDegrees =  lng1.doubleValue
                let placeLocation = CLLocation(latitude: latitute, longitude: longitute)
                let d =  myLocation!.distance(from: placeLocation) / 1000
                place.distance = Double(round(10*d)/10)
                
                firstLocation = false
                
            }
            guard let myLoc = myLocation else { return }
            lastLocation = myLoc
            tableView.reloadData()
        }
    }
}


// Mark : UISearchResultsUpdating
extension PlacesList: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPlaces = places.filter { place in
            guard let name = place.name else {
                return false
            }
            return name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}


// Mark : UITableViewDataSource
extension PlacesList {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // if user searched smth
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredPlaces.count
        }
        
        return places.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell",for: indexPath) as? PlaceCell {
            let myPlace : Place!
            if searchController.isActive && searchController.searchBar.text != "" {
                myPlace = filteredPlaces[(indexPath as NSIndexPath).row]
            }
            else {
                myPlace = places[(indexPath as NSIndexPath).row]
            }
            
            cell.place = myPlace
            cell.placeName.text = myPlace.name
            cell.id = myPlace.id
            cell.placeAdress.text = myPlace.address
            cell.imagePath = myPlace.imagePath
            
            // if image is already downloaded
            if let image =  myPlace.image {
                cell.placeImage.image = image
            }
            else {  //  async downloading photo
                if let path = myPlace.imagePath { 
                    cell.downloadImage(path)
                }
            }
            if myPlace.distance == -1 {
                cell.distance.text = ""
            }
            else {
                if let description = myPlace.distance?.description {
                    cell.distance.text = description + " км"
                }
            }
            
            cell.placeName.backgroundColor = UIColor.darkGray.withAlphaComponent(0.15)
            cell.placeAdress.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
            cell.distance.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
            cell.placeName.textColor = UIColor.white.withAlphaComponent(1)
            
            
            return cell
        }
        
        return UITableViewCell()
    }
}
