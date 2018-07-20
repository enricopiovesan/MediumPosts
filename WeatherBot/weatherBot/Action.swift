//
//  ActionManager.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-09.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import PromiseKit

class Action {
    
    var intent : Intent
    
    init(_ intent: Intent) {
        self.intent = intent
    }
    
    // MARK:- Update Message content
    func updateMessage() -> Promise<Message> {
        return Promise{ fulfill, reject in
            switch intent.intentType {
            case .smalltalkGreetingsHello:
                smalltalkGreetingsHello().then { message in
                    fulfill(message)
                }
            case .weather:
                weatherAction().then { message in
                    fulfill(message)
                }.catch { (error) in
                    reject(error)
                }
            case .weatherCondition:
                weatherConditionAction().then { message in
                    fulfill(message)
                    }.catch { (error) in
                        reject(error)
                }
            case .unKnow:
                unkowAction().then { message in
                    fulfill(message)
                }
            }
        }
        
    }
    
    // MARK:- create a weather action
    func weatherAction() -> Promise<Message>  {
        let weatherMessageManager = WeatherMessageManager(weatherParameters: self.intent.parameters ?? nil)
        return Promise{ fulfill, reject in
            firstly{
                weatherMessageManager.getLocation()
                }.then { (coordinates) -> Promise<Weather> in
                    WeatherService(WeatherRequest(coordinates: coordinates)).getWeather()
                }.then {(weather) -> Void in
                    fulfill(Message(weather: weather))
                }.catch { (error) in
                    reject(error)
            }
        }
    }
    
    // MARK:- create a weather Condition action
    func weatherConditionAction() -> Promise<Message>  {
        let weatherMessageManager = WeatherMessageManager(weatherParameters: self.intent.parameters ?? nil)
        return Promise{ fulfill, reject in
            firstly{
                weatherMessageManager.getLocation()
                }.then { (coordinates) -> Promise<Weather> in
                    WeatherService(WeatherRequest(coordinates: coordinates)).getWeather()
                }.then {(weather) -> Void in
                    fulfill(Message(weather: weather, intent: self.intent))
                }.catch { (error) in
                    reject(error)
            }
        }
    }
    
    // MARK:- create an unkow action
    func smalltalkGreetingsHello() -> Promise<Message> {
        let textMessage = intent.speech != "" ? intent.speech : "Hello!"
        let message = Message(text: textMessage!, date: Date(), type: .botText)
        return Promise{ fulfill, reject in
            fulfill(message)
        }
    }
    
    // MARK:- create an unkow action
    func unkowAction() -> Promise<Message> {
        let textMessage = intent.speech != "" ? intent.speech : "I'm not sure I understand what you are saying, but I am learning more every day."
        let message = Message(text: textMessage!, date: Date(), type: .botText)
        return Promise{ fulfill, reject in
            fulfill(message)
        }
    }
    
}
