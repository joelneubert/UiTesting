//
//  ServerManager.swift
//  orderMe
//
//  Created by Boris Gurtovyy on 6/9/17.
//  Copyright © 2017 Boris Gurtovoy. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import Alamofire_Synchronous

let base_url : String = "https://peaceful-spire-96979.herokuapp.com"

class ServerManager  {
    
    
    static func addPlace(placeJson: [String: String]) -> Place? {
        let headers = [
            "Content-Type" : "application/json"
        ]
        
        let response = Alamofire.request(base_url + "/places", method: .post, parameters: placeJson, encoding: JSONEncoding.default, headers: headers).responseJSON()
        
        if let json = response.result.value {
            let place : Place? = Mapper<Place>().map(JSONObject : json)
            return place
        }
        return nil
    }
    
    static func deletePlace(id: Int) -> Bool {
        let headers = [
            "Content-Type" : "application/json"
        ]
        
        let response = Alamofire.request(base_url + "/places/\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON()
        return response.result.isSuccess
    }
    

}
