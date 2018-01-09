//
//  AIService.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-04.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class AIService {
    
    let aiUrl = URLGenerator.aiApiUrlForPathString(path: "query?v=20150910")
    var aiRequest: AIRequest
    
    init(_ aiRequest: AIRequest) {
        self.aiRequest = aiRequest
    }
    
    func getAi() -> Promise<AI> {
        
        let parameters = aiRequest.toParameters()
        let headers = aiRequest.getHeaders()
        
        return Promise { fulfill, reject in
            
            Alamofire.request(aiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        var ai: AI? = nil
                        if let aiManagerDictionary = json as? NSDictionary {
                            let aiManager = AIManager(aiDictionary: aiManagerDictionary)
                            ai = aiManager.serialize()
                        }
                        
                        if ai != nil {
                            fulfill(ai!)
                        } else {
                            reject(WeatherBotError.aiManagerDictionary)
                        }
                        
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
        
    }
    
}
