//
//  NewEvent.swift
//  Plenry
//
//  Created by NNNO on 8/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Cloudinary

class NewEvent: UIViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,CLUploaderDelegate, UINavigationControllerDelegate, TwoVCDelegate, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet var tableView: UITableView!
    var cloudinaryPublicId = ""
    var startAtDate = NSDate(timeIntervalSince1970: 0)
    var startAtText = ""
    var endAtDate = NSDate(timeIntervalSince1970: 0)
    var endAtText = ""
    var deadlineDate = NSDate(timeIntervalSince1970: 0)
    var deadlineText = "When do you want to stop accepting requests?"
    var uploadedImage = UIImage(named: "upload_pic")
    var interaction = ""
    var note = ""
    var questionForGuest = ""
    var address = ""
    var autoAccept = "true"
    var theme = ""
    var summary = ""
    var pricePerGuest = ""
    var maxParty = ""
    var placeType = "1"
    var mealToEdit = fakeData()
    var mealId = ""
    var startAt = ""
    var endAt = ""
    var deadline = ""
    var endUploading = true
    
    func didFinishTwoVC(controller:NewEventExtend) {
        self.startAtDate = controller.startAtDate
        self.endAtDate = controller.endAtDate
        self.deadlineDate = controller.deadlineDate
        self.summary = controller.summary
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 5, inSection: 0)], withRowAnimation: .None)
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 6, inSection: 0)], withRowAnimation: .None)
        controller.navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if mealToEdit.id != "" {
            mealId = mealToEdit.id
            autoAccept = mealToEdit.autoAccept ? "true" : "false"
            theme = mealToEdit.theme
            summary = mealToEdit.summary
            pricePerGuest = "$ " + String(mealToEdit.price)
            maxParty = String(mealToEdit.maxParty)
            
            startAt = getEventTime(mealToEdit.time_startAt)
            endAt = getEventTime(mealToEdit.time_endAt)
            deadline = getEventTime(mealToEdit.time_deadline)
            
            var temp = mealToEdit.time_startAt
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            temp = temp.substringToIndex(temp.startIndex.advancedBy(16))
            temp = temp.replace("T", withString:" ")
            if let temp2 = dateFormatter.dateFromString(temp) {
                startAtDate = temp2
            }
            let components = NSDateComponents()
//            var deadlineDate = NSDate()
            components.setValue(getTimeZone(), forComponent: NSCalendarUnit.Hour);
            startAtDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
            
            if mealToEdit.time_endAt.characters.count > 15 {
                temp = mealToEdit.time_endAt
                temp = temp.substringToIndex(temp.startIndex.advancedBy(16))
                temp = temp.replace("T", withString:" ")
                if let temp2 = dateFormatter.dateFromString(temp) {
                    endAtDate = temp2
                }
                endAtDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: endAtDate, options: NSCalendarOptions(rawValue: 0))!
            }
            temp = mealToEdit.time_deadline
            temp = temp.substringToIndex(temp.startIndex.advancedBy(16))
            temp = temp.replace("T", withString:" ")
            if let temp2 = dateFormatter.dateFromString(temp) {
                deadlineDate = temp2
            }
            deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: deadlineDate, options: NSCalendarOptions(rawValue: 0))!
            placeType = String(mealToEdit.placeType)
            cloudinaryPublicId = mealToEdit.cloudinary
            interaction = mealToEdit.interaction
            note = mealToEdit.note
            questionForGuest = mealToEdit.question
            address = mealToEdit.address
            self.title = "Edit Event"
        }else{
            self.title = "Create An Event"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventPic", forIndexPath: indexPath) as! NewEventPic
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(NewEvent.imageTapped(_:)))
            cell.pic.addGestureRecognizer(tapGestureRecognizer)
            cell.pic.userInteractionEnabled = true
            if cloudinaryPublicId != "" {
                cell.pic.getDetailImageFromCloudinary(cloudinaryPublicId)
            }else{
                cell.pic.image = uploadedImage
            }
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventItem", forIndexPath: indexPath) as! NewEventItem
            cell.titleLabel.text = "Event Title"
            cell.content.placeholder = "Example: Game Night, Skydiving, ..."
            cell.titleLabel.textColor = ColorGreen
            cell.content.text = theme
            cell.accessoryType = .None
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventItem", forIndexPath: indexPath) as! NewEventItem
            cell.titleLabel.text = "Event Location"
            cell.content.placeholder = "Location of the event"
            cell.titleLabel.textColor = ColorGreen
            cell.content.tag = 1
            cell.content.text = address
            cell.accessoryType = .None
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventItem", forIndexPath: indexPath) as! NewEventItem
            cell.titleLabel.text = "Maximium number of guests"
            cell.content.placeholder = "1"
            cell.titleLabel.textColor = ColorGreen
            cell.content.text = maxParty
            cell.content.keyboardType = UIKeyboardType.NumbersAndPunctuation
            cell.content.tag = 3
            cell.accessoryType = .None
            return cell
        }else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventItem", forIndexPath: indexPath) as! NewEventItem
            cell.titleLabel.text = "Cost per person"
            cell.content.placeholder = "$ 0.00"
            cell.titleLabel.textColor = ColorGreen
            cell.content.text = pricePerGuest
            cell.content.keyboardType = UIKeyboardType.NumbersAndPunctuation
            cell.content.tag = 4
            cell.accessoryType = .None
            return cell
        }else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventItem", forIndexPath: indexPath) as! NewEventItem
            cell.titleLabel.text = "Time of the Event"
            cell.content.placeholder = "Sep 12, 2015, 2:30 AM"
            cell.titleLabel.textColor = ColorGreen
            cell.content.enabled = false
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
            if startAtDate != NSDate(timeIntervalSince1970: 0) && endAtDate != NSDate(timeIntervalSince1970: 0) {
                cell.content.text = dateFormatter.stringFromDate(startAtDate) + " to " + dateFormatter.stringFromDate(endAtDate)
            }else if startAtDate != NSDate(timeIntervalSince1970: 0) {
                cell.content.text = dateFormatter.stringFromDate(startAtDate)
            }else if endAtDate != NSDate(timeIntervalSince1970: 0) {
                cell.content.text = " to " + dateFormatter.stringFromDate(endAtDate)
            }
            return cell
        }else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventItem", forIndexPath: indexPath) as! NewEventItem
            cell.titleLabel.text = "Event Details"
            cell.content.placeholder = "Tell us something about your event"
            cell.titleLabel.textColor = ColorGreen
            cell.content.enabled = false
            cell.content.text = summary
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventAutoAccept", forIndexPath: indexPath) as! NewEventAutoAccept
            cell.label.text = "Auto Accept Guest?"
            cell.label.textColor = ColorGreen
            if autoAccept == "false" {
                cell.switcher.on = false
            }
            return cell
            
        }
    }
    
    @IBAction func postClicked(sender: AnyObject) {
        self.view.endEditing(true)
            if mealToEdit.id != "" {
//Edit event
                var cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow:1,inSection:0)) as! NewEventItem
                theme = cell.content.text!
                cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow:2,inSection:0)) as! NewEventItem
                address = cell.content.text!
                cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow:3,inSection:0)) as! NewEventItem
                maxParty = cell.content.text!
                cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow:4,inSection:0)) as! NewEventItem
                if cell.content.text!.characters.count > 2 {
                    pricePerGuest = cell.content.text!.substringWithRange(cell.content.text!.startIndex.advancedBy(2) ..< cell.content.text!.endIndex)
                }
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                startAt = dateFormatter.stringFromDate(startAtDate) + getTimeZoneForString()
                if endAtDate != NSDate(timeIntervalSince1970: 0) {
                    endAt = dateFormatter.stringFromDate(endAtDate) + getTimeZoneForString()
                }
                deadline = dateFormatter.stringFromDate(deadlineDate) + getTimeZoneForString()
                if cloudinaryPublicId == "" {
                    SweetAlert().showAlert("Opps", subTitle: "Please add a picture for the event", style: AlertStyle.Error)
                    return
                }
                if theme == "" {
                    SweetAlert().showAlert("Opps", subTitle: "Please add a title for your event", style: AlertStyle.Error)
                    return
                }
                if address == "" {
                    SweetAlert().showAlert("Opps", subTitle: "Please enter an address for your event", style: AlertStyle.Error)
                    return
                }
                if Int(maxParty) == nil {
                    SweetAlert().showAlert("Opps", subTitle: "Please enter how many people you want to hang out with", style: AlertStyle.Error)
                    return
                }
                if pricePerGuest == "" {
                    SweetAlert().showAlert("Opps", subTitle: "Please enter how much you want to collect from each guest. For free event, enter 0", style: AlertStyle.Error)
                    return
                }
                if startAtDate == NSDate(timeIntervalSince1970: 0) || deadlineDate == NSDate(timeIntervalSince1970: 0){
                    SweetAlert().showAlert("Opps", subTitle: "Please pick a time for your event", style: AlertStyle.Error)
                    return
                }
                if Int(maxParty) == nil {
                    SweetAlert().showAlert("Opps", subTitle: "Please tell others about your event", style: AlertStyle.Error)
                    return
                }
//                print(startAt)
//                print(endAt)
//                print(autoAccept)
//                print(theme)
//                print(summary)
//                print(pricePerGuest)
//                print(maxParty)
//                print(deadline)
//                print(placeType)
//                print(cloudinaryPublicId)
//                print(address)
//                print(interaction)
//                print(note)
//                print(questionForGuest)
                let result = editEvent(mealToEdit.id, autoAccept: autoAccept, title: theme, summary: summary, pricePerGuest: pricePerGuest, maxParty: maxParty, startAt: startAt, endAt: endAt, deadline: deadline, placeType: placeType, cloudinaryPublicId: cloudinaryPublicId, interaction: interaction, note: note, questionForGuest: questionForGuest, address: address, userId: getUserID())
                print(result)
                if result.replace("\"", withString: "") == "success" {
                    SweetAlert().showAlert("All Set", subTitle: "You've updated the event.", style: AlertStyle.Success)
                    self.navigationController?.popViewControllerAnimated(true)
                }else{
                    SweetAlert().showAlert("Opps", subTitle: result, style: AlertStyle.Error)
                }
            }else{
//Create event
                var cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow:1,inSection:0)) as! NewEventItem
                theme = cell.content.text!
                cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow:2,inSection:0)) as! NewEventItem
                address = cell.content.text!
                cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow:3,inSection:0)) as! NewEventItem
                maxParty = cell.content.text!
                cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow:4,inSection:0)) as! NewEventItem
                pricePerGuest = cell.content.text!
                if cell.content.text!.characters.count > 2 {
                    pricePerGuest = cell.content.text!.substringWithRange(cell.content.text!.startIndex.advancedBy(2) ..< cell.content.text!.endIndex)
                }
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                startAt = dateFormatter.stringFromDate(startAtDate) + getTimeZoneForString()
                if endAtDate != NSDate(timeIntervalSince1970: 0) {
                    endAt = dateFormatter.stringFromDate(endAtDate) + getTimeZoneForString()
                }
                deadline = dateFormatter.stringFromDate(deadlineDate) + getTimeZoneForString()
                
//                print(startAt)
//                print(endAt)
//                print("autoAccept" + autoAccept)
//                print(theme)
//                print(summary)
//                print(pricePerGuest)
//                print(maxParty)
//                print(deadline)
//                print(placeType)
//                print(cloudinaryPublicId)
//                print(address)
//                print(interaction)
//                print(note)
//                print(questionForGuest)
                if cloudinaryPublicId == "" {
                    SweetAlert().showAlert("Opps", subTitle: "Please add a picture for the event", style: AlertStyle.Error)
                    return
                }
                if theme == "" {
                    SweetAlert().showAlert("Opps", subTitle: "Please add a title for your event", style: AlertStyle.Error)
                    return
                }
                if address == "" {
                    SweetAlert().showAlert("Opps", subTitle: "Please enter an address for your event", style: AlertStyle.Error)
                    return
                }
                if Int(maxParty) == nil {
                    SweetAlert().showAlert("Opps", subTitle: "Please enter how many people you want to hang out with", style: AlertStyle.Error)
                    return
                }
                if pricePerGuest == "" {
                    SweetAlert().showAlert("Opps", subTitle: "Please enter how much you want to collect from each guest. For free event, enter 0", style: AlertStyle.Error)
                    return
                }
                if startAtDate == NSDate(timeIntervalSince1970: 0) || deadlineDate == NSDate(timeIntervalSince1970: 0){
                    SweetAlert().showAlert("Opps", subTitle: "Please pick a time for your event", style: AlertStyle.Error)
                    return
                }
                if Int(maxParty) == nil {
                    SweetAlert().showAlert("Opps", subTitle: "Please tell others about your event", style: AlertStyle.Error)
                    return
                }
                let result = createEvent(getUserID(), autoAccept: autoAccept, title: theme, summary: summary, pricePerGuest: pricePerGuest, maxParty: maxParty, startAt: startAt, deadline: deadline, placeType: placeType, cloudinaryPublicId: cloudinaryPublicId, address: address, endAt: endAt, interaction: interaction, note: note, questionForGuest: questionForGuest)
                print(result)
                if result.replace("\"", withString: "") == "success" {
                    SweetAlert().showAlert("Congratulation!", subTitle: "Your event has been posted.", style: AlertStyle.Success)
                    self.navigationController?.popViewControllerAnimated(true)
                }else{
                    SweetAlert().showAlert("Opps", subTitle: result, style: AlertStyle.Error)
                }
            }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return ScreenBounds.width * 180 / 320
        }else{
            return 65
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !endUploading {
            return
        }
        self.view.endEditing(false)
        if indexPath.row == 5 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: NewEventExtend = storyboard.instantiateViewControllerWithIdentifier("NewEventExtend") as! NewEventExtend
            vc.comeFrom = 0
            vc.delegate = self
            vc.startAtDate = startAtDate
            vc.endAtDate = endAtDate
            vc.deadlineDate = deadlineDate
            vc.summary = summary
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 6 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: NewEventExtend = storyboard.instantiateViewControllerWithIdentifier("NewEventExtend") as! NewEventExtend
            vc.comeFrom = 1
            vc.delegate = self
            vc.startAtDate = startAtDate
            vc.endAtDate = endAtDate
            vc.deadlineDate = deadlineDate
            vc.summary = summary
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.tag != 4 && textField.tag != 3 {
            return true
        }
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            if textField.tag == 4 {
                if textField.text == "$ " {
                    textField.text = ""
                }else if !textField.text!.contains("$ ") {
                    textField.text = "$ " + textField.text!
                }
            }
            return true
        default:
            let array = Array(string.characters)
            if textField.text!.contains("$ ") && textField.text!.characters.count == 3 && array.count == 0 && textField.tag == 4{
                textField.text = ""
            }
            if array.count == 0 {
                return true
            }
            return false
        }
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = Double(0.30)
        UIView.beginAnimations("ResizeView", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, -180, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.tag == 1 {
            if checkAddress(textField.text!).replace("\"", withString: "") != "true" {
                SweetAlert().showAlert("Opps", subTitle: "Your address should be more detailed, like \"1155 Tasman Dr 94089 ca sunnyvale\"", style: AlertStyle.Error)
                return false
            }
        }
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = Double(0.30)
        UIView.beginAnimations("ResizeView", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }

    @IBAction func switcherClicked(sender: UISwitch) {
        if sender.on {
            autoAccept = "true"
        }else{
            autoAccept = "false"
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        uploadedImage = image
        uploadImageToCloudinary(image)
        print(image.size.height)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imageTapped(sender: AnyObject) {
        if !endUploading {
            return
        }
        let c=UIImagePickerController()
        c.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        c.delegate=self
        self.presentViewController(c, animated: true, completion: nil)
    }
    func uploadImageToCloudinary(img:UIImage) -> Bool {
        let cloudinary_url = "cloudinary://391732461231266:hcMfSQu5FdwZ822O4gdAwRekQOY@plenry"
        let uploader = CLUploader(CLCloudinary(url: cloudinary_url),delegate:self)
        self.pleaseWait()
//        HUD = MBProgressHUD(view: self.navigationController!.view)
//        self.navigationController!.view.addSubview(HUD!)
//        
//        HUD!.delegate = self
//        HUD!.labelText = "Uploading"
        
        
        self.navigationController?.navigationBar.userInteractionEnabled = false
        self.tabBarController?.tabBar.userInteractionEnabled = false
        endUploading = false
        uploader.upload( UIImageJPEGRepresentation(img, 0.8), options: ["format":"jpg"], withCompletion: { (_: [NSObject : AnyObject]!, errorResult:String!, code:Int, context:AnyObject!) -> Void in
//            print(errorResult)//
//            print(code)
//            print(context)
            }, andProgress: { (p1:Int, p2:Int, p3:Int, p4:AnyObject!) -> Void in
//                print(p1)
//                print(p2)
//                print(p3)
//                print(p4)
        })
        return true
    }
    func uploaderProgress(bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int, context: AnyObject!) {
        //        uploadingProgress.text = "Uploading :" + String(totalBytesWritten/totalBytesExpectedToWrite)
        print("written:"+String(totalBytesWritten)+" to write:"+String(totalBytesExpectedToWrite))
    }
    func uploaderSuccess(result: [NSObject : AnyObject]!, context: AnyObject!) {
        cloudinaryPublicId = (result["public_id"] as? String)!
        let indexPath = NSIndexPath(forRow:0,inSection:0)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        //        uploadingProgress.text = "Uploading Success!"
        self.clearAllNotice()
        self.noticeSuccess("Success!", autoClear: true, autoClearTime: 1)
        self.navigationController?.navigationBar.userInteractionEnabled = true
        self.tabBarController?.tabBar.userInteractionEnabled = true
        endUploading = true
        print(cloudinaryPublicId)
    }
    func uploaderError(result: String!, code: Int, context: AnyObject!) {
        self.navigationController?.navigationBar.userInteractionEnabled = true
        endUploading = true
        SweetAlert().showAlert("Error", subTitle: "Network disconnected", style: AlertStyle.Error)
//                uploadingProgress.text = "Uploading Failed, Check Your Network!"
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.tableView.fixedPullToRefreshViewForDidScroll()
    }
}