//
//  ButtonsViews.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-06.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit
import SnapKit

class ButtonsViews: UIView {
    
    typealias ActionHandler = (_ text: String) -> Void
    
    let offset = CGFloat(15)
    let buttonsOffset = CGFloat(15)
    let borderSize = CGFloat(1)
    let buttonHeight = CGFloat(40)
    let buttonsCornerRadius = CGFloat(10)
    var scrollView: UIScrollView!
    var actionAndler: ActionHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //init scrollView
        scrollView = UIScrollView(frame: CGRect.zero)
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(offset)
            make.bottom.equalTo(self).inset(offset)
            make.right.equalTo(self)
            make.left.equalTo(self)
        }
        
        //setup scroll view content
        let buttonYPosition = CGFloat(0)
        var buttonXPosition = offset
        for button in getButtons() {
            button.frame.origin.y = buttonYPosition
            button.frame.origin.x = buttonXPosition
            scrollView.addSubview(button)
            buttonXPosition = buttonXPosition + button.frame.width + buttonsOffset + (borderSize * 2)
        }
        scrollView.contentSize = CGSize(width: buttonXPosition, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: Get an array of buttons value
    func getButtonsValue() -> [String] {
        let hello = "Hello!"
        let forecat = "Forecast weekend"
        let sanFrancisco = "San Francisco weather"
        let whoAreYou = "Who are you?"
        let thankYou = "Thank you!"
        let umbrella = "Will I need an umbrella?"
        let lifeSense = "What is the sense of the life?"
        let isGoingTo = "Is going to rain tomorrow in New York?"
        return  [hello, forecat, sanFrancisco, umbrella, isGoingTo, whoAreYou, thankYou, lifeSense]
    }
    
    // MARK: Create the buttons array
    func getButtons() -> [UIButton] {
        return getButtonsValue().map { label in
            let button = UIButton()
            button.setTitle(label, for: .normal)
            button.setTitleColor(.grey400, for: .normal)
            button.setTitleColor(.grey500, for: .highlighted)
            button.layer.borderWidth = borderSize
            button.layer.borderColor = UIColor.grey500.cgColor
            button.layer.cornerRadius = buttonsCornerRadius
            button.sizeToFit()
            button.frame.size.width = button.frame.width + (offset * 2)
            button.frame.size.height = buttonHeight
            button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
            return button
        }
    }
    
    //MARK: default button action
    @objc func buttonAction(_ sender: UIButton) {
        if actionAndler != nil {
            actionAndler!(sender.titleLabel?.text ?? "unkon label")
        } else {
            print("Error: actionAndler is not defined")
        }
    }
    
    // MARK: Add button action
    func addAction(_ actionAndler: @escaping ActionHandler) {
        self.actionAndler = actionAndler
    }
    
}
