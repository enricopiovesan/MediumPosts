//
//  AI.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-04.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit

class AI {
    
    var id: String
    var lang: String
    var score: Double
    var intent: Intent
    
    required init(id: String, lang: String, score: Double) {
        self.id = id
        self.lang = lang
        self.score = score
        self.intent = Intent(intentName: "")
    }
    
}
