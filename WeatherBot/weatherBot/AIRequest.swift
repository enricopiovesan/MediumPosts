//
//  AIRequest.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-04.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire

class AIRequest {
    
    var query: String
    var lang: String
    var sessionId: String
    
    init(query: String, lang: String) {
        self.query = query
        self.lang = lang
        self.sessionId = "WB-" + Date().ticks.description
    }
    
    func getHeaders() -> HTTPHeaders {
        let clientAccessToken = "YOUR_KEY_HERE"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + clientAccessToken,
            ]
        return headers
    }
    
    func toParameters() -> Parameters {
        
        let parameters: Parameters = [
            "query": query,
            "lang": lang,
            "sessionId": sessionId
        ]
        
        return parameters
    }
    
}
