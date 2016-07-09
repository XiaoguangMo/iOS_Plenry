//
//  Reviews.swift
//  Plenry
//
//  Created by NNNO on 8/7/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Reviews: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var reviewIsFromMe = true
    var reviewsToMe:[Review] = []
    var reviewsFromMe:[Review] = []
    @IBOutlet var tableView: UITableView!
    @IBAction func FromClicked(sender: UIButton) {
        reviewIsFromMe = true
        tableView.reloadData()
    }

    @IBAction func ToClicked(sender: UIButton) {
        reviewIsFromMe = false
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        tableView.backgroundColor = ColorLightGrey
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = ColorLightGrey
        loadData()
        reviewsToMe.sortInPlace(){$0.createdAt > $1.createdAt}
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
                    self.reviewsToMe.sortInPlace(){$0.createdAt > $1.createdAt}
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
                    self.reviewsToMe.sortInPlace(){$0.createdAt > $1.createdAt}
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
                    self.reviewsFromMe.sortInPlace(){$0.createdAt > $1.createdAt}
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
                    self.reviewsFromMe.sortInPlace(){$0.createdAt > $1.createdAt}
                    self.tableView.reloadData()
                    self.clearAllNotice()
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 201
        }else if indexPath.row == 1 {
            return 44
        }else{
            return 100
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ReviewTitle", forIndexPath: indexPath) as! ReviewTitle
            cell.backgroundColor = ColorLightGrey
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ReviewBtn", forIndexPath: indexPath) as! ReviewBtn
            cell.backgroundColor = UIColor.whiteColor()
            if reviewIsFromMe {
                cell.firstBtn.backgroundColor = ColorLightGrey
                cell.secondBtn.backgroundColor = UIColor.whiteColor()
            }else{
                cell.firstBtn.backgroundColor = UIColor.whiteColor()
                cell.secondBtn.backgroundColor = ColorLightGrey
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("ReviewDetail", forIndexPath: indexPath) as! ReviewDetail
            if reviewIsFromMe {
                if reviewsFromMe[indexPath.row - 2].userToHost == 0 {
                    cell.pic.getAvatarFromCloudinary(reviewsFromMe[indexPath.row - 2].guestPic)
                    cell.name.text = reviewsFromMe[indexPath.row - 2].guestFirstName
                }else{
                    cell.pic.getAvatarFromCloudinary(reviewsFromMe[indexPath.row - 2].hostPic)
                    cell.name.text = reviewsFromMe[indexPath.row - 2].hostFirstName
                }
                
                cell.content.text = reviewsFromMe[indexPath.row - 2].content
                cell.date.text = "Written on " + reviewsFromMe[indexPath.row - 2].createdAt.substringToIndex(reviewsFromMe[indexPath.row - 2].createdAt.startIndex.advancedBy(10))
                return cell
            }else{
                if reviewsToMe[indexPath.row - 2].userToHost == 1 {
                    cell.pic.getAvatarFromCloudinary(reviewsToMe[indexPath.row - 2].guestPic)
                    cell.name.text = reviewsToMe[indexPath.row - 2].guestFirstName
                }else{
                    cell.pic.getAvatarFromCloudinary(reviewsToMe[indexPath.row - 2].hostPic)
                    cell.name.text = reviewsToMe[indexPath.row - 2].hostFirstName
                }
                cell.content.text = reviewsToMe[indexPath.row - 2].content
                cell.date.text = "Written on " + reviewsToMe[indexPath.row - 2].createdAt.substringToIndex(reviewsToMe[indexPath.row - 2].createdAt.startIndex.advancedBy(10))
                return cell
            }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + (reviewIsFromMe ? reviewsFromMe.count : reviewsToMe.count)
    }
}