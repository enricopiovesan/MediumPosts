//
//  AIManager.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-04.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire

class AIManager {
    
    var ai: AI? = nil
    var aiDictionary: NSDictionary
    
    required init(aiDictionary: NSDictionary) {
        self.aiDictionary = aiDictionary
    }
    
    // MARK:- AI serialize
    func serialize() -> AI? {
        
        var id: String? = nil
        var lang: String? = nil
        var score: Double = 0
        
        //ID
        if let value = aiDictionary["id"] as? String {
            id = value
        }
        
        //Language
        if let value = aiDictionary["lang"] as? String {
            lang = value
        }
        
        if id == nil && lang == nil {
            //id or lang is nil for ai Dictionary
            print("id or created is nil for AI Dictionary")
            return nil
        } else {
            
            //result
            if let result = aiDictionary["result"] as? [String:AnyObject] {
                
                //Score
                if let value = result["score"] as? Double {
                    score = value
                }
                
                ai = AI(id: id!, lang: lang!, score: score)
                
                //action
                if let value = result["action"] as? String {
                    
                    ai!.intent = Intent(intentName: value)
                    
                    //fulfillment
                    if let fulfillment = result["fulfillment"] as? NSDictionary {
                        if let speech = fulfillment["speech"] as? String {
                            ai!.intent.speech = speech
                        }
                    }
                    
                    //contexts
                    if let contextsArr = result["contexts"] as? [[String : Any]] {
                        if let contexts = contextsArr.first as NSDictionary? {
                            //parameters
                            if let parameters = contexts["parameters"] as? NSDictionary, !result.isEmpty {
                                ai!.intent.setParametes(parameters)
                            }
                        }
                    }
                    
                }
                
            }
            
            return ai
            
        }
        
    }
    
}
