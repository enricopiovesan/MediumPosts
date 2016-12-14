//
//  Stormtrooper.swift
//  ARC
//
//  Created by Enrico Piovesan on 12/12/2016.
//  Copyright © 2016 none. All rights reserved.
//

import Foundation

class Stormtrooper {
    
    let specialization: String
    //var vehicle : Vehicle?
    weak  var vehicle : Vehicle? //solution
    
    init(specialization: String) {
        self.specialization = specialization
    }
    
    deinit {
        print("Stormtrooper \(specialization) is being deinitialized")
    }
    
}
