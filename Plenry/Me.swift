//
//  Me.swift
//  Plenry
//
//  Created by NNNO on 6/23/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Cloudinary
import MessageUI
import Alamofire

class Me: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLUploaderDelegate, MFMailComposeViewControllerDelegate {
    @IBOutlet var MeTable: UITableView!
    let c=UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(3) as! UITabBarItem
        tabItem.badgeValue = String(UIApplication.sharedApplication().applicationIconBadgeNumber)
        if tabItem.badgeValue == "0" {
            tabItem.badgeValue = nil
        }
        c.delegate=self
        tabBarItem.selectedImage = UIImage(named: "face_slct.png")!.imageWithRenderingMode(.AlwaysOriginal)
        MeTable.backgroundColor = ColorSuperLightGrey
        MeTable.separatorColor = ColorSuperLightGrey
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        MeTable.delegate = self
        MeTable.dataSource = self
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {return nil}
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 31))
        footerView.backgroundColor = ColorSuperLightGrey
        return footerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 162
        } else {
            return 49
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 0}
        return 20
    }
    
    var whichCell:Int = 0
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                whichCell = 0
            }else if indexPath.row  == 2 {
                whichCell = 1
            }else if indexPath.row == 3 {
                whichCell = 2
            }
        }
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let svc = segue.destinationViewController as! MeDetail
            svc.comeFromWhichPage = whichCell
        }
        if segue.identifier == "Logout" {
            Alamofire.request(.POST, "https://plenry.com/rest/deliOSToken", parameters: ["userId": getUserID(), "deviceToken": myDeviceToken])
                .responseJSON { _,_,result in
                    if result.isFailure {
                        print("fail")
                        return
                    }
                    if let temp = result.value as? String {
                        print(temp)
                    }
            }
            setUserID("")
        }
    }
    func abc(input:[EventData]) -> Int{
        return input.sort(){$0.price<$1.price}.map(){$0.summary.characters.count}[0...99].filter(){$0>2}.reduce(0, combine: +)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://plenry.com/help")!)
        }
        if indexPath.section == 3 {
            if MFMailComposeViewController.canSendMail() {
                let picker = MFMailComposeViewController()
                picker.mailComposeDelegate = self
                picker.setSubject("Plenry App Feedback")
                let info = UIDevice.currentDevice()
                let content = "</br></br></br></br></br></br>\(info.modelName)</br>\(info.systemVersion)</br>\(getVersion())"
                print(content)
                picker.setMessageBody(content, isHTML: true)
                picker.setToRecipients(["company@plenry.com"])
                presentViewController(picker, animated: true, completion: nil)
            }else{
                SweetAlert().showAlert("Opps", subTitle: "Please check your network and mailbox settings", style: AlertStyle.Error)
            }
        }
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("MeUser", forIndexPath: indexPath) as! MeUser
                let meUser = profile(getUserID())
                cell.userPhoto.getAvatarFromCloudinary(meUser.photo)
                cell.userName.text = meUser.firstName + " " + meUser.lastName
                cell.history.text = "Member since " + getMemberSince(meUser.memberSince)
                let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(Me.imageTapped(_:)))
                cell.userPhoto.addGestureRecognizer(tapGestureRecognizer)
                cell.userPhoto.userInteractionEnabled = true
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("MeNormal", forIndexPath: indexPath) as! MeNormal
                cell.titleLabel.text = "Edit Personal Info"
                
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier("MeNormal", forIndexPath: indexPath) as! MeNormal
                cell.titleLabel.text = "Trust and Verification"
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("MeNormal2", forIndexPath: indexPath) as! MeNormal2
                cell.titleLabel.text = "Review"
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("MeSetting", forIndexPath: indexPath) as! MeSetting
            cell.titleLabel.text = "Large Image View"
            cell.swicher.on = !getSmallImage()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("feedback", forIndexPath: indexPath) as! feedback
            cell.label.text = "Help"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("feedback", forIndexPath: indexPath) as! feedback
            cell.label.text = "Send Feedback"
            cell.label.textColor = ColorBlue
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("Logout", forIndexPath: indexPath) as! Logout
            cell.label.textColor = ColorGrey
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("MeNormal", forIndexPath: indexPath) as! MeNormal
            return cell
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        uploadImageToCloudinary(image)
        print(image.size.height)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imageTapped(sender: AnyObject) {
//        let actionSheet = UIAlertController(title: "Change Photo", message: "Pick a photo from your camera roll.", preferredStyle: .ActionSheet)
//        let dismissHandler = {
//            (action: UIAlertAction!) in
//            self.openImagePicker()
//        }
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: {
//            (action: UIAlertAction) in
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }))
//        actionSheet.addAction(UIAlertAction(title: "OK", style: .Default, handler: dismissHandler))
//        presentViewController(actionSheet, animated: true, completion: nil)
        c.allowsEditing = false
        c.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(c, animated: true, completion: nil)
    }
    func openImagePicker() {
        self.dismissViewControllerAnimated(true, completion: nil)
        c.allowsEditing = false
        c.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(c, animated: true, completion: nil)
    }
    func uploadImageToCloudinary(img:UIImage) -> Bool {
        let cloudinary_url = "cloudinary://391732461231266:hcMfSQu5FdwZ822O4gdAwRekQOY@plenry"
        let uploader = CLUploader(CLCloudinary(url: cloudinary_url),delegate:self)
        uploader.upload( UIImageJPEGRepresentation(img, 0.8), options: ["format":"jpg"], withCompletion: { (_: [NSObject : AnyObject]!, errorResult:String!, code:Int, context:AnyObject!) -> Void in
//            print(errorResult)
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
        let cloudinaryPublicId = (result["public_id"] as? String)!
        let result = changePhoto(getUserID(), cloudinary: cloudinaryPublicId)
        let indexPath = NSIndexPath(forRow:0,inSection:0)
        MeTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        print(cloudinaryPublicId)
        print(result)
    }
    
    @IBAction func switcherClicked(sender: UISwitch) {
        setSmallImage(!sender.on)
    }
    
    func uploaderError(result: String!, code: Int, context: AnyObject!) {
//        uploadingProgress.text = "Uploading Failed, Check Your Network!"
    }
}
private let DeviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
    /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
    /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
    /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
    /* iPhone 6 */        "iPhone7,2": "iPhone 6",
    /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
    /* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
    /* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
    /* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
    /* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
    /* iPad Air 2 */      "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
    /* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
    /* iPad Mini 2 */     "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
    /* iPad Mini 3 */     "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]
func getVersion() -> String {
    let dictionary = NSBundle.mainBundle().infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as! String
    let build = dictionary["CFBundleVersion"] as! String
    return "\(version) build \(build)"
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
//        let mirror = reflect(machine)                // Swift 1.2
        let mirror = Mirror(reflecting: machine)  // Swift 2.0
        var identifier = ""
        
        // Swift 1.2 - if you use Swift 2.0 comment this loop out.
//        for i in 0..<mirror.count {
//            if let value = mirror[i].1.value as? Int8 where value != 0 {
//                identifier.append(UnicodeScalar(UInt8(value)))
//            }
//        }
        
        // Swift 2.0 and later - if you use Swift 2.0 uncomment his loop
         for child in mirror.children where child.value as? Int8 != 0 {
             identifier.append(UnicodeScalar(UInt8(child.value as! Int8)))
         }
        
        return DeviceList[identifier] ?? identifier
    }
    
}