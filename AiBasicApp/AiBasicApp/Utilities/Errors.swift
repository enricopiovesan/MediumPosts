//
//  Errors.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-04.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

enum WeatherBotError: Error {
    case unKnowIntent
    case weatherManagerDictionary
    case aiManagerDictionary
    case geocodingManagerDictionary
}
