//
//  PlaceCell.swift
//  iOrder
//
//  Created by Boris Gurtovyy on 29.03.16.
//  Copyright © 2016 Boris Gurtovoy. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAdress: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var distance: UILabel!
    var id : Int?
    var place : Place!
    var imagePath : String?
    var placePhoto : UIImage?
    
    
    // async photo downloading
    func downloadImage(_ url : String) {
        NetworkClient.downloadImage(url: url) { (imageOpt, error) in
            if error != nil {
                print(error)
                return
            }
            guard let image = imageOpt else {
                return
            }
            self.placePhoto = imageOpt
            self.place.image = imageOpt
            DispatchQueue.main.async {
                self.placeImage.image = image
            }
        }
    }
    
    
}
