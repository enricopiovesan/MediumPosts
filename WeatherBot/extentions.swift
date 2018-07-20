//
//  extentions.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-07-20.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

extension String {
    var floatValue: CGFloat {
        return CGFloat((self as NSString).floatValue)
    }
}
