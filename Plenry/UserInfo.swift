//
//  UserInfo.swift
//  Plenry
//
//  Created by NNNO on 7/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class UserInfo: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var userId = ""
    var isHost = true
    var userData = emptyUser()
    var reviews:[Review] = []
    var order:Order!
    @IBOutlet var acceptBtn: UIButton!
    @IBOutlet var rejectBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if order != nil {
            if order.status != "Pending" {
                acceptBtn.hidden = true
                rejectBtn.hidden = true
            }else{
                acceptBtn.hidden = false
                rejectBtn.hidden = false
            }
        }
        acceptBtn.backgroundColor = ColorGreen
        rejectBtn.backgroundColor = ColorRed
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        if isHost {
            buttonView.hidden = true
            self.title = "Host Info"
        }else{
            self.title = "Guest Info"
        }
        userData = profile(userId)
        if isHost {
            Alamofire.request(.POST, "https://plenry.com/rest/reviews/guestToMe", parameters: ["userId": userId])
                .responseJSON { _,_,result in
                    if result.isFailure {
                        return
                    }
                    if let temp = result.value as? NSArray {
                        self.reviews += guestToMe(temp)
                        self.tableView.reloadData()
                        self.clearAllNotice()
                    }
            }
        } else {
            Alamofire.request(.POST, "https://plenry.com/rest/reviews/hostToMe", parameters: ["userId": userId])
                .responseJSON { _,_,result in
                    if result.isFailure {
                        return
                    }
                    if let temp = result.value as? NSArray {
                        self.reviews += guestToMe(temp)
                        self.tableView.reloadData()
                        self.clearAllNotice()
                    }
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acceptClicked(sender: AnyObject) {
        let result = changeOrder(order.id, status: "1")
        if result.replace("\"", withString: "") == "true" {
            SweetAlert().showAlert("Sounds Good!", subTitle: "We will send them the event detail.", style: AlertStyle.Success)
            acceptBtn.hidden = true
            rejectBtn.hidden = true
        }else{
            SweetAlert().showAlert("Opps!", subTitle: "Network error.", style: AlertStyle.Error)
        }
    }
    @IBAction func rejectClicked(sender: AnyObject) {
        let result = changeOrder(order.id, status: "-1")
        if result.replace("\"", withString: "") == "true" {
//            SweetAlert().showAlert("Sounds Good!", subTitle: "You have successfully rejected this guest.", style: AlertStyle.Success)
            acceptBtn.hidden = true
            rejectBtn.hidden = true
        }else{
            SweetAlert().showAlert("Opps!", subTitle: "Network error.", style: AlertStyle.Error)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HostInfoPic", forIndexPath: indexPath) as! HostInfoPic
            cell.name.text = userData.firstName
            if userData.memberSince.characters.count > 9 {
                cell.memberSince.text = "Member since " + getMemberSince(userData.memberSince)
            }
            cell.pic.getBigAvatarFromCloudinary(userData.photo)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HostInfoVerify", forIndexPath: indexPath) as! HostInfoVerify
            let data = trimVerification(userData)
            if  data == "This user has no verification yet" {
                cell.verify.textColor = ColorRed
            } else {
                cell.verify.textColor = ColorGreen
            }
            cell.verify.text = data
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HostInfoSummary", forIndexPath: indexPath) as! HostInfoSummary
            cell.title.text = "About Me"
            var summary = userData.description
            if userData.school != "" {
                summary += "\n" + "Eduation: " + userData.school
            }
            if userData.work != "" {
                summary += "\n" + "Work: " + userData.work
            }
            if userData.language != "" {
                summary += "\n" + "Language: " + userData.language
            }
            cell.content.text = summary
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HostInfoRate", forIndexPath: indexPath) as! HostInfoRate
            if isHost {
                cell.count.text = String(userData.reviewsCount) + " reviews from guest   "
            }else{
                cell.count.text = String(userData.reviewsCount) + "         reviews      "
            }
            cell.star.image = getRatingImage(userData.hostRate)
            cell.rate.text = userData.hostRate.description.substringToIndex(userData.hostRate.description.startIndex.advancedBy(3))
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("HostInfoReview", forIndexPath: indexPath) as! HostInfoReview
            if isHost {
                cell.pic.getAvatarFromCloudinary(reviews[indexPath.row - 4].guestPic)
                cell.name.text = reviews[indexPath.row - 4].guestFirstName
            }else{
                cell.pic.getAvatarFromCloudinary(reviews[indexPath.row - 4].hostPic)
                cell.name.text = reviews[indexPath.row - 4].hostFirstName
            }
            cell.content.text = reviews[indexPath.row - 4].content
            cell.date.text = "Written on " + getDateOnly(reviews[indexPath.row - 4].createdAt)
            cell.date.textColor = ColorGrey
            return cell
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 + reviews.count
    }
}
