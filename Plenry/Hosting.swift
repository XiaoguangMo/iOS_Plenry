//
//  Hosting.swift
//  Plenry
//
//  Created by NNNO on 6/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Hosting: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var pastBtn: UIButton!
    @IBOutlet var upcomingBtn: UIButton!
    var content:[EventData] = []
    var upcoming:[EventData] = []
    var selectedEvent = fakeData()
    var past:[EventData] = []
    var filteredData:[EventData] = []
    var toWhichMeal = ""
    var toWhichMeal2 = fakeData()
    var shouldwait = true
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(3) as! UITabBarItem
        tabItem.badgeValue = String(UIApplication.sharedApplication().applicationIconBadgeNumber)
        if tabItem.badgeValue == "0" {
            tabItem.badgeValue = nil
        }
        segment.tintColor = ColorGreen
        tableView.backgroundColor = ColorSuperLightGrey
        tabBarItem.selectedImage = UIImage(named: "crown_slct.png")!.imageWithRenderingMode(.AlwaysOriginal)
        tableView.separatorColor = UIColor.clearColor()
        self.segment.frame = CGRectMake(0, 0, ScreenBounds.width, 30)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "titleshadow"), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        reload()
        self.tableView.addPullToRefresh({ [weak self] in
            sleep(1)
            self!.reload()
            })
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(animated: Bool) {
        self.reload()
    }
    func reload() {
        if shouldwait {
            self.pleaseWait()
            shouldwait = !shouldwait
        }
        Alamofire.request(.POST, "https://plenry.com/rest/host/events", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.content = hostingList(temp)
                    for i in self.content {
                        print(i.id)
                        print(i.maxParty)
                        print(i.acceptedGuests)
                    }
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
                        let blankPage = UIImageView(image: UIImage(named: "hosting_empty"))
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
            let blankPage = UIImageView(image: UIImage(named: "hosting_empty"))
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
        if segment.selectedSegmentIndex == 0 {
            return upcoming.count
        } else {
            return past.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HostEvent", forIndexPath: indexPath) as! hostEvent
        if segment.selectedSegmentIndex == 0 {
            cell.hostEventPic.getAttendingFromCloudinary(upcoming[indexPath.row].image)
            cell.hostTheme.text = upcoming[indexPath.row].theme
            cell.hostTime.text = getEventTime(upcoming[indexPath.row].time_startAt)
            cell.hostLocation.text = upcoming[indexPath.row].address_city
            if upcoming[indexPath.row].price == 0 {
                cell.price.text = "Free"
            }else{
                cell.price.text = "$ "+String(upcoming[indexPath.row].price)
            }
            cell.guestSpots.text = String(upcoming[indexPath.row].spotsLeft) + " spots left"
            cell.edit.layer.borderColor = ColorGreen.CGColor
            cell.edit.setTitleColor(ColorGreen, forState: UIControlState.Normal)
        } else {
            cell.hostEventPic.getAttendingFromCloudinary(past[indexPath.row].image)
            cell.hostTheme.text = past[indexPath.row].theme
            cell.hostTime.text = getEventTime(past[indexPath.row].time_startAt)
            cell.hostLocation.text = past[indexPath.row].address_city
            if past[indexPath.row].price == 0 {
                cell.price.text = "Free"
            }else{
                cell.price.text = "$ "+String(past[indexPath.row].price)
            }
            cell.guestSpots.text = String(past[indexPath.row].spotsLeft) + " spots left"
            cell.edit.layer.borderColor = ColorDarkGrey.CGColor
            cell.edit.setTitleColor(ColorDarkGrey, forState: UIControlState.Normal)
        }
        return cell
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return !(identifier == "editEvent" && segment.selectedSegmentIndex == 1)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showGuestList" {
            let button = sender as! UIButton
            let cell = button.superview?.superview?.superview as! hostEvent
            let indexPath = tableView.indexPathForCell(cell)
            if segment.selectedSegmentIndex == 0 {
                toWhichMeal = upcoming[indexPath!.row].id
            }else{
                toWhichMeal = past[indexPath!.row].id
            }
            let svc = segue.destinationViewController as! GuestList
            svc.mealId = toWhichMeal
            svc.isHost = true
        }
        if segue.identifier == "showHostEventDetail" {
            let cell = sender as! hostEvent
            let indexPath = tableView.indexPathForCell(cell)
            let svc = segue.destinationViewController as! EventDetail
            if segment.selectedSegmentIndex == 0 {
                svc.currentEvent = upcoming[indexPath!.row]
            }else{
                svc.currentEvent = past[indexPath!.row]
            }
            svc.operation = 0
        }
        if segue.identifier == "editEvent" {
            let button = sender as! UIButton
            let cell = button.superview?.superview?.superview as! hostEvent
            let indexPath = tableView.indexPathForCell(cell)
            if segment.selectedSegmentIndex == 0 {
                toWhichMeal2 = upcoming[indexPath!.row]
            }else{
                toWhichMeal2 = past[indexPath!.row]
            }
            let svc = segue.destinationViewController as! NewEvent
            svc.mealToEdit = toWhichMeal2
        }
    }
}