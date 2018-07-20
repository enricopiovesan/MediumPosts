//
//  WeatherParameters.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-08.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import MapKit
import UIKit

class WeatherParameters {
    
    var parametersDictionary: NSDictionary
    var weatherCondition: WeatherCondtionType?
    var date: Date?
    var locationParameter: LocationParameter?
    
    init(parametersDictionary: NSDictionary) {
        self.parametersDictionary = parametersDictionary
        self.updateDate()
        self.updateWeatherCondition()
        self.updateLocation()
    }
    
    func updateDate() {
        if let date = self.parametersDictionary["date"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            self.date = dateFormatter.date(from: date)
        }
    }
    
    func updateWeatherCondition() {
        
        if let condition = self.parametersDictionary["condition"] as? String {
            switch condition {
            case "rain":
                self.weatherCondition = .rain
            case "snow":
                self.weatherCondition = .snow
            case "wind":
                self.weatherCondition = .wind
            case "sun":
                self.weatherCondition = .sun
            case "shower":
                self.weatherCondition = .shower
            case "fog":
                self.weatherCondition = .fog
            case "ice":
                self.weatherCondition = .ice
            case "thunderstorm":
                self.weatherCondition = .thunderstorm
            case "freezingRain":
                self.weatherCondition = .freezingRain
            case "rainSnow":
                self.weatherCondition = .rainSnow
            case "smoke":
                self.weatherCondition = .smoke
            case "overcast":
                self.weatherCondition = .overcast
            case "clouds":
                self.weatherCondition = .clouds
            case "foggy":
                self.weatherCondition = .foggy
            case "tornadoes":
                self.weatherCondition = .tornadoes
            case "storm":
                self.weatherCondition = .storm
            case "drizzle":
                self.weatherCondition = .drizzle
            case "hurricanes":
                self.weatherCondition = .hurricanes
            default:
                self.weatherCondition = nil
            }
        }
        
    }
    
    func updateLocation() {
        
        
        if let location = self.parametersDictionary["address"] as? NSDictionary {
            var locationParameter = LocationParameter()
            if let value = location["country"] as? String {
                locationParameter.country = value
            }
            if let value = location["city"] as? String {
                locationParameter.city = value
            }
            if let value = location["street-address"] as? String {
                locationParameter.address = value
            }
            self.locationParameter = locationParameter
        }
        
    }
    
}

enum WeatherCondtionType {
    case rain
    case snow
    case wind
    case sun
    case shower
    case fog
    case ice
    case thunderstorm
    case freezingRain
    case rainSnow
    case haze
    case smoke
    case overcast
    case clouds
    case foggy
    case tornadoes
    case storm
    case drizzle
    case hurricanes
}

struct LocationParameter {
    var country : String?
    var city : String?
    var address : String?
}

