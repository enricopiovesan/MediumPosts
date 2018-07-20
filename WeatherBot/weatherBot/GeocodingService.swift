//
//  GeocodingService.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class GeocodingService {
    
    var geocodingUrl = URLGenerator.geocodingApiUrlForPathString(path: "json")
    var geocodingRequest: GeocodingRequest
    
    init(_ geocodingRequest: GeocodingRequest) {
        self.geocodingRequest = geocodingRequest
    }
    
    func getGeoCoding() -> Promise<Geocoding> {
        
        let parameters = geocodingRequest.toParameters()
        
        return Promise { fulfill, reject in
            
            Alamofire.request(geocodingUrl, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in

                    switch response.result {
                    case .success(let json):
                        
                        var geocoding: Geocoding? = nil
                        if let geocodingManagerDictionary = json as? NSDictionary {
                            let geocodingManager = GeocodingManager(geocodingDictionary: geocodingManagerDictionary)
                            geocoding = geocodingManager.serialize()
                        }
                        
                        if geocoding != nil {
                            fulfill(geocoding!)
                        } else {
                            reject(WeatherBotError.geocodingManagerDictionary)
                        }
                        
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
        
    }
    
}
