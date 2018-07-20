//
//  Forecast.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-07-17.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import Foundation

class Forecast {
    
    var city: String
    var date: Date
    var weatherIcon: WeatherIcon
    var forecastDays: [ForecastDay]
    
    init (city: String, forecastDays: [ForecastDay], date: Date, weatherIcon: WeatherIcon) {
        self.city = city
        self.forecastDays = forecastDays
        self.date = date
        self.weatherIcon = weatherIcon
    }
    
    convenience init (weather: Weather) {
        let city = weather.location?.city ?? "Unknow City"
        let date = weather.condition.date
        let weatherIcon = weather.condition.weatherIcon
        let forecastDays = weather.forecast.map { (forecastDay) -> ForecastDay in
            let max = Temperature(degree: Int(forecastDay.high), measure: weather.unit?.temperature ?? "C")
            let min = Temperature(degree: Int(forecastDay.low), measure: weather.unit?.temperature ?? "C")
            return ForecastDay(weatherIcon: forecastDay.weatherIcon, max: max, min: min, date: forecastDay.date)
        }
        
        self.init(city: city, forecastDays: forecastDays, date: date, weatherIcon: weatherIcon)
        
    }

}
