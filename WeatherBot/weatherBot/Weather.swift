//
//  Weather.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit

class Weather {
    
    var forecast: [WeatherForecast]
    var condition: Condition
    
    var description: String?
    var unit: Unit?
    var location: Location?
    var wind: Wind?
    var atmosphere: Atmosphere?
    var astronomy: Astronomy?
    var lang: String?
    
    required init(weatherForecast: [WeatherForecast], condition: Condition, unit: Unit?, location: Location?, wind: Wind?, atmosphere: Atmosphere?, astronomy: Astronomy?) {
        self.forecast = weatherForecast
        self.condition = condition
        self.unit = unit
        self.location = location
        self.wind = wind
        self.astronomy = astronomy
        self.atmosphere = atmosphere
    }
    
}

struct Condition {
    var weatherIcon : WeatherIcon
    var date : Date
    var temp : CGFloat
    var text : String
}

struct Unit {
    var distance : String
    var pressure : String
    var speed : String
    var temperature : String
}

struct Location {
    var city : String
    var country : String
    var region : String
}

struct Wind {
    var chill : CGFloat
    var direction : CGFloat
    var speed : CGFloat
}

struct Atmosphere {
    var humidity : CGFloat
    var pressure : CGFloat
    var rising : CGFloat
    var visibility : CGFloat
}

struct Astronomy {
    var sunrise : String
    var sunset : String
}

struct WeatherForecast {
    var weatherIcon : WeatherIcon
    var date : Date
    var day : String
    var high : CGFloat
    var low : CGFloat
    var text : String
}
