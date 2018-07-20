//
//  WeatherService.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class WeatherService {
    
    let weatherUrl = URLGenerator.weatherApiUrlForPathString(path: "weatherdata")
    var weatherRequest: WeatherRequest
    
    init(_ weatherRequest: WeatherRequest) {
        self.weatherRequest = weatherRequest
    }
    
    func getWeather() -> Promise<Weather>  {
        
        let parameters = weatherRequest.toParameters()
        let headers = weatherRequest.getHeaders()
        
        return Promise { fulfill, reject in
            
            Alamofire.request(weatherUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
                
                switch response.result {
                case .success(let json):
                   
                    var weather: Weather? = nil
                    
                    if let weatherManagerDictionary = json as? NSDictionary {
                        let weatherManager = WeatherManager(weatherDictionary: weatherManagerDictionary)
                        weather = weatherManager.serialize()
                    }
                    
                    if(weather != nil) {
                        fulfill(weather!)
                    } else {
                        reject(WeatherBotError.weatherManagerDictionary)
                    }
                    
                case .failure(let error):
                    reject(error)
                }
                
            }
        
        }
    
    }

}

