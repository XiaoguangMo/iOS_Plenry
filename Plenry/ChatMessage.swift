//
//  ChatCell.swift
//  Plenry
//
//  Created by NNNO on 8/25/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ChatMessage: UITableViewCell {
    var timeLabel: UILabel!
    var avatarBtnView: UIButton!
    var messageLabel: UILabel!
    var message: Inbox!
    var showDateLabel = false
    var messageIsFromUser = false
    var cellHeight: CGFloat?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.timeLabel = UILabel()
        self.avatarBtnView = UIButton()
        self.messageLabel = UILabel()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setMessageFrame(message: Inbox) {
        self.message = message
        if self.message.userId == getUserID() {
            self.messageIsFromUser = true
        }
        //处理时间
        if !self.showDateLabel{
            self.timeLabel.hidden = true
        }else{
            self.timeLabel.textAlignment = NSTextAlignment.Center
            self.timeLabel.textColor = UIColor.blackColor()
//            self.timeLabel.font = ChatTimeFont
            self.timeLabel.text = getEventTime(self.message.createdAt)
            self.timeLabel.sizeToFit()
            self.timeLabel.center = CGPoint(x: ScreenBounds.width/2, y: self.timeLabel.frame.height/2 + 10)
            self.contentView.addSubview(timeLabel)
        }
        //处理头像
        if self.messageIsFromUser {
            self.avatarBtnView.hidden = true
        }else{
            self.avatarBtnView.layer.cornerRadius = 15
            self.avatarBtnView.layer.masksToBounds = true
            self.avatarBtnView.layer.borderWidth = 1.0
            self.avatarBtnView.layer.borderColor = ColorLightGrey.CGColor
            if showDateLabel {
                self.avatarBtnView.frame = CGRectMake(8, self.timeLabel.frame.height + 10, 30, 30)
            }else{
                self.avatarBtnView.frame = CGRectMake(8, 4, 30, 30)
            }
            self.contentView.addSubview(avatarBtnView)
        }
        //处理内容
        let backgroundBox = UIImageView()
        backgroundBox.backgroundColor = ColorGreen
        self.contentView.addSubview(backgroundBox)
        self.messageLabel.frame = CGRectMake(6, 6, ScreenBounds.width - 120, 20)
        self.messageLabel.textColor = UIColor.blackColor()
        self.messageLabel.font = UIFont.systemFontOfSize(15)
        self.messageLabel.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: self.message.content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, (self.message.content as NSString).length))
        self.messageLabel.attributedText = attributedString
        self.messageLabel.sizeToFit()
        backgroundBox.addSubview(self.messageLabel)
        self.bounds.size.width = self.messageLabel.bounds.size.width + 10
        self.bounds.size.height = self.messageLabel.bounds.size.height + 10
//        println(self.messageLabel.bounds.size.height)
        if self.messageLabel.bounds.size.height < 30 && self.messageLabel.bounds.size.height > 20{
            self.bounds.size.height -= 5
        }
        if messageIsFromUser {
            backgroundBox.frame = CGRectMake(ScreenBounds.width - 23 - messageLabel.frame.width, 4, messageLabel.frame.width + 14, messageLabel.frame.height + 14)
            backgroundBox.layer.cornerRadius = 7
            backgroundBox.layer.masksToBounds = true
            backgroundBox.backgroundColor = ColorGreen
            self.messageLabel.textColor = UIColor.whiteColor()
        }else{
            backgroundBox.frame = CGRectMake(46, 4, messageLabel.frame.width + 14, messageLabel.frame.height + 14)
            backgroundBox.backgroundColor = UIColor(white: 0.93, alpha: 1)
            backgroundBox.layer.cornerRadius = 7
            backgroundBox.layer.masksToBounds = true
            self.messageLabel.textColor = UIColor.blackColor()
        }
        self.cellHeight = backgroundBox.frame.height + 8
    }
    //    func minuteOffSetStart(start: NSDate?, end: NSDate){
    //        if start == nil{
    //        self.showDateLabel = true
    //        return
    //        }
    //
    //        var timeInterval = end.timeIntervalSinceDate(start!)
    //        //相距3分钟显示时间Label
    ////        println(timeInterval)
    //        if fabs(timeInterval) > 3*60{
    //            self.showDateLabel = true
    //        }else{
    //            self.showDateLabel = false
    //        }
    //    }
}
