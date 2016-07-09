//
//  Attending.swift
//  Plenry
//
//  Created by NNNO on 6/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Attending: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var pastBtn: UIButton!
    @IBOutlet var upcomingBtn: UIButton!
    var interactivePopTransition: UIPercentDrivenInteractiveTransition!
    var content:[EventData] = []
    var upcoming:[EventData] = []
    var past:[EventData] = []
    var defaultPic = UIImage(named: "picture 320*180")
    var defaultAvatar = UIImage(named: "avatar")
    var shouldwait = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(3) as! UITabBarItem
        tabItem.badgeValue = String(UIApplication.sharedApplication().applicationIconBadgeNumber)
        if tabItem.badgeValue == "0" {
            tabItem.badgeValue = nil
        }
        tableView.backgroundColor = ColorSuperLightGrey
        segment.tintColor = ColorGreen
        tabBarItem.selectedImage = UIImage(named: "ticket_slct.png")!.imageWithRenderingMode(.AlwaysOriginal)
        tableView.separatorColor = UIColor.clearColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        reload()
        tableView.delegate = self
        tableView.dataSource = self
        self.segment.frame = CGRectMake(0, 0, ScreenBounds.width, 30)
        self.tableView.addPullToRefresh({ [weak self] in
            sleep(1)
            self!.reload()
            })
    }
    func reload() {
        if shouldwait {
            self.pleaseWait()
            shouldwait = !shouldwait
        }
        Alamofire.request(.POST, "https://plenry.com/rest/user/events", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.content = attendingList(temp).filter(){$0.orderStatus != "Cancelled by guest" && $0.orderStatus != "Declined"}
                    self.upcoming = []
                    self.past = []
                    for i in self.content {
                        if isUpcoming(i.time_startAt) {
                            self.upcoming.append(i)
                        }else{
                            self.past.append(i)
                        }
                    }
                    if (self.upcoming.count == 0 && self.segment.selectedSegmentIndex == 0) || (self.past.count == 0 && self.segment.selectedSegmentIndex == 1){
                        let blankPage = UIImageView(image: UIImage(named: "attending_empty"))
                        blankPage.frame = self.tableView.frame
                        self.tableView.backgroundView = blankPage
                    }else{
                        self.tableView.backgroundView = nil
                    }
                    self.upcoming.sortInPlace() { $0.time_startAt < $1.time_startAt}
                    self.past.sortInPlace() { $0.time_startAt > $1.time_startAt}
                    self.tableView.reloadData()
                    self.clearAllNotice()
                }
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.tableView.fixedPullToRefreshViewForDidScroll()
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        if (segment.selectedSegmentIndex == 0 && upcoming.count == 0) || (segment.selectedSegmentIndex == 1 && past.count == 0) {
            let blankPage = UIImageView(image: UIImage(named: "attending_empty"))
            blankPage.frame = self.tableView.frame
            tableView.backgroundView = blankPage
        }else{
            tableView.backgroundView = nil
        }
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (ScreenBounds.width - 40) * 79 / 140 + 162
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segment.selectedSegmentIndex == 0 ? upcoming.count : past.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let eventCell = tableView.dequeueReusableCellWithIdentifier("Event", forIndexPath: indexPath) as! Event
        if segment.selectedSegmentIndex == 0{
            eventCell.eventPic.image = defaultPic
            eventCell.eventPic.getAttendingFromCloudinary(upcoming[indexPath.row].image)
            eventCell.hostPic.image = defaultAvatar
            eventCell.hostPic.getAvatarFromCloudinary(upcoming[indexPath.row].hostPic)
            eventCell.theme.text = upcoming[indexPath.row].theme
            eventCell.time.text = getEventTime(upcoming[indexPath.row].time_startAt)
            eventCell.location.text = upcoming[indexPath.row].address_city
            eventCell.status.hidden = false
            eventCell.writeReview.hidden = true
            eventCell.hostName.text = upcoming[indexPath.row].hostFirstName
            eventCell.status.text = upcoming[indexPath.row].orderStatus
        }else{
            eventCell.eventPic.image = defaultPic
            eventCell.eventPic.getAttendingFromCloudinary(past[indexPath.row].image)
            eventCell.hostPic.image = defaultAvatar
            eventCell.hostPic.getAvatarFromCloudinary(past[indexPath.row].hostPic)
            eventCell.theme.text = past[indexPath.row].theme
            eventCell.time.text = getEventTime(past[indexPath.row].time_startAt)
            eventCell.location.text = past[indexPath.row].address_city
            eventCell.hostName.text = past[indexPath.row].hostFirstName
            if past[indexPath.row].reviewable == 1 {
                eventCell.status.hidden = true
                eventCell.writeReview.hidden = false
            }else{
                eventCell.status.text = past[indexPath.row].orderStatus
            }
        }
        if eventCell.status.text == "Accepted" {
            eventCell.status.textColor = ColorGreen
        }else if eventCell.status.text == "Declined" {
            eventCell.status.textColor = ColorRed
        }else if eventCell.status.text == "Pending" {
            eventCell.status.textColor = ColorBlue
        }else{
            eventCell.status.textColor = ColorGrey
        }
        return eventCell
    }
    override func viewWillAppear(animated: Bool) {
        self.reload()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showUserInfo" {
            let button = sender as! UIButton
            let cell = button.superview?.superview?.superview as! Event
            let indexPath = tableView.indexPathForCell(cell)
            let svc = segue.destinationViewController as! UserInfo
            if segment.selectedSegmentIndex == 0 {
                svc.userId = upcoming[indexPath!.row].hostID
            }else{
                svc.userId = past[indexPath!.row].hostID
            }
            svc.isHost = true
        }
        if segue.identifier == "showAttendEventDetail" {
            let cell = sender as! Event
            let indexPath = tableView.indexPathForCell(cell)
            let svc = segue.destinationViewController as! EventDetail
            if segment.selectedSegmentIndex == 0 {
                svc.currentEvent = upcoming[indexPath!.row]
            }else{
                svc.currentEvent = past[indexPath!.row]
            }
            if segment.selectedSegmentIndex == 0 {
                svc.operation = 2
            }
        }
        if segue.identifier == "attendingToNewReview" {
            let button = sender as! UIButton
            let cell = button.superview?.superview?.superview as! Event
            let indexPath = tableView.indexPathForCell(cell)
            let svc = segue.destinationViewController as! NewReview
            svc.ReviewIsToGuest = false
            svc.mealId = past[indexPath!.row].id
        }
    }
}