//
//  ChatVC.swift
//  Smack
//
//  Created by Andras on 24/10/17.
//  Copyright © 2017 Andras. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxtBox: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        //if tap screen outside of the textfield, the keyboard disappears
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
       
       
        }
    @objc func userDataDidChange (_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            //Get channels
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please log in"
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func onLoginGetMessages () {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet"
                }
            }
        }
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? "" //if nil, then set it as ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    @IBAction func sendMsgPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTxtBox.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                self.messageTxtBox.text = ""
                self.messageTxtBox.resignFirstResponder()
            })
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            
        }
    }
    }



