//
//  WeatherIcon.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-07-17.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit

enum WeatherIconType {
    case sun
    case cloud
    case thunder
    case snow
    case rain
    case fog
    case windy
    case sunCloud
    case moon
    case na
    case moonCloud
}

class WeatherIcon {
    
    var code: String
    var weaterIconType: WeatherIconType?
    var image =  UIImage(named: "defaultIcon")
    
    init (code: String) {
        self.code = code
        self.weaterIconType = setImage()
        self.image = getImage()
    }
    
    func getImage() -> UIImage {
        
        switch weaterIconType! {
        case .sun:
            return UIImage(named: "icon_sun")!
        case .cloud:
            return UIImage(named: "icon_cloud")!
        case .thunder:
            return UIImage(named: "icon_thunder")!
        case .snow:
            return UIImage(named: "icon_snow")!
        case .rain:
            return UIImage(named: "icon_rain")!
        case .fog:
            return UIImage(named: "icon_fog")!
        case .windy:
            return UIImage(named: "icon_windy")!
        case .sunCloud:
            return UIImage(named: "icon_sun_cloud")!
        case .moon:
            return UIImage(named: "icon_moon")!
        case .na:
            return UIImage(named: "icon_na")!
        case .moonCloud:
            return UIImage(named: "icon_moon_cloud")!
        }
    }
    
    func setImage() -> WeatherIconType {
        
        let icon = Int(code) ?? 0
        
        let thunder = [0,1,2,3,37,38,39,40,45,47]
        let rain = [5,6,7,8,9,10,11,12,14,17,18,35]
        let snow = [13,15,16,41,42,43,46]
        let fog = [19,20,21,22]
        let wind = [23,24]
        let cloud = [25,26,44,]
        let sun_cloud = [28,30]
        let moon_cloud = [27,29]
        let moon = [31,33]
        let sun = [32,34,36,]
        
        if(thunder.contains(icon)){
            return .thunder
        } else if(rain.contains(icon)){
            return .rain
        } else if(snow.contains(icon)){
            return .snow
        } else if(fog.contains(icon)){
            return .fog
        } else if(wind.contains(icon)){
            return .windy
        } else if(cloud.contains(icon)){
            return .cloud
        } else if(sun_cloud.contains(icon)){
            return .sunCloud
        } else if(moon_cloud.contains(icon)){
            return .moonCloud
        } else if(sun.contains(icon)){
            return .sun
        } else if(moon.contains(icon)){
            return .moon
        } else {
            return .na
        }
        
    }
}
