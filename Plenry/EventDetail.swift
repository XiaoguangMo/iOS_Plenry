//
//  EventDetail.swift
//  Plenry
//
//  Created by NNNO on 7/1/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
//import GoogleMaps
import MapKit


class EventDetail: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    @IBOutlet var bigHeaderImageView: UIImageView!
    @IBOutlet var footer: UIView!
    @IBOutlet var minusBtn: UIButton!
    @IBOutlet var plusBtn: UIButton!
    @IBOutlet var joinBtn: UIButton!
    @IBOutlet var GuestNum: UILabel!
    @IBOutlet var CancelBtn: UIButton!
    @IBOutlet var bigTitle: UILabel!
    @IBOutlet var bigTime: UILabel!
    var myPic = UIImage()
    var tableHeaderView: UIView!
    var kTableHeightHeader = CGFloat(ScreenBounds.width * 180 / 320)
    //operation: 1:could join(explore), 2:could cancel(attend), 0:default(host)
    var operation = 0
    var numOfGuest = 1
    var currentEvent:EventData = fakeData()
    var churchLocation:CLLocationCoordinate2D = CLLocationCoordinate2D()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableHeaderView = self.tableView.tableHeaderView!
        self.tableView.tableHeaderView = nil
        self.tableView.addSubview(self.tableHeaderView)
        self.tableView.sendSubviewToBack(self.tableHeaderView)
        self.tableView.contentInset = UIEdgeInsetsMake(kTableHeightHeader, 0, 0, 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -kTableHeightHeader)
        self.bigHeaderImageView.getDetailImageFromCloudinary(currentEvent.image)
        self.bigTime.text = getDetailedEventTime(currentEvent.time_startAt)
        self.bigTitle.text = currentEvent.theme
        self.tableView.separatorColor = ColorSuperLightGrey
        updatingTableHeaderView()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        footer.backgroundColor = UIColor.whiteColor()
        footer.layer.borderWidth = 2
        footer.layer.borderColor = ColorGreen.CGColor
        joinBtn.backgroundColor = ColorGreen
        footer.backgroundColor = UIColor.whiteColor()
        joinBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        plusBtn.setTitleColor(ColorGreen, forState: .Normal)
        minusBtn.setTitleColor(ColorGreen, forState: .Normal)
        CancelBtn.backgroundColor = ColorGreen
        GuestNum.textColor = ColorGreen
        if numOfGuest == 1 {
            GuestNum.text = "only me"
        }else if numOfGuest == 2 {
            GuestNum.text = "me and 1 friend"
        }else{
            GuestNum.text = "me and " + String(numOfGuest-1) + " friends"
        }
        if operation == 1 {
            if currentEvent.hostID == getUserID() {
                operation = 0
            }else{
                let checkAttending = currentEvent.orderStatus
                if checkAttending == "Accepted" {
                    operation = 2
                }else if checkAttending == "Pending" {
                    operation = 4
                    self.CancelBtn.setTitle("Your request is pending, want to cancel?", forState: .Normal)
                }else if checkAttending == "Event cancelled by host" || checkAttending == "Cancelled by guest" || checkAttending == "Declined" || checkAttending == "Expired" {
                    operation = 5
                    self.CancelBtn.setTitle("Not availiable to join", forState: .Normal)
                    self.CancelBtn.backgroundColor = UIColor.lightGrayColor()
                    footer.layer.borderColor = ColorLightGrey.CGColor
                }
            }
        }
        if operation == 0 {
            footer.hidden = true
        }else if operation == 1 {
            footer.hidden = false
            CancelBtn.hidden = true
        }else{
            footer.hidden = false
            minusBtn.hidden = true
            plusBtn.hidden = true
            joinBtn.hidden = true
            GuestNum.hidden = true
        }
        
        if operation == 2 {
            let checkAttending = currentEvent.orderStatus
            if checkAttending == "Pending" {
                operation = 4
                self.CancelBtn.setTitle("Your request is pending, want to cancel?", forState: .Normal)
            }else if checkAttending == "Event cancelled by host" || checkAttending == "Cancelled by guest" || checkAttending == "Declined" || checkAttending == "Expired" {
                operation = 5
                self.CancelBtn.setTitle("Not availiable to join", forState: .Normal)
                self.CancelBtn.backgroundColor = UIColor.lightGrayColor()
                footer.layer.borderColor = ColorLightGrey.CGColor
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updatingTableHeaderView() {
        var newsHeaderTableRect = CGRect(x: 0, y: -kTableHeightHeader, width: ScreenBounds.width, height: kTableHeightHeader)
        
        if self.tableView.contentOffset.y < -kTableHeightHeader {
            newsHeaderTableRect.origin.y = self.tableView.contentOffset.y
            newsHeaderTableRect.size.height = -self.tableView.contentOffset.y
        }
        
        if self.tableView.contentOffset.y > 100 {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true
        }
        self.tableHeaderView.frame = newsHeaderTableRect
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UserInfo = storyboard.instantiateViewControllerWithIdentifier("UserInfo") as! UserInfo
            vc.userId = currentEvent.hostID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 && currentEvent.totalGuests != 0 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: GuestNameSpace = storyboard.instantiateViewControllerWithIdentifier("GuestNameSpace") as! GuestNameSpace
            vc.currentEvent = self.currentEvent
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailHost", forIndexPath: indexPath) as! DetailHost
            cell.pic.getAvatarFromCloudinary(currentEvent.hostPic)
            cell.name.text = currentEvent.hostFirstName
            cell.stars.image = getRatingImage(Float(currentEvent.hostOverallRating))
            cell.rate.text = currentEvent.hostOverallRating.description.substringToIndex(currentEvent.hostOverallRating.description.startIndex.advancedBy(3))
            cell.reviews.text = "(" + String(currentEvent.hostReviewsCount) + " reviews)"
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailAttending", forIndexPath: indexPath) as! DetailAttending
            cell.type.textColor = ColorGrey
            if currentEvent.guestList.count > 6 {
                cell.img1.getAvatarFromCloudinary(currentEvent.guestList[0]["guestPic"] as! String)
                cell.img2.getAvatarFromCloudinary(currentEvent.guestList[1]["guestPic"] as! String)
                cell.img3.getAvatarFromCloudinary(currentEvent.guestList[2]["guestPic"] as! String)
                cell.img4.getAvatarFromCloudinary(currentEvent.guestList[3]["guestPic"] as! String)
                cell.img5.getAvatarFromCloudinary(currentEvent.guestList[4]["guestPic"] as! String)
                cell.img6.image = UIImage(named: "grey_circle")
                cell.extraGuest.hidden = false
                cell.extraGuest.text = "+" + String(currentEvent.guestList.count - 5)
            }else if currentEvent.guestList.count == 6 {
                cell.img1.getAvatarFromCloudinary(currentEvent.guestList[0]["guestPic"] as! String)
                cell.img2.getAvatarFromCloudinary(currentEvent.guestList[1]["guestPic"] as! String)
                cell.img3.getAvatarFromCloudinary(currentEvent.guestList[2]["guestPic"] as! String)
                cell.img4.getAvatarFromCloudinary(currentEvent.guestList[3]["guestPic"] as! String)
                cell.img5.getAvatarFromCloudinary(currentEvent.guestList[4]["guestPic"] as! String)
                cell.img6.getAvatarFromCloudinary(currentEvent.guestList[5]["guestPic"] as! String)
            }else if currentEvent.guestList.count == 5 {
                cell.img1.getAvatarFromCloudinary(currentEvent.guestList[0]["guestPic"] as! String)
                cell.img2.getAvatarFromCloudinary(currentEvent.guestList[1]["guestPic"] as! String)
                cell.img3.getAvatarFromCloudinary(currentEvent.guestList[2]["guestPic"] as! String)
                cell.img4.getAvatarFromCloudinary(currentEvent.guestList[3]["guestPic"] as! String)
                cell.img5.getAvatarFromCloudinary(currentEvent.guestList[4]["guestPic"] as! String)
                cell.img6.hidden = true
            }else if currentEvent.guestList.count == 4 {
                cell.img1.getAvatarFromCloudinary(currentEvent.guestList[0]["guestPic"] as! String)
                cell.img2.getAvatarFromCloudinary(currentEvent.guestList[1]["guestPic"] as! String)
                cell.img3.getAvatarFromCloudinary(currentEvent.guestList[2]["guestPic"] as! String)
                cell.img4.getAvatarFromCloudinary(currentEvent.guestList[3]["guestPic"] as! String)
                cell.img5.hidden = true
                cell.img6.hidden = true
            }else if currentEvent.guestList.count == 3 {
                cell.img1.getAvatarFromCloudinary(currentEvent.guestList[0]["guestPic"] as! String)
                cell.img2.getAvatarFromCloudinary(currentEvent.guestList[1]["guestPic"] as! String)
                cell.img3.getAvatarFromCloudinary(currentEvent.guestList[2]["guestPic"] as! String)
                cell.img4.hidden = true
                cell.img5.hidden = true
                cell.img6.hidden = true
            }else if currentEvent.guestList.count == 2 {
                cell.img1.getAvatarFromCloudinary(currentEvent.guestList[0]["guestPic"] as! String)
                cell.img2.getAvatarFromCloudinary(currentEvent.guestList[1]["guestPic"] as! String)
                cell.img3.hidden = true
                cell.img4.hidden = true
                cell.img5.hidden = true
                cell.img6.hidden = true
            }else if currentEvent.guestList.count == 1 {
                cell.img1.getAvatarFromCloudinary(currentEvent.guestList[0]["guestPic"] as! String)
                cell.img2.hidden = true
                cell.img3.hidden = true
                cell.img4.hidden = true
                cell.img5.hidden = true
                cell.img6.hidden = true
            }else{
                cell.accessoryType = .None
                cell.noGuest.hidden = false
                cell.img1.hidden = true
                cell.img2.hidden = true
                cell.img3.hidden = true
                cell.img4.hidden = true
                cell.img5.hidden = true
                cell.img6.hidden = true
            }
            cell.img1.image = UIImage()
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailLocation", forIndexPath: indexPath) as! DetailLocation
            if self.operation == 0 {
                cell.address.text = currentEvent.address.replace(", United States", withString: "")
            } else {
                if currentEvent.orderStatus == "Accepted" {
                    cell.address.text = currentEvent.address.replace(", United States", withString: "")
                } else {
                    cell.address.text = currentEvent.address_city + ", " + currentEvent.address_state
                }
            }
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailPrice", forIndexPath: indexPath) as! DetailPrice
            if currentEvent.price == 0 {
                cell.price.text = "Free"
                cell.perPerson.hidden = true
            }else {
                cell.price.text = "$ "+String(currentEvent.price)
                cell.perPerson.hidden = false
            }

            return cell
        }
        else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailSummary", forIndexPath: indexPath) as! EventDetailSummary
            cell.Summary.text = currentEvent.summary
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailMap", forIndexPath: indexPath) as! EventDetailMap
            let addressMap = MKMapView(frame: CGRectMake(0,0,ScreenBounds.width,159))
            let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(CLLocationDegrees(0.03), CLLocationDegrees(0.03))
            churchLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(currentEvent.location_latApprox), longitude: CLLocationDegrees(currentEvent.location_lngApprox))
            let theRegion: MKCoordinateRegion = MKCoordinateRegionMake(churchLocation, theSpan)
            addressMap.setRegion(theRegion, animated: true)
            let circle = UIImageView(frame: CGRectMake((ScreenBounds.width - 100) / 2, 30, 100, 100))
            circle.image = UIImage(named: "circle2")
            cell.addSubview(addressMap)
            cell.addSubview(circle)
            addressMap.userInteractionEnabled = false
            
            return cell
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventArea" {
            let svc = segue.destinationViewController as! EventArea
            svc.location = churchLocation
        }
        if segue.identifier == "showUserInfo2" {
            let svc = segue.destinationViewController as! UserInfo
            svc.userId = currentEvent.hostID
        }
        if segue.identifier == "eventToGuest" {
            let svc = segue.destinationViewController as! GuestList
            svc.mealId = currentEvent.id
        }
    }
    
    @IBAction func deleteGuest(sender: AnyObject) {
        if numOfGuest > 1 {
            numOfGuest -= 1
            if numOfGuest == 1 {
                GuestNum.text = "only me"
            }else if numOfGuest == 2 {
                GuestNum.text = "me and 1 friend"
            }else{
                GuestNum.text = "me and " + String(numOfGuest-1) + " friends"
            }
        }
    }
    
    @IBAction func addGuest(sender: AnyObject) {
        if numOfGuest < currentEvent.spotsLeft {
            numOfGuest += 1
            if numOfGuest == 1 {
                GuestNum.text = "only me"
            }else if numOfGuest == 2 {
                GuestNum.text = "me and 1 friend"
            }else{
                GuestNum.text = "me and " + String(numOfGuest-1) + " friends"
            }
        }
    }
    
    @IBAction func joinEvent(sender: AnyObject) {
        if currentEvent.price != 0 {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://plenry.com/events/" + currentEvent.id )!)
        }else{
            if currentEvent.spotsLeft == 0 {
                SweetAlert().showAlert("This Event is already full!")
            } else if profile(getUserID()).verifyPhone == 0 {
                SweetAlert().showAlert("", subTitle: "You need to verify your phone number before you can join an event.", style: .Warning, buttonTitle: "Cancel", buttonColor: ColorGrey, otherButtonTitle: "Verify", otherButtonColor: ColorGreen) { (isOtherButton) -> Void in
                    if !isOtherButton {
                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc: PhoneVerify = storyboard.instantiateViewControllerWithIdentifier("PhoneVerify") as! PhoneVerify
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            } else if profile(getUserID()).verifyPhone == 1 {
                SweetAlert().showAlert("", subTitle: "Confirm your paticipation to the event.", style: AlertStyle.Warning, buttonTitle:"Cancel", buttonColor:ColorGrey , otherButtonTitle:  "Confirm", otherButtonColor: ColorGreen) { (isOtherButton) -> Void in
                    if !isOtherButton {
                        let result = attendEvent(getUserID(), mealId: self.currentEvent.id, numberOfGuest: String(self.numOfGuest))
                        print(result)
                        if result.replace("\"", withString: "") == "accepted" {
                            SweetAlert().showAlert("Congratulation!", subTitle: "Your paticipation is confirmed.", style: AlertStyle.Success)
                        }else if result.replace("\"", withString: "") == "request sent" {
                            SweetAlert().showAlert("Congratulation!", subTitle: "Your request has been sent to the host.", style: AlertStyle.Success)
                        }else{
                            SweetAlert().showAlert("Opps!", subTitle: "You cannot join this event.", style: AlertStyle.Error)
                        }
                    }
                }
            }
        }
    }
    @IBAction func cancelEvent(sender: AnyObject) {
        if operation != 5 {
            SweetAlert().showAlert("Confirm Cancellation", subTitle: "You will not be able to re-join this event.", style: AlertStyle.Warning, buttonTitle:"Never mind", buttonColor:ColorGrey , otherButtonTitle:  "Confirm", otherButtonColor: ColorRed) { (isOtherButton) -> Void in
                if !isOtherButton{
                    let result = cancelOrder(getUserID(), mealId: self.currentEvent.id)
                    if result.replace("\"", withString: "") == "true" {
                        SweetAlert().showAlert("All Set", subTitle: "We'll let host know you are not coming.", style: AlertStyle.Success)
                    }else{
                        SweetAlert().showAlert("Opps!", subTitle: "Sorry, we couldn't process your request.", style: AlertStyle.Error)
                    }
                }
            }
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updatingTableHeaderView()
    }
}
