//
//  ViewController.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-04.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var buttonsView: ButtonsViews!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var itentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var speechLabel: UILabel!
    @IBOutlet weak var outfitLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitalState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : Create a new A.I. request by text
    func newRequest(_ text: String) {
        
        //configure AI Request
        let aiRequest = AIRequest(query: text, lang: "en")
        let aiService = AIService(aiRequest)
        
        //Promise block
        firstly{
            removePreviusSearch(text)
            }.then {(finished) -> Promise<AI> in
                aiService.getAi()
            }.then {(ai) -> Void in
                self.updateResults(ai)
            }.catch { (error) in
                //catch error
        }

    }
    
    // MARK : Remove previus search
    func removePreviusSearch(_ newText: String) -> Promise<Bool> {
        return Promise { fulfill, reject in
            UIView.animate(withDuration: 0.5, animations:{
                self.topLabel.alpha = 0
                self.mainText.alpha = 0
                self.resultsView.alpha = 0
                self.textField.text = ""
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.5) {
                    self.topLabel.alpha = 1
                    self.mainText.alpha = 1
                }
                fulfill(finished)
                self.topLabel.text = "user says".uppercased()
                self.mainText.text = newText
                self.setLabel(self.cityLabel)
                self.setLabel(self.streetLabel)
                self.setLabel(self.countryLabel)
                self.setLabel(self.dateLabel)
                self.setLabel(self.speechLabel)
                self.setLabel(self.itentLabel)
                self.setLabel(self.conditionLabel)
                self.setLabel(self.outfitLabel)
                self.setLabel(self.scoreLabel)
            })
        }
    }
    
    // MARK : Set label disable / enable
    func setLabel(_ label: UILabel, value: String? = nil) {
        if value != nil && value != "" {
            label.text = value
            label.alpha = 1
        } else {
            label.text = "none"
            label.alpha = 0.2
        }
    }
    
    // MARK : Try button action
    @IBAction func tryButtonAction(_ sender: UIButton) {
        if textField.text! != "" {
            newRequest(textField.text!)
        }
    }
    
    // MARK : Detect textfield changes
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text != "" {
            tryButton.isEnabled = true
        } else {
            tryButton.isEnabled = false
        }
    }
    
    // MARK : update results with the AI data
    func updateResults(_ ai: AI) {
        DispatchQueue.main.async {
            
            self.setLabel(self.itentLabel, value: ai.intent.intentName)
            self.setLabel(self.scoreLabel, value: ai.score.roundTo(places: 2).description)
            self.setLabel(self.speechLabel, value: ai.intent.speech)
            
            if ai.intent.dates != nil  && ai.intent.dates!.count > 0 {
                var dateString = ""
                for (index, date) in ai.intent.dates!.enumerated() {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateString = dateString + dateFormatter.string(from: date)
                    dateString = index != ai.intent.dates!.count - 1 ? dateString + ", " : dateString
                }
                self.setLabel(self.dateLabel, value: dateString)
            }
            
            if ai.intent.address != nil {
                self.setLabel(self.cityLabel, value: ai.intent.address!.city)
                self.setLabel(self.countryLabel, value: ai.intent.address!.country)
                self.setLabel(self.streetLabel, value: ai.intent.address!.street)
            }
            if ai.intent.weather != nil {
                self.setLabel(self.conditionLabel, value: ai.intent.weather!.condition)
                self.setLabel(self.outfitLabel, value: ai.intent.weather!.outfit)
            }
            UIView.animate(withDuration: 0.5) {
                self.resultsView.alpha = 1
            }
        }
    }
    
    // MARK : Setup initial state of view
    func setInitalState() {
        //hide items
        headerView.alpha = 0
        headerView.alpha = 0
        mainView.alpha = 0
        resultsView.alpha = 0
        
        //setup search bar
        textField.layer.borderColor = UIColor.grey500.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        //setup text
        topLabel.text = "A.I. Tester".uppercased()
        mainText.text = "Hey there,\nare you ready to test it?\n\nType a question or pick one from the list above."
        
        //disable try now button
        tryButton.isEnabled = false
        
        //setup buttonsView
        buttonsView.addAction { text in
            self.newRequest(text)
        }
        
        //show with animation
        UIView.animate(withDuration: 0.5, animations:{
            self.headerView.alpha = 1
            
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.5) {
                self.mainView.alpha = 1
            }
        })
    }
    
}

