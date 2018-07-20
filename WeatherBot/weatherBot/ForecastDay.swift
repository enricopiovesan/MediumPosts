//
//  ForecastHour.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-07-17.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit

struct Temperature {
    var degree: Int
    var measure: String
}

class ForecastDay {

    var weatherIcon: WeatherIcon
    var max: Temperature
    var min: Temperature
    var date: Date
    
    init (weatherIcon: WeatherIcon, max: Temperature, min: Temperature, date: Date) {
        self.min = min
        self.max = max
        self.date = date
        self.weatherIcon = weatherIcon
    }
    
}
