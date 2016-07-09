//
//  NewReview.swift
//  Plenry
//
//  Created by NNNO on 8/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class NewReview: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIAlertViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var submitBtn: UIButton!
    
    @IBOutlet var footer: UIView!
    var ReviewIsToGuest = true
    var guestId = ""
    var mealId = ""
    var numOfStar1 = 0
    var numOfStar2 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        submitBtn.backgroundColor = ColorGreen
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewReview.keyboardChange(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewReview.keyboardChange(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ReviewIsToGuest {
            return 3
        }else {
            return 4
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if ReviewIsToGuest {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("NewReviewSection", forIndexPath: indexPath) as! NewReviewSection
                cell.label.text = "Public Feedback (Required)"
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("NewReviewTitle", forIndexPath: indexPath) as! NewReviewTitle
                cell.type.text = "Overall"
                cell.summary.text = "How is your ovarall experience?"
                cell.summary.textColor = UIColor.lightGrayColor()
                if numOfStar1 == 0 {
                    cell.pic.image = UIImage(named: "0.0_star")
                }else if numOfStar1 == 1 {
                    cell.pic.image = UIImage(named: "1.0_star")
                }else if numOfStar1 == 2 {
                    cell.pic.image = UIImage(named: "2.0_star")
                }else if numOfStar1 == 3 {
                    cell.pic.image = UIImage(named: "3.0_star")
                }else if numOfStar1 == 4 {
                    cell.pic.image = UIImage(named: "4.0_star")
                }else{
                    cell.pic.image = UIImage(named: "5.0_star")
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("NewReviewText", forIndexPath: indexPath) as! NewReviewText
                cell.type.text = "Your Impression of the Guest"
                cell.summary.text = "This review will be shown on the guest's page."
                cell.summary.textColor = UIColor.lightGrayColor()
                cell.textView.layer.borderColor = ColorLightGrey.CGColor
                cell.textView.layer.borderWidth = 1
                cell.textView.layer.cornerRadius = 5
                return cell
            }
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("NewReviewSection", forIndexPath: indexPath) as! NewReviewSection
                cell.label.text = "Public Feedback (Required)"
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("NewReviewTitle", forIndexPath: indexPath) as! NewReviewTitle
                cell.type.text = "Overall"
                cell.summary.text = "How is your overall experience?"
                cell.summary.textColor = UIColor.lightGrayColor()
                if numOfStar1 == 0 {
                    cell.pic.image = UIImage(named: "0.0_star")
                }else if numOfStar1 == 1 {
                    cell.pic.image = UIImage(named: "1.0_star")
                }else if numOfStar1 == 2 {
                    cell.pic.image = UIImage(named: "2.0_star")
                }else if numOfStar1 == 3 {
                    cell.pic.image = UIImage(named: "3.0_star")
                }else if numOfStar1 == 4 {
                    cell.pic.image = UIImage(named: "4.0_star")
                }else{
                    cell.pic.image = UIImage(named: "5.0_star")
                }
                return cell
            }else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier("NewReviewTitle", forIndexPath: indexPath) as! NewReviewTitle
                cell.type.text = "Communication"
                cell.summary.text = "How responsive was the host for your questions?"
                cell.summary.textColor = UIColor.lightGrayColor()
                if numOfStar2 == 0 {
                    cell.pic.image = UIImage(named: "0.0_star")
                }else if numOfStar2 == 1 {
                    cell.pic.image = UIImage(named: "1.0_star")
                }else if numOfStar2 == 2 {
                    cell.pic.image = UIImage(named: "2.0_star")
                }else if numOfStar2 == 3 {
                    cell.pic.image = UIImage(named: "3.0_star")
                }else if numOfStar2 == 4 {
                    cell.pic.image = UIImage(named: "4.0_star")
                }else{
                    cell.pic.image = UIImage(named: "5.0_star")
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("NewReviewText", forIndexPath: indexPath) as! NewReviewText
                cell.type.text = "Describe Your Experience"
                cell.summary.text = "This reveiw wiil be public both on your profile and your host's profile."
                cell.summary.textColor = UIColor.lightGrayColor()
                cell.textView.layer.borderColor = ColorLightGrey.CGColor
                cell.textView.layer.borderWidth = 1
                cell.textView.layer.cornerRadius = 5

                return cell
            }
        }
    }
    func keyboardChange(notification: NSNotification){
        let userInfo = notification.userInfo! as NSDictionary
        let animationDuration = userInfo.valueForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSTimeInterval
        let keyboardEndFrame = (userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue).CGRectValue()
        let rectH = keyboardEndFrame.size.height
        UIView.animateWithDuration(animationDuration, delay: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            if notification.name == UIKeyboardWillShowNotification{
                self.tableView.frame.size.height = ScreenBounds.height - 157 - rectH + 49
                self.footer.frame.origin.y = ScreenBounds.height - 93 - rectH + 49
            }else{
                self.tableView.frame.size.height = ScreenBounds.height - 157
                self.footer.frame.origin.y = ScreenBounds.height - 93
            }
            }, completion: nil)
        if notification.name == UIKeyboardWillShowNotification{
            self.scrollToBottom()
        }
    }
    func scrollToBottom() {
        if tableView.numberOfRowsInSection(0) > 0 {
            let indexPath = NSIndexPath(forRow: tableView.numberOfRowsInSection(0)-1, inSection: (0))
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
        }
    }
    
    @IBAction func oneStar(sender: AnyObject) {
        let button = sender as! UIButton
        let cell = button.superview?.superview as! NewReviewTitle
        let indexPath = tableView.indexPathForCell(cell)
        if ReviewIsToGuest {
            numOfStar1 = 1
            let indexPath1 = NSIndexPath(forRow:1,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
        }else{
            if indexPath!.row == 1 {
                numOfStar1 = 1
                let indexPath1 = NSIndexPath(forRow:1,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }else{
                numOfStar2 = 1
                let indexPath1 = NSIndexPath(forRow:2,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }
        }
    }
    
    @IBAction func twoStar(sender: AnyObject) {
        let button = sender as! UIButton
        let cell = button.superview?.superview as! NewReviewTitle
        let indexPath = tableView.indexPathForCell(cell)
        if ReviewIsToGuest {
            numOfStar1 = 2
            let indexPath1 = NSIndexPath(forRow:1,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
        }else{
            if indexPath!.row == 1 {
                numOfStar1 = 2
                let indexPath1 = NSIndexPath(forRow:1,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }else{
                numOfStar2 = 2
                let indexPath1 = NSIndexPath(forRow:2,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }
        }
    }
    
    @IBAction func threeStar(sender: AnyObject) {
        let button = sender as! UIButton
        let cell = button.superview?.superview as! NewReviewTitle
        let indexPath = tableView.indexPathForCell(cell)
        if ReviewIsToGuest {
            numOfStar1 = 3
            let indexPath1 = NSIndexPath(forRow:1,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
        }else{
            if indexPath!.row == 1 {
                numOfStar1 = 3
                let indexPath1 = NSIndexPath(forRow:1,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }else{
                numOfStar2 = 3
                let indexPath1 = NSIndexPath(forRow:2,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }
        }
    }
    
    @IBAction func fourStar(sender: AnyObject) {
        let button = sender as! UIButton
        let cell = button.superview?.superview as! NewReviewTitle
        let indexPath = tableView.indexPathForCell(cell)
        if ReviewIsToGuest {
            numOfStar1 = 4
            let indexPath1 = NSIndexPath(forRow:1,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
        }else{
            if indexPath!.row == 1 {
                numOfStar1 = 4
                let indexPath1 = NSIndexPath(forRow:1,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }else{
                numOfStar2 = 4
                let indexPath1 = NSIndexPath(forRow:2,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }
        }
    }

    @IBAction func fiveStar(sender: AnyObject) {
        let button = sender as! UIButton
        let cell = button.superview?.superview as! NewReviewTitle
        let indexPath = tableView.indexPathForCell(cell)
        print(12)
        if ReviewIsToGuest {
            print(2)
            numOfStar1 = 5
            let indexPath1 = NSIndexPath(forRow:1,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
        }else{
            if indexPath!.row == 1 {
                numOfStar1 = 5
                let indexPath1 = NSIndexPath(forRow:1,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }else{
                numOfStar2 = 5
                let indexPath1 = NSIndexPath(forRow:2,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }
        }
    }
    
    
    @IBAction func submitReview(sender: AnyObject) {
        var content = ""
        self.view.endEditing(true)
        if ReviewIsToGuest {
            let index = NSIndexPath(forRow: 2, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(index) as! NewReviewText
            content = cell.textView.text
            let result = newReview(mealId, userId: getUserID(), guestId: guestId, content: content, userToHost: "false", overallRating: String(numOfStar1), communicationRating: String(numOfStar2), privateFeedback: "", improvement: "")
//            print(result)
            if result.replace("\"", withString: "")=="done" {
                SweetAlert().showAlert("All Set", subTitle: "Your review has been submitted.", style: AlertStyle.Success)
                self.navigationController?.popViewControllerAnimated(true)
            }else if result.replace("\"", withString: "")=="The review deadline has passed [invalid-params]" {
                SweetAlert().showAlert("Opps", subTitle: "The review deadline has passed.", style: AlertStyle.Error)
            }else if result.replace("\"", withString: "")=="Experience/impression cannot be empty [invalid-params]" {
                SweetAlert().showAlert("Opps", subTitle: "Please write about your experience.", style: AlertStyle.Error)
            }else{
                SweetAlert().showAlert("Opps", subTitle: "Sorry, we couldn't process your request.", style: AlertStyle.Error)
            }
        }else{
            let index = NSIndexPath(forRow: 3, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(index) as! NewReviewText
            content = cell.textView.text
            let result = newReview(mealId, userId: getUserID(), guestId: "", content: content, userToHost: "true", overallRating: String(numOfStar1), communicationRating: String(numOfStar2), privateFeedback: "", improvement: "")
//            print(result)
            if result.replace("\"", withString: "")=="done" {
                SweetAlert().showAlert("All Set", subTitle: "Your review has been submitted.", style: AlertStyle.Success)
                self.navigationController?.popViewControllerAnimated(true)
            }else if result.replace("\"", withString: "")=="The review deadline has passed [invalid-params]" {
                SweetAlert().showAlert("Opps", subTitle: "The review deadline has passed.", style: AlertStyle.Error)
            }else if result.replace("\"", withString: "")=="Experience/impression cannot be empty [invalid-params]" {
                SweetAlert().showAlert("Opps", subTitle: "Please write about your experience.", style: AlertStyle.Error)
            }else{
                SweetAlert().showAlert("Opps", subTitle: "Sorry, we couldn't process your request.", style: AlertStyle.Error)
            }
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}