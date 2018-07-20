//
//  Intent.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import PromiseKit
import MapKit

enum IntentType {
    case weather
    case weatherCondition
    case smalltalkGreetingsHello
    case unKnow
}

class Intent {
    
    var intentName: String
    var intentType: IntentType
    var parameters: NSDictionary?
    var speech : String?
    var dates : [Date]?
    var address : AddressIntent?
    var weather : WeatherIntent?

    init(intentName: String) {
        print(intentName)
        self.intentName = intentName
        switch intentName {
        case "weather.condition":
            self.intentType = .weatherCondition
        case "weather":
            self.intentType = .weather
        case "smalltalk.greetings.hello":
            self.intentType = .smalltalkGreetingsHello
        default:
            self.intentType = .unKnow
        }
    }
    
    func setParametes(_ parameters: NSDictionary) {
        self.parameters = parameters
        address = AddressIntent(parameters)
        weather = WeatherIntent(parameters)
        dates = getDate(parameters)
    }
    
    func getDate(_ parameters: NSDictionary) -> [Date]? {
        if let date = parameters["date-time"] as? String {
            var dates = [Date]()
            let datesString = date.split(separator: "/")
            for dateString in datesString {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let dateObj = dateFormatter.date(from: String(dateString)) else {
                    return nil
                }
                dates.append(dateObj)
                
            }
            return dates
        } else {
            return nil
        }
    }
    
    func createMessage() -> Promise<Message>  {
        
        return Promise{ fulfill, reject in
            
            Action(self).updateMessage().then { message in
                fulfill(message)
            }.catch { (error) in
                reject(error)
            }
            
        }
    }
    
}
