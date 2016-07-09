//
//  MeDetail.swift
//  Plenry
//
//  Created by NNNO on 6/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import GoogleMaps
//import CoreLocation

class MeDetail: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, WriteDes {
    
    @IBOutlet var tableView: UITableView!
    var genderVisible = false
    var pickerVisible = false
    var reviewIsFromMe = true
    var reviewsToMe:[Review] = []
    var reviewsFromMe:[Review] = []
    var userData = emptyUser()
    var birthDay = "Unknown"
    var gender = "Other"
    var des = ""
    //comeFromWhichPage: 0:Edit personal info, 1:Trust and Verification, 2:Review
    var comeFromWhichPage:Int = 0

    func didFinishTwoVC(controller:WriteAboutMe) {
        self.des = controller.des
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 9, inSection: 0)], withRowAnimation: .None)
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MeDetail.keyboardChange(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MeDetail.keyboardChange(_:)), name: UIKeyboardWillHideNotification, object: nil)
        loadData()
        userData = profile(getUserID())
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorColor = ColorSuperLightGrey
        gender = userData.gender
        birthDay = getDateOnly(userData.birthday)
        des = userData.description
        tableView.backgroundColor = ColorSuperLightGrey
        if comeFromWhichPage == 0 {
            self.title = "Edit Personal Info"
            let editBtn = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MeDetail.editAction(_:)))
            self.navigationItem.setRightBarButtonItem(editBtn, animated: false)
        }else if comeFromWhichPage == 1 {
            self.title = "Trust and Verification"
        }else{
            self.title = "Review"
        }
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    func loadData(){
        reviewsToMe = []
        reviewsFromMe = []
        Alamofire.request(.POST, "https://plenry.com/rest/reviews/guestToMe", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.reviewsToMe += guestToMe(temp)
                    self.tableView.reloadData()
                    self.clearAllNotice()
                }
        }
        Alamofire.request(.POST, "https://plenry.com/rest/reviews/HostToMe", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.reviewsToMe += HostToMe(temp)
                    self.tableView.reloadData()
                    self.clearAllNotice()
                }
        }
        Alamofire.request(.POST, "https://plenry.com/rest/reviews/meToGuest", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.reviewsFromMe += meToGuest(temp)
                    self.tableView.reloadData()
                    self.clearAllNotice()
                }
        }
        Alamofire.request(.POST, "https://plenry.com/rest/reviews/meToHost", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.reviewsFromMe += meToHost(temp)
                    self.tableView.reloadData()
                    self.clearAllNotice()
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    func keyboardChange(notification: NSNotification){
        if notification.name == UIKeyboardWillShowNotification {
            let userInfo = notification.userInfo! as NSDictionary
            let keyboardEndFrame = (userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue).CGRectValue()
            let rectH = keyboardEndFrame.size.height
            let animationDuration:NSTimeInterval = Double(0.30)
            UIView.beginAnimations("ResizeView", context: nil)
            UIView.setAnimationDuration(animationDuration)
            self.view.frame = CGRectMake(0, -rectH + 49, self.view.frame.size.width, self.view.frame.size.height)
            UIView.commitAnimations()
        }else{
            let animationDuration:NSTimeInterval = Double(0.30)
            UIView.beginAnimations("ResizeView", context: nil)
            UIView.setAnimationDuration(animationDuration)
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
            UIView.commitAnimations()
        }
    }
    func editAction(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        var gender = ""
        var indexPath1 = NSIndexPath(forRow:3,inSection:0)
        let cell = tableView.cellForRowAtIndexPath(indexPath1) as! labelLabel
        if let temp = cell.secondLabel.text {
            gender = temp
        }
        var birthday = ""
        indexPath1 = NSIndexPath(forRow:7,inSection:0)
        if let temp = tableView.cellForRowAtIndexPath(indexPath1) as? labelLabel {
            birthday = temp.secondLabel.text!
        }
        var school = ""
        indexPath1 = NSIndexPath(forRow:0,inSection:1)
        if let temp = tableView.cellForRowAtIndexPath(indexPath1) as? labelText {
            school = temp.textField.text!
        }
        
        var work = ""
        indexPath1 = NSIndexPath(forRow:1,inSection:1)
        if let temp = tableView.cellForRowAtIndexPath(indexPath1) as? labelText {
            work = temp.textField.text!
        }
        
        var language = ""
        indexPath1 = NSIndexPath(forRow:2,inSection:1)
        if let temp = tableView.cellForRowAtIndexPath(indexPath1) as? labelText {
            language = temp.textField.text!
        }
        
        if gender == "Male" {
            gender = "0"
        }else if gender == "Female" {
            gender = "1"
        }else{
            gender = "3"
        }
        var finalBirthday = ""
        if birthday != "" {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            var myBirthday = NSDate()
            if let temp2 = dateFormatter.dateFromString(birthday) {
                myBirthday = temp2
            }
            let dateFormatter1 = NSDateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
            finalBirthday = dateFormatter1.stringFromDate(myBirthday) + getTimeZoneForString()
        }
        self.view.endEditing(true)
        let result = editProfile(getUserID(), gender: gender, birthday: finalBirthday, description: des, school: school, work: work, language: language)
        if result.replace("\"", withString: "") == "true" {
            SweetAlert().showAlert("All Set", subTitle: "Your profile has been saved.", style: AlertStyle.Success)
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            SweetAlert().showAlert("Opps", subTitle: "Sorry, we couldn't process your request.", style: AlertStyle.Error)
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 8 {
            return 162
        }else if indexPath.row == 9 {
            return 90
        }else{
            return 49
        }
    }
    @IBAction func birthdayChanged(sender: UIDatePicker) {

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = .MediumStyle
        birthDay = dateFormatter.stringFromDate(sender.date)
        let indexPath1 = NSIndexPath(forRow:7,inSection:0)
        tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 31
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if comeFromWhichPage == 0 && indexPath.section == 0 {
            if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6) && !genderVisible {
                return 0
            }
            if indexPath.row == 8 {
                if pickerVisible {
                    return 132
                } else {
                    return 0
                }
            }
            if indexPath.row == 9 {
                return 65
            }
        }
        if comeFromWhichPage == 1 && indexPath.row == 0 {
            return 120
        }
        return 49
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "writeAboutMe" {
            let svc = segue.destinationViewController as! WriteAboutMe
            svc.des = self.des
            svc.delegate = self
        }
    }
    func changeGenderVisible() {
        genderVisible = !genderVisible
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow:4,inSection:0)], withRowAnimation: UITableViewRowAnimation.Fade)
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow:5,inSection:0)], withRowAnimation: UITableViewRowAnimation.Fade)
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow:6,inSection:0)], withRowAnimation: UITableViewRowAnimation.Fade)
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow:3,inSection:0)], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        if comeFromWhichPage == 0 && indexPath.section == 0 {
            if indexPath.row == 3 {
                changeGenderVisible()
            }
            else if indexPath.row == 7 {
                pickerVisible = !pickerVisible
                let indexPath1 = NSIndexPath(forRow:8,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            else if indexPath.row == 4 {
                gender = "Male"
                changeGenderVisible()
            }
            else if indexPath.row == 5 {
                gender = "Female"
                changeGenderVisible()
            }
            else if indexPath.row == 6 {
                gender = "Other"
                changeGenderVisible()
            }
        }
        if comeFromWhichPage == 1 && indexPath.row == 1{
            if userData.verifyPhone != 1 {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: PhoneVerify = storyboard.instantiateViewControllerWithIdentifier("PhoneVerify") as! PhoneVerify
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(comeFromWhichPage){
        case 0:
            switch(indexPath.section){
            case 0:
                switch(indexPath.row){
                case 0:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                    cell.label.text = "Email"
                    cell.label.textColor = ColorGrey
                    cell.textField.text = userData.email
                    cell.textField.userInteractionEnabled = false
                    cell.textField.textColor = ColorGrey
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                    cell.label.text = "First Name"
                    cell.label.textColor = ColorGrey
                    cell.textField.text = userData.firstName
                    cell.textField.userInteractionEnabled = false
                    cell.textField.textColor = ColorGrey
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                    cell.label.text = "Last Name"
                    cell.label.textColor = ColorGrey
                    cell.textField.text = userData.lastName
                    cell.textField.userInteractionEnabled = false
                    cell.textField.textColor = ColorGrey
                    return cell
                case 3:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelLabel", forIndexPath: indexPath) as! labelLabel
                    cell.secondLabel.text = gender
                    cell.firstLabel.text = "Gender"
                    cell.firstLabel.textColor = ColorGrey
                    return cell
                case 4:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelLabel", forIndexPath: indexPath) as! labelLabel
                    cell.firstLabel.text = ""
                    cell.secondLabel.text = "Male"
                    if !genderVisible {
                        cell.hidden = true
                    }
                    return cell
                case 5:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelLabel", forIndexPath: indexPath) as! labelLabel
                    cell.firstLabel.text = ""
                    cell.secondLabel.text = "Female"
                    if !genderVisible {
                        cell.hidden = true
                    }
                    return cell
                case 6:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelLabel", forIndexPath: indexPath) as! labelLabel
                    cell.firstLabel.text = ""
                    cell.secondLabel.text = "Other"
                    if !genderVisible {
                        cell.hidden = true
                    }
                    return cell
                case 7:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelLabel", forIndexPath: indexPath) as! labelLabel
                    cell.firstLabel.text = "Birthday"
                    cell.firstLabel.textColor = ColorGrey
                    cell.secondLabel.text = birthDay
                    return cell
                case 8:
                    let cell = tableView.dequeueReusableCellWithIdentifier("datePicker", forIndexPath: indexPath) as! datePicker
                    if !pickerVisible {
                        cell.hidden = true
                    }
                    return cell
                case 9:
                    let cell = tableView.dequeueReusableCellWithIdentifier("MeAboutMe", forIndexPath: indexPath) as! MeAboutMe
                    cell.label.text = "About Me"
                    cell.label.textColor = ColorGrey
                    cell.content.text = des
                    return cell
                default:
                    let defaultCell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                    return defaultCell
                }
            case 1:
                switch(indexPath.row){
                case 0:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                    cell.label.text = "School"
                    cell.label.textColor = ColorGrey
                    cell.textField.text = userData.school
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                    cell.label.text = "Job"
                    cell.label.textColor = ColorGrey
                    cell.textField.text = userData.work
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                    cell.label.text = "Language"
                    cell.label.textColor = ColorGrey
                    cell.textField.text = userData.language
                    return cell
                default:
                    let defaultCell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                    return defaultCell
            }
        
            default:
                let defaultCell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                return defaultCell
            }
        case 1:
            switch(indexPath.row){
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("VerifyInfo", forIndexPath: indexPath) as! VerifyInfo
                cell.backgroundColor = ColorSuperLightGrey
                cell.label1.text = "CURRENT VERIFICATIONS"
                cell.label1.textColor = ColorGrey
                if userData.verifyPhone != 1{
                    cell.label2.text = "You don't have any verification yet. The more verification you have, the bigger chance you will be accepted by the host."
                }else{
                    cell.label2.text = "You can add more verifications from your Profile on www.plenry.com"
                }
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("labelLabel", forIndexPath: indexPath) as! labelLabel
                cell.firstLabel.text = "Phone"
                if userData.verifyPhone != 1{
                    cell.secondLabel.text = "Phone not verified"
                    cell.secondLabel.textColor = ColorGrey
                }else{
                    cell.secondLabel.text = "Phone verified"
                    cell.secondLabel.textColor = ColorGreen
                }
                return cell
//            case 1:
//                let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
//                cell.label.text = "ID"
//                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                cell.label.text = "Facebook"
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                cell.label.text = "Email"
                return cell
            case 4:
                let cell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                cell.label.text = ""
                return cell
            default:
                let defaultCell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
                return defaultCell
                
            }
        case 2:
            switch(indexPath.row){
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("ReviewTitle", forIndexPath: indexPath) as! ReviewTitle

                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("ReviewBtn", forIndexPath: indexPath) as! ReviewBtn
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("ReviewDetail", forIndexPath: indexPath) as! ReviewDetail
                if reviewIsFromMe {
                    cell.pic.getAvatarFromCloudinary(reviewsFromMe[indexPath.row - 2].hostPic)
                    cell.name.text = reviewsFromMe[indexPath.row - 2].hostFirstName
                    cell.content.text = reviewsFromMe[indexPath.row - 2].content
                    cell.date.text = reviewsFromMe[indexPath.row - 2].createdAt
                    return cell
                }else{
                    cell.pic.getAvatarFromCloudinary(reviewsToMe[indexPath.row - 2].hostPic)
                    cell.name.text = reviewsToMe[indexPath.row - 2].hostFirstName
                    cell.content.text = reviewsToMe[indexPath.row - 2].content
                    cell.date.text = "Member since " + reviewsToMe[indexPath.row - 2].createdAt.substringToIndex(reviewsToMe[indexPath.row - 2].createdAt.startIndex.advancedBy(10))
                    return cell
                }
            }
        default:
            let defaultCell = tableView.dequeueReusableCellWithIdentifier("labelText", forIndexPath: indexPath) as! labelText
            return defaultCell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(comeFromWhichPage){
        case 0:
            switch(section){
            case 0: return 10
            case 1: return 3
            default: return 0
            }
        case 1:return 2
        case 2:
            if reviewIsFromMe {
                return 2 + reviewsFromMe.count
            }else{
                return 2 + reviewsToMe.count
            }
        default:return 0
            
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch(comeFromWhichPage){
        case 0:return 2
        default:return 1
        }
    }
}
