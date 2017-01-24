//
//  ServerManager.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 1/22/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireImage
import Alamofire_Synchronous


//let base_url: String = "https://peaceful-spire-96979.herokuapp.com"
let base_url: String = "http://localhost:8080"


class NetworkClient {
    
    static let dateFormatter = DateFormatter() // for converting Dates to string
    
    // For Testing
    static func addPlace(placeJson: [String: String]) -> Place? {     
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
        ]
        
        let response = Alamofire.request(base_url + "/places", method: .post, parameters: placeJson, encoding: JSONEncoding.default, headers : headers).responseJSON(options: .allowFragments)
        if let json = response.result.value {
            print(json)
            let place : Place? = Mapper<Place>().map(JSONObject: json)
            return place
        }
        return nil
    }
    
    static func deletePlace(id: Int) -> Bool {
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            ]
        let response = Alamofire.request(base_url + "/places/\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers : headers).responseJSON()
        return response.result.isSuccess
    }
    
}
