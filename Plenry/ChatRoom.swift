//
//  ChatRoom.swift
//  Plenry
//
//  Created by NNNO on 8/25/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ChatRoom: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    var eventList:[EventData] = []
    var inbox:[Inbox] = []
//    var contacts:[Contacts] = []
    var contactList = Set<String>()
    var sortedInbox:[Inbox] = []
    var filteredInbox:[Inbox] = []
//    var filteredContacts:[Contacts] = []
    var notifications = [Notification]()
    var shouldwait = true
    var loadCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.tintColor = ColorGreen
        self.tableView.separatorColor = ColorSuperLightGrey
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.segment.frame = CGRectMake(0, 0, ScreenBounds.width, 30)
        reload()
        self.tableView.addPullToRefresh({ [weak self] in
            sleep(1)
            self?.reload()
            })
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
    }
    func setEmptyPage(input:Int) {
        self.loadCount += input
        if self.loadCount < 3 {
            return
        }
        if segment.selectedSegmentIndex == 0 && sortedInbox.count == 0 {
            let blankPage = UIImageView(image: UIImage(named: "chat_empty"))
            blankPage.frame = self.tableView.frame
            tableView.backgroundView = blankPage
            tableView.separatorStyle = .None
        }else if segment.selectedSegmentIndex == 1 && eventList.count == 0 {
            let blankPage = UIImageView(image: UIImage(named: "contacts_empty"))
            blankPage.frame = self.tableView.frame
            tableView.backgroundView = blankPage
            tableView.separatorStyle = .None
        }else if segment.selectedSegmentIndex == 2 && notifications.count == 0 {
            let blankPage = UIImageView(image: UIImage(named: "no_notification"))
            blankPage.frame = self.tableView.frame
            tableView.backgroundView = blankPage
            tableView.separatorStyle = .None
        }else{
            tableView.backgroundView = nil
            tableView.separatorStyle = .SingleLine
        }
        tableView.reloadData()
        self.clearAllNotice()
        loadCount = 0
    }
    func reload() {
        if shouldwait {
            self.pleaseWait()
            shouldwait = !shouldwait
        }
        eventList = []
        Alamofire.request(.POST, "https://plenry.com/rest/notifications", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.notifications = getNotification(temp)
                    self.notifications.sortInPlace(){$0.createdAt > $1.createdAt}
                    UIApplication.sharedApplication().applicationIconBadgeNumber = self.notifications.count
                    
                    let tabArray = self.tabBarController?.tabBar.items as NSArray!
                    let tabItem = tabArray.objectAtIndex(3) as! UITabBarItem
                    tabItem.badgeValue = String(UIApplication.sharedApplication().applicationIconBadgeNumber)
                    if tabItem.badgeValue == "0" {
                        tabItem.badgeValue = nil
                    }
                    
                    self.setEmptyPage(1)
                }
        }
        Alamofire.request(.POST, "https://plenry.com/rest/inbox", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.inbox = getInbox(temp)
                    self.inbox.sortInPlace() { $0.createdAt > $1.createdAt}
                    self.contactList = Set<String>()
                    self.sortedInbox = []
                    for i in self.inbox {
                        self.contactList.insert(i.toUserId)
                        self.contactList.insert(i.userId)
                    }
                    self.contactList.remove(getUserID())
                    for i in self.inbox {
                        if self.contactList.contains(i.userId) {
                            self.sortedInbox.append(i)
                            self.contactList.remove(i.userId)
                        }
                        if self.contactList.contains(i.toUserId) {
                            self.sortedInbox.append(i)
                            self.contactList.remove(i.toUserId)
                        }
                    }
                    self.setEmptyPage(1)
                }
        }
        Alamofire.request(.POST, "https://plenry.com/rest/userandhost/events", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.eventList = attendingList(temp).filter() {!isUpcoming($0.time_startAt)}
                    self.eventList.sortInPlace() {$0.time_startAt > $1.time_startAt}
                    self.setEmptyPage(1)
                }
        }
//        Alamofire.request(.POST, "https://plenry.com/rest/host/events", parameters: ["userId": getUserID()])
//            .responseJSON { _,_,result in
//                if result.isFailure {
//                    return
//                }
//                if let temp = result.value as? NSArray {
//                    self.eventList += hostingList(temp).filter(){$0.status == 1 && !isUpcoming($0.time_startAt) && $0.guestList.count > 0}
//                    self.eventList.sortInPlace() {$0.time_startAt > $1.time_startAt}
//                    self.setEmptyPage(1)
//                }
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredInbox = sortedInbox.filter({ (text:Inbox) -> Bool in
//            if searchText.characters.count < 1 {
//                return true
//            }
//            if text.userId == getUserID() {
//                if text.toFirstName.lowercaseString.contains(searchText.lowercaseString) {
//                    return true
//                }
//            }else{
//                if text.fromFirstName.lowercaseString.contains(searchText.lowercaseString) {
//                    return true
//                }
//            }
//            return false
//        })
//        filteredContacts = contacts.filter() {$0.first_name.lowercaseString.contains(searchText.lowercaseString)}
//        tableView.reloadData()
//    }

    @IBAction func openBigAvatar(sender: UIButton) {
        self.tabBarController!.view.alpha = 0.5
        let popImage = UIView()
        popImage.frame = CGRectMake(0, 0, ScreenBounds.width, ScreenBounds.height)
        popImage.backgroundColor = UIColor.clearColor()
        let avatar = UIImageView(frame: CGRectMake(0, (ScreenBounds.height - ScreenBounds.width) / 2, ScreenBounds.width, ScreenBounds.width))
        avatar.userInteractionEnabled = false
        let button = sender as UIButton
        let cell = button.superview?.superview as! ChatCell
        let indexPath2 = tableView.indexPathForCell(cell)
        if sortedInbox[indexPath2!.row].userId == getUserID() {
            avatar.getPreviewAvatarFromCloudinary(sortedInbox[indexPath2!.row].toPicture)
        }else{
            avatar.getPreviewAvatarFromCloudinary(sortedInbox[indexPath2!.row].fromPicture)
        }
        popImage.addSubview(avatar)
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        popImage.frame = window.bounds
        window.addSubview(popImage)
        window.bringSubviewToFront(popImage)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatRoom.handleTap(_:)))
        tap.delegate = self
        popImage.addGestureRecognizer(tap)
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        self.tabBarController!.view.alpha = 1.0
    }
    @IBAction func indexChanged(sender: UISegmentedControl) {
        setEmptyPage(3)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if segment.selectedSegmentIndex == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell
            if sortedInbox[indexPath.row].userId == getUserID() {
                cell.pic2.getAvatarFromCloudinary(sortedInbox[indexPath.row].toPicture)
                cell.name.text = sortedInbox[indexPath.row].toFirstName
            }else{
                cell.pic2.getAvatarFromCloudinary(sortedInbox[indexPath.row].fromPicture)
                cell.name.text = sortedInbox[indexPath.row].fromFirstName
            }
            cell.time.text = getDateOnly(sortedInbox[indexPath.row].createdAt)
            cell.content.text = sortedInbox[indexPath.row].content
            if sortedInbox[indexPath.row].readBy == "" && sortedInbox[indexPath.row].userId != getUserID(){
                cell.time.textColor = UIColor.blueColor()
            }else{
                cell.time.textColor = ColorGrey
            }
            return cell
        }else if segment.selectedSegmentIndex == 1{
            if indexPath.row == 0 {
                let cell = self.tableView.dequeueReusableCellWithIdentifier("ReviewTitle", forIndexPath: indexPath) as! ReviewTitle
                cell.pic.image = UIImage(named: "stay_connected")
                return cell
            }else{
                let cell = self.tableView.dequeueReusableCellWithIdentifier("Glance", forIndexPath: indexPath) as! Glance
                if eventList.count < 1 {
                    return cell
                }
                cell.theme.text = eventList[indexPath.row - 1].theme
                cell.time.text = getDateOnly(eventList[indexPath.row - 1].time_startAt)
                cell.city.text = eventList[indexPath.row - 1].address_city
                cell.pic.getExplorerFromCloudinary(eventList[indexPath.row - 1].image)
                return cell
            }
        }else{
            let cell = self.tableView.dequeueReusableCellWithIdentifier("NotificationCell", forIndexPath: indexPath) as! NotificationCell
            if notifications[indexPath.row].type == 0 {
                cell.pic.image = UIImage(named: "noti_review")
                cell.header.text = "Review"
            }else if notifications[indexPath.row].type == 1 {
                cell.pic.image = UIImage(named: "noti_request")
                cell.header.text = "Request"
            }else{
                cell.pic.image = UIImage(named: "noti_reminder")
                cell.header.text = "Reminder"
            }
            cell.content.textColor = UIColor.lightGrayColor()
            cell.content.text = notifications[indexPath.row].content
            return cell
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return sortedInbox.count
        }else if segment.selectedSegmentIndex == 1 {
            return eventList.count == 0 ? 0 : eventList.count + 1
        }else{
            return notifications.count
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if segment.selectedSegmentIndex == 0 {
            return 65
        }else if segment.selectedSegmentIndex == 1 {
            if indexPath.row == 0 {
                return ScreenBounds.width * 201 / 320
            }else{
                return 76
            }
        }else{
            return 65
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if segment.selectedSegmentIndex == 0 {
            let vc: Messages = storyboard.instantiateViewControllerWithIdentifier("Messages") as! Messages
            var friend = emptyUser()
            if sortedInbox[indexPath.row].userId == getUserID() {
                friend = profile(sortedInbox[indexPath.row].toUserId)
            }else{
                friend = profile(sortedInbox[indexPath.row].userId)
            }
            vc.friendId = friend.id
            vc.friendName = friend.firstName
            self.navigationController?.pushViewController(vc, animated: true)
        }else if segment.selectedSegmentIndex == 1 {
            if indexPath.row != 0 {
            let vc: GuestName = storyboard.instantiateViewControllerWithIdentifier("GuestName") as! GuestName
            vc.mealId = eventList[indexPath.row - 1].id
            self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if notifications[indexPath.row].type == 0 && notifications[indexPath.row].subType == 1 {
                let vc: NewReview = storyboard.instantiateViewControllerWithIdentifier("NewReview") as! NewReview
                vc.ReviewIsToGuest = false
                vc.mealId = notifications[indexPath.row].mealId
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if notifications[indexPath.row].type == 0 && notifications[indexPath.row].subType == 2 {
                let vc: GuestList = storyboard.instantiateViewControllerWithIdentifier("GuestList") as! GuestList
                vc.mealId = notifications[indexPath.row].mealId
                vc.isHost = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            if notifications[indexPath.row].type == 1 && notifications[indexPath.row].subType == 1 {
//                let vc: EventDetail = storyboard.instantiateViewControllerWithIdentifier("EventDetail") as! EventDetail
//                vc.operation = 2
//                vc.currentEvent =
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            if notifications[indexPath.row].type == 1 && notifications[indexPath.row].subType == 3 {
                let vc: GuestList = storyboard.instantiateViewControllerWithIdentifier("GuestList") as! GuestList
                vc.mealId = notifications[indexPath.row].mealId
                vc.isHost = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            if notifications[indexPath.row].type == 2 && notifications[indexPath.row].subType == 1 {
//                let vc: EventDetail = storyboard.instantiateViewControllerWithIdentifier("EventDetail") as! EventDetail
//                vc.operation = 0
//                vc.currentEvent
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            if notifications[indexPath.row].type == 2 && notifications[indexPath.row].subType == 5 {
                let vc: UserInfo = storyboard.instantiateViewControllerWithIdentifier("UserInfo") as! UserInfo
                vc.isHost = true
                vc.userId = notifications[indexPath.row].fromUserId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return segment.selectedSegmentIndex == 2
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete  && segment.selectedSegmentIndex == 2 {
            let result = readNotification(self.notifications[indexPath.row].id)
            if result.replace("\"", withString: "") != "true" {
                SweetAlert().showAlert("Opps", subTitle: "Sorry, we couldn't process your request.", style: AlertStyle.Error)
            }else{
                self.notifications.removeAtIndex(indexPath.row)
                self.tableView.reloadData()
                UIApplication.sharedApplication().applicationIconBadgeNumber = self.notifications.count
                
                let tabArray = self.tabBarController?.tabBar.items as NSArray!
                let tabItem = tabArray.objectAtIndex(3) as! UITabBarItem
                tabItem.badgeValue = String(UIApplication.sharedApplication().applicationIconBadgeNumber)
                if tabItem.badgeValue == "0" {
                    tabItem.badgeValue = nil
                }
            }
        }
    }
    func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {

    }
}