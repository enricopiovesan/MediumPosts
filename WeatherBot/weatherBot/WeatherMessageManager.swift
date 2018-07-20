//
//  WeatherMessageManager.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-09.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import Foundation
import PromiseKit
import MapKit


class WeatherMessageManager {
    
    var weatherParameters : WeatherParameters?
    
    init(weatherParameters: NSDictionary?) {
        if(weatherParameters != nil) {
            self.weatherParameters = WeatherParameters(parametersDictionary: weatherParameters!)
        }
    }
    
    func getLocation() -> Promise<CLLocationCoordinate2D>  {
        
        return Promise { fulfill, reject in
            if(weatherParameters != nil && weatherParameters!.locationParameter != nil) {
                
                let geocodingRequest = GeocodingRequest(address: weatherParameters!.locationParameter!.city!)
                let geocodingService = GeocodingService(geocodingRequest)
                
                firstly{
                    geocodingService.getGeoCoding()
                }.then { (geocoding) -> Void in
                    fulfill(geocoding.coordinates)
                }.catch { (error) in
                    reject(error)
                }
                
            } else {
                firstly {
                    CLLocationManager.promise()
                }.then { location in
                    fulfill(location.coordinate)
                }.catch { (error) in
                        reject(error)
                }
            }
        }
        
    }
    
}
