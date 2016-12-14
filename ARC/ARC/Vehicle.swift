//
//  Vehicle.swift
//  ARC
//
//  Created by Enrico Piovesan on 12/12/2016.
//  Copyright © 2016 none. All rights reserved.
//

import Foundation

class Vehicle {
    
    let type: String
    //var stormtrooper : Stormtrooper?
    weak var stormtrooper: Stormtrooper? //solution
    
    init(type: String) {
        self.type = type
        print("\(type) is being initialised")
    }
    
    deinit {
        print("\(type) is being deinitialised")
    }
    
}
