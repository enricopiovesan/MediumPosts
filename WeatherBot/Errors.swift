//
//  Errors.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-12-27.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import Foundation

enum WeatherBotError: Error {
    case unKnowIntent
    case weatherManagerDictionary
    case aiManagerDictionary
    case geocodingManagerDictionary
}
