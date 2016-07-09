//
//  GuestList.swift
//  Plenry
//
//  Created by NNNO on 7/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class GuestList: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    @IBOutlet var tableView: UITableView!
    var mealId = ""
    var isHost = false
    var orders:[Order] = []
    var shouldwait = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addPullToRefresh({ [weak self] in
            sleep(1)
            self?.tableView.reloadData()
            })
        self.title = "Guest List"
        reload()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(animated: Bool) {
        reload()
    }
    func reload() {
//        self.pleaseWait()
        Alamofire.request(.POST, "https://plenry.com/rest/orders", parameters: ["mealId": mealId])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
//                    print(temp)
                    self.orders = getOrder(temp)
                    if self.orders.count == 0 {
                        self.tableView.separatorColor = UIColor.clearColor()
                        let blankPage = self.isHost ? UIImageView(image: UIImage(named: "empty_guestlist_host")) : UIImageView(image: UIImage(named: "empty_guestlist_guest"))
                        blankPage.frame = self.tableView.frame
                        self.tableView.backgroundView = blankPage
                    }else{
                        self.tableView.backgroundView = nil
                        self.tableView.separatorColor = ColorLightGrey
                    }
                    self.tableView.reloadData()
                    self.clearAllNotice()
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.tableView.fixedPullToRefreshViewForDidScroll()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Guest", forIndexPath: indexPath) as! Guest
        var nameTag = orders[indexPath.row].userFirstName
        if orders[indexPath.row].numberOfGuests > 1 {
            nameTag = nameTag + " + " + String(orders[indexPath.row].numberOfGuests - 1) + "friend(s)"
        }
        cell.name.text = nameTag
        cell.status.text = orders[indexPath.row].status
        cell.email.text = String(orders[indexPath.row].guestReviewsCount)+" reviews"
        cell.rate.image = getRatingImage(orders[indexPath.row].guestRate)
                switch orders[indexPath.row].status {
            case "Pending":
                cell.status.textColor = ColorBlue
            case "Accepted":
                cell.status.textColor = ColorGreen
                if orders[indexPath.row].reviewableToGuest == 1 {
                    cell.reviewBtn.hidden = false
                    cell.status.hidden = true
                }else{
                    cell.reviewBtn.hidden = true
                    cell.status.hidden = false
                }

            case "Declined":
                cell.status.textColor = ColorRed
            default:
                cell.status.textColor = ColorGrey
    }
    
    
        cell.pic.getAvatarFromCloudinary(orders[indexPath.row].userPic)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isHost {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UserInfo = storyboard.instantiateViewControllerWithIdentifier("UserInfo") as! UserInfo
            vc.userId = orders[indexPath.row].userId
            vc.order = orders[indexPath.row]
            vc.isHost = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if !isHost || orders[indexPath.row].status != "Pending" {
            return []
        }else{
            let accept = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Accept", handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                let alert = UIAlertController(title: "Alert", message: "Are you sure you want to accept this guest?", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(alert) -> Void in
                    changeOrder(self.orders[indexPath.row].id, status: "1")
                    tableView.reloadData()}))
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            })
            let decline = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Decline" , handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                let alert = UIAlertController(title: "Alert", message: "Are you sure you want to decline this guest?", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(alert) -> Void in
                    changeOrder(self.orders[indexPath.row].id, status: "-1")
                    tableView.reloadData()}))
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            })
            accept.backgroundColor = ColorGreen
            decline.backgroundColor = ColorRed
            return [decline,accept]
        }
    }
    func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        if shouldwait {
            self.pleaseWait()
            shouldwait = !shouldwait
        }
        Alamofire.request(.POST, "https://plenry.com/rest/orders", parameters: ["mealId": mealId])
            .responseJSON { _,_,result in
                if result.isFailure {
                    return
                }
                if let temp = result.value as? NSArray {
                    self.orders = getOrder(temp)
                    if self.orders.count == 0 {
                        self.tableView.separatorColor = UIColor.clearColor()
                        let blankPage = self.isHost ? UIImageView(image: UIImage(named: "empty_guestlist_host")) : UIImageView(image: UIImage(named: "empty_guestlist_guest"))
                        blankPage.frame = self.tableView.frame
                        self.tableView.backgroundView = blankPage
                    }else{
                        self.tableView.separatorColor = ColorLightGrey
                    }
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    self.clearAllNotice()
                }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "guestListToReview" {
            let button = sender as! UIButton
            let cell = button.superview?.superview as! Guest
            let indexPath = tableView.indexPathForCell(cell)
            let svc = segue.destinationViewController as! NewReview
            svc.mealId = mealId
            svc.guestId = orders[indexPath!.row].userId
        }
    }
}
