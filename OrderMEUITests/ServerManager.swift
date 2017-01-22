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


let base_url: String = "https://peaceful-spire-96979.herokuapp.com"
//let base_url: String = "http://localhost:8080"


class NetworkClient {
    
    static let dateFormatter = DateFormatter() // for converting Dates to string
    
    // general request to the API, each function here will use this one
    static func send(api: String, method: HTTPMethod, parameters: Parameters?, token: String, completion: @escaping (_ result: String?, _ error: NSError?)->()) -> Void {
        
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            "Authorization": "Token " + token
        ]
        
        let url = (base_url + api) as URLConvertible
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.result.value, nil)
                case .failure(let error):
                    completion(nil, error as NSError?)
                }
        }
    }
    
    
    // For Testing
    static func addPlace(placeJson: [String: AnyObject]) -> Place? {
//        func response_completion( _ response_result: String? , response_error: NSError? ) -> Void {
//            if response_error != nil {
//                completion(nil, response_error)
//                return
//            }
//            guard let json = response_result else {
//                completion(nil, NSError())
//                return
//            }
//            let place :Place? = Mapper<Place>().map(JSONString: json)
//            
//            completion(place, nil)
//        }
//        
//        send(api: "/places", method: .post, parameters: placeJson, token: "", completion: response_completion)
//        
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
        ]
        
        let response = Alamofire.request(base_url + "/places", method: .post, parameters: placeJson, headers : headers).responseJSON(options: .allowFragments)
        if let json = response.result.value {
            print(json)
            let place : Place? = Mapper<Place>().map(JSONObject: json)
            return place
        }
        return nil
    }
    
    static func deletePlace(id: Int, completion: @escaping (_ success: Bool?, _ error : NSError?) -> () ) {
        func response_completion( _ response_result: String? , response_error: NSError? ) -> Void {
            if response_error != nil {
                completion(nil, response_error)
                return
            }
            completion(true, nil)
        }
        
        send(api: "/places/\(id)", method: .delete, parameters: nil, token: "", completion: response_completion)
        
    }
    
}
