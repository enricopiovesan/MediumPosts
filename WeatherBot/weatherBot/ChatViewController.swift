//
//  ChatViewController.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-05-25.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import Toolbar
import SnapKit
import ReverseExtension
import Alamofire
import PromiseKit

class ChatViewController: UIViewController, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    //tool bar
    let containerView = UIView()
    let toolbar: Toolbar = Toolbar()
    var textView: UITextView?
    var item0: ToolbarItem?
    var item1: ToolbarItem?
    var toolbarBottomConstraint: NSLayoutConstraint?
    var constraint: NSLayoutConstraint?
    
    //Messages
    var tableView = UITableView()
    var messages = [Message]()
    
    var isMenuHidden: Bool = false {
        didSet {
            if oldValue == isMenuHidden {
                return
            }
            self.toolbar.layoutIfNeeded()
            UIView.animate(withDuration: 0.3) {
                self.toolbar.layoutIfNeeded()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.right.equalTo(self.view)
            make.left.equalTo(self.view)
            make.top.equalTo(self.view.snp.topMargin)
        }
        //setup background
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.chatBackgroundEnd.cgColor, UIColor.chatBackgroundStart.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        containerView.layer.addSublayer(gradientLayer)
        
        //add tool bar
        containerView.addSubview(toolbar)
        self.toolbarBottomConstraint = self.toolbar.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        self.toolbarBottomConstraint?.isActive = true
        let bottomView = UIView()
        bottomView.backgroundColor = .chatBackgroundEnd
        containerView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(containerView)
            make.left.equalTo(containerView)
            make.top.equalTo(toolbar.snp.bottom)
            make.height.equalTo(100)
        }
        
        //add table view
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(toolbar.snp.top)
            make.right.equalTo(containerView)
            make.left.equalTo(containerView)
            make.top.equalTo(containerView)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add back button
        let backButton = UIButton()
        backButton.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 25
        backButton.setImage(UIImage(named: "icon_close"), for: .normal)
        backButton.addTarget(self, action: #selector(backHome), for: .touchUpInside)
        containerView.addSubview(backButton)
        backButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.centerX.equalTo(containerView)
        }
        
        //setup tool bar
        let textView: UITextView = UITextView(frame: .zero)
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        textView.textColor = .white
        self.textView = textView
        textView.layer.cornerRadius = 10
        item0 = ToolbarItem(customView: textView)
        item1 = ToolbarItem(title: "SEND", target: self, action: #selector(send))
        item1!.tintColor = .mainGreen
        item1!.setEnabled(true, animated: false)
        toolbar.setItems([item0!, item1!], animated: false)
        toolbar.backgroundColor = .black
        
        let toolbarWrapperView = UIView()
        toolbarWrapperView.backgroundColor = .grayBlue
        toolbar.insertSubview(toolbarWrapperView, at: 1)
        toolbarWrapperView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(toolbar)
            make.right.equalTo(toolbar)
            make.left.equalTo(toolbar)
            make.top.equalTo(toolbar)
        }
        
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
        self.view.addGestureRecognizer(gestureRecognizer)
        
        //setup messages table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.re.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.register(UINib(nibName: "TextResponseTableViewCell", bundle: nil), forCellReuseIdentifier: "TextResponseTableViewCell")
        tableView.register(UINib(nibName: "ForecastResponseTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastResponseTableViewCell")
        tableView.estimatedRowHeight = 56
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = .clear
        
        
        tableView.re.scrollViewDidReachTop = { scrollView in
            print("scrollViewDidReachTop")
        }
        tableView.re.scrollViewDidReachBottom = { scrollView in
            print("scrollViewDidReachBottom")
        }
        
        //send welcome message
        sendWelcomeMessage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.toolbar.setNeedsUpdateConstraints()
    }
    
    // MARK: back button
    @objc func backHome() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[messages.count - (indexPath.row + 1)]
        
        switch message.type {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            cell.configure(with: message)
            return cell
        case .botText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextResponseTableViewCell", for: indexPath) as! TextResponseTableViewCell
            cell.configure(with: message)
            return cell
        case .botForecast:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastResponseTableViewCell", for: indexPath) as! ForecastResponseTableViewCell
            cell.configure(with: message)
            return cell
        }
            
    }
    
    // Mark - Tool bar
    
    @objc func hide() {
        self.textView?.resignFirstResponder()
    }
    
    @objc final func keyboardWillShow(notification: Notification) {
        moveToolbar(up: true, notification: notification)
    }
    
    @objc final func keyboardWillHide(notification: Notification) {
        moveToolbar(up: false, notification: notification)
    }
    
    @objc func send() {
        if self.textView!.text != "" {
            
            //configure AI Request
            let aiRequest = AIRequest(query: textView!.text, lang: "en")
            let aiService = AIService(aiRequest)
            
            //Promise block
            firstly{
                aiService.getAi()
            }.then { (ai) -> Promise<Message> in
                ai.intent.createMessage()
            }.then {(message) -> Void in
                self.sendMessage(message)
            }.catch { (error) in
                //oh noes error
            }
            
            //user message
            let message = Message(text: self.textView!.text!, date: Date(), type: .user)
            self.sendMessage(message)
            
            //reset
            self.textView?.text = nil
            if let constraint: NSLayoutConstraint = self.constraint {
                self.textView?.removeConstraint(constraint)
            }
            self.toolbar.setNeedsLayout()
        }
        
    }
    
    // MARK:- send message
    func sendMessage(_ message: Message) {
        messages.append(message)
        tableView.beginUpdates()
        tableView.re.insertRows(at: [IndexPath(row: messages.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.isMenuHidden = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size: CGSize = textView.sizeThatFits(textView.bounds.size)
        if let constraint: NSLayoutConstraint = self.constraint {
            textView.removeConstraint(constraint)
        }
        self.constraint = textView.heightAnchor.constraint(equalToConstant: size.height)
        self.constraint?.priority = UILayoutPriority.defaultHigh
        self.constraint?.isActive = true
    }

    final func moveToolbar(up: Bool, notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        let animationDuration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardHeight = up ? -(userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height : 0
        
        // Animation
        self.toolbarBottomConstraint?.constant = keyboardHeight
        UIView.animate(withDuration: animationDuration, animations: {
            self.toolbar.layoutIfNeeded()
        }, completion: nil)
        self.isMenuHidden = up
    }
    
    // MARK:- welcome message
    
    func sendWelcomeMessage() {
        let firstTime = true
        if firstTime {
            let text = "Oh hello again Jon. I hope you’ve been well. What would you like to hear?"
            let message = Message(text: text, date: Date(), type: .botText)
            messages.append(message)
        }
    }
}

