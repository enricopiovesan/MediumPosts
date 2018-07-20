//
//  WeatherManager.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire

class WeatherManager {
    
    var weather: Weather? = nil
    var weatherDictionary: NSDictionary
    
    required init(weatherDictionary: NSDictionary) {
        self.weatherDictionary = weatherDictionary
    }
    
    // MARK:- Weather serialize
    func serialize() -> Weather? {
        
        var condition: Condition? = nil
        var weatherForecast: [WeatherForecast]? = nil
        var unit: Unit? = nil
        var location: Location? = nil
        var wind: Wind? = nil
        var atmosphere: Atmosphere? = nil
        var astronomy: Astronomy? = nil
        
        if let queryDictionary = weatherDictionary["query"] as? NSDictionary {
            if let resultDictionary = queryDictionary["results"] as? NSDictionary {
                if let channelDictionary = resultDictionary["channel"] as? NSDictionary {
                    
                    //unit
                    if let value = channelDictionary["units"] as? NSDictionary {
                        let speed = value["speed"] as! String
                        let pressure = value["pressure"] as! String
                        let distance = value["distance"] as! String
                        let temperature = value["temperature"] as! String
                        unit = Unit(distance: distance, pressure: pressure, speed: speed, temperature: temperature)
                    }
                    
                    //Location
                    if let value = channelDictionary["location"] as? NSDictionary {
                        let city = value["city"] as! String
                        let country = value["country"] as! String
                        let region = value["region"] as! String
                        location = Location(city: city, country: country, region: region)
                    }
                    
                    //Wind
                    if let value = channelDictionary["wind"] as? NSDictionary {
                        let chill = value["chill"] as! String
                        let direction = value["direction"] as! String
                        let speed = value["speed"] as! String
                        wind = Wind(chill: chill.floatValue, direction: direction.floatValue, speed: speed.floatValue)
                    }
                    
                    //Atmosphere
                    if let value = channelDictionary["atmosphere"] as? NSDictionary {
                        let humidity = value["humidity"] as! String
                        let pressure = value["pressure"] as! String
                        let rising = value["rising"] as! String
                        let visibility = value["visibility"] as! String
                        atmosphere = Atmosphere(humidity: humidity.floatValue, pressure: pressure.floatValue, rising: rising.floatValue, visibility: visibility.floatValue)
                    }
                    
                    //Astronomy
                    if let value = channelDictionary["astronomy"] as? NSDictionary {
                        let sunrise = value["sunrise"] as! String
                        let sunset = value["sunset"] as! String
                        astronomy = Astronomy(sunrise: sunrise, sunset: sunset)
                    }
                    
                    if let itemDictionary = channelDictionary["item"] as? NSDictionary {
                        
                        //condition
                        if let value = itemDictionary["condition"] as? NSDictionary {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "E, dd MMM yyyy hh:mm a zzz"
                            let weatherIcon = WeatherIcon(code: value["code"]! as! String)
                            let date = dateFormatter.date(from: value["date"]! as! String)
                            let temp = (value["temp"]! as! String).floatValue
                            let text = value["text"] as! String

                            condition = Condition(weatherIcon: weatherIcon, date: date ?? Date(), temp: temp, text: text)
                        }
                        
                        //Weather Forecast
                        if let value = itemDictionary["forecast"] as? [NSDictionary] {
                            weatherForecast = value.map { forecast in
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "dd MMM yyyy"
                                let weatherIcon = WeatherIcon(code: forecast["code"]! as? String ?? "0")
                                let date = dateFormatter.date(from: forecast["date"]! as? String ?? "none")
                                let day = forecast["day"]! as! String
                                let high = (forecast["high"]! as! String).floatValue
                                let low = (forecast["low"]! as! String).floatValue
                                let text = forecast["text"]! as! String
                                
                                return WeatherForecast(weatherIcon: weatherIcon, date: date!, day: day, high: high, low: low, text: text)
                            }
                        }
                        
                    }
                }
                
                if condition == nil && weatherForecast == nil {
                    print("condition or weatherForecast is nil for Weather Dictionary")
                    return nil
                } else {
                    weather = Weather(weatherForecast: weatherForecast!, condition: condition!, unit: unit, location: location, wind: wind, atmosphere: atmosphere, astronomy: astronomy)
                }
                
            }
            
        }
        
        return weather
        
    }
    
}

