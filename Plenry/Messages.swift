//
//  Messages.swift
//  Plenry
//
//  Created by NNNO on 8/25/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Messages: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    var inputMessageView: UIView!
    var sendMessageBtn: UIButton!
    var textView: UITextView!
    var friendId = ""
    var friendName = ""
    var inputIsEmpty = true
    var inbox: [Inbox] = []
    var friendPhoto = UIImage()
    var tableView:UITableView!
    var timer = NSTimer()
    var keyBoardShown = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRectMake(0, 64, ScreenBounds.width, ScreenBounds.height - 168), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        inputMessageView = UIView(frame: CGRectMake(0, ScreenBounds.height - 93, ScreenBounds.width, 55))
        sendMessageBtn = UIButton(frame: CGRectMake( ScreenBounds.width - 54, 7, 46, 30))
        sendMessageBtn.addTarget(self, action: #selector(Messages.sendMessage), forControlEvents: UIControlEvents.TouchUpInside)
        sendMessageBtn.titleLabel?.text = "Send"
        sendMessageBtn.titleLabel?.textColor = UIColor.whiteColor()
        sendMessageBtn.setTitleColor(ColorGreen, forState: .Normal)
        sendMessageBtn.setTitle("Send", forState: .Normal)
        self.sendMessageBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        self.inputMessageView.addSubview(sendMessageBtn)
        self.view.addSubview(inputMessageView)
        textView = UITextView(frame: CGRectMake(8, 7, ScreenBounds.width - 75, 36))
        textView.font = UIFont(name: "Helvetica Neue", size: 15)
        self.inputMessageView.addSubview(textView)
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Messages.keyboardChange(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Messages.keyboardChange(_:)), name: UIKeyboardWillHideNotification, object: nil)
        self.title = friendName
        friendPhoto = getFriendPhoto(profile(friendId).photo)
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: -inputMessageView.frame.size.height + width, width:  inputMessageView.frame.size.width, height: inputMessageView.frame.size.height)
        border.borderWidth = width
        inputMessageView.layer.addSublayer(border)
        inputMessageView.layer.masksToBounds = true
        reload()
        if inputIsEmpty {
            textView.textColor = UIColor.lightGrayColor()
            textView.text = "Type a message..."
        }
    }
    override func viewWillAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector:"autoRefresh", userInfo: nil, repeats: true)
    }
    override func viewWillDisappear(animated: Bool) {
        timer.invalidate()
        timer = NSTimer()
    }
    func scrollToBottom() {
        if tableView.numberOfRowsInSection(0) > 0 {
            let indexPath = NSIndexPath(forRow: tableView.numberOfRowsInSection(0)-1, inSection: (0))
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
        }
    }
    func autoRefresh() {
        Alamofire.request(.POST, "https://plenry.com/rest/readBy", parameters: ["userId": getUserID(), "friendId":friendId])
        Alamofire.request(.POST, "https://plenry.com/rest/inbox", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    let newInbox = getInbox(temp)
                    var testInbox:[Inbox] = []
                    for i in newInbox {
                        if i.toUserId == self.friendId || i.userId == self.friendId {
                            testInbox.append(i)
                        }
                    }
                    if testInbox.count != self.inbox.count {
                        self.inbox = testInbox
                        self.inbox.sortInPlace() { $0.createdAt < $1.createdAt}
                        self.tableView.reloadData()
                        self.scrollToBottom()
                    }
            }
        }
    }
    func reload(){
        Alamofire.request(.POST, "https://plenry.com/rest/readBy", parameters: ["userId": getUserID(), "friendId":friendId])
        Alamofire.request(.POST, "https://plenry.com/rest/inbox", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.inbox = getInbox(temp)
                    var testInbox:[Inbox] = []
                    for i in self.inbox {
                        if i.toUserId == self.friendId {
                            testInbox.append(i)
                        }
                        if i.userId == self.friendId {
                            testInbox.append(i)
                        }
                    }
                    self.inbox = testInbox
                    self.inbox.sortInPlace() { $0.createdAt < $1.createdAt}
                    self.tableView.reloadData()
                    self.scrollToBottom()
//                    self.clearAllNotice()
                }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func popAvatar(sender: UIButton){
        self.tabBarController!.view.alpha = 0.5
        let popImage = UIView()
        popImage.frame = CGRectMake(0, 0, ScreenBounds.width, ScreenBounds.height)
        popImage.backgroundColor = UIColor.clearColor()
        let avatar = UIButton(frame: CGRectMake(0, (ScreenBounds.height - ScreenBounds.width) / 2, ScreenBounds.width, ScreenBounds.width))
        avatar.setBackgroundImage(friendPhoto, forState: .Normal)
        avatar.userInteractionEnabled = false
        popImage.addSubview(avatar)
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        popImage.frame = window.bounds
        window.addSubview(popImage)
        window.bringSubviewToFront(popImage)
        let tap = UITapGestureRecognizer(target: self, action: #selector(Messages.handleTap(_:)))
        tap.delegate = self
        popImage.addGestureRecognizer(tap)
        
    }
    func handleTap(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        self.tabBarController!.view.alpha = 1.0
    }


    func sendMessage() {
        if keyBoardShown {
            var flag = false
            for i in self.textView.text.characters {
                if i != "\n" && i != " " {
                    flag = true
                }
            }
            if !flag {
                self.textView.text = ""
                return
            }
            if textView.text.characters.count < 1 {
                return
            }
            let result = sendMessages(getUserID(), content: textView.text, toUserId: friendId)
            if result.replace("\"", withString: "") == "message sent" {
                textView.text = ""
                reload()
            }else{
                self.view.endEditing(true)
                SweetAlert().showAlert("Opps", subTitle: "Sorry, we couldn't process your request.", style: AlertStyle.Error)
            }
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ChatMessage(style: UITableViewCellStyle.Default, reuseIdentifier: "ChatMessage")
        cell.avatarBtnView.setBackgroundImage(friendPhoto, forState: .Normal)
        cell.avatarBtnView.addTarget(self, action: Selector("popAvatar:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.setMessageFrame(inbox[indexPath.row])
        cell.frame.size.height = cell.cellHeight!
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAtIndexPath: indexPath).frame.size.height
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inbox.count
    }
    func keyboardChange(notification: NSNotification){
        let userInfo = notification.userInfo! as NSDictionary
        let animationDuration = userInfo.valueForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSTimeInterval
        let keyboardEndFrame = (userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue).CGRectValue()
        let rectH = keyboardEndFrame.size.height
//        print(rectH)
        UIView.animateWithDuration(animationDuration, delay: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            if notification.name == UIKeyboardWillShowNotification{
                self.tableView.frame.size.height = ScreenBounds.height - 157 - rectH + 49
                self.inputMessageView.frame.origin.y = ScreenBounds.height - 93 - rectH + 49
                if self.inputIsEmpty {
                    self.textView.textColor = UIColor.blackColor()
                    self.textView.text = ""
                    self.inputIsEmpty = !self.inputIsEmpty
                }
                self.keyBoardShown = true
            }else{
                self.tableView.frame.size.height = ScreenBounds.height - 157
                self.inputMessageView.frame.origin.y = ScreenBounds.height - 93
                if self.textView.text == "" {
                    self.inputIsEmpty = true
                    self.textView.text = "Type a message..."
                    self.textView.textColor = UIColor.lightGrayColor()
                }
                self.keyBoardShown = false
            }
            }, completion: nil)
        if notification.name == UIKeyboardWillShowNotification{
            self.scrollToBottom()
        }
    }
}
