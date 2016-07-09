//
//  GuestName.swift
//  Plenry
//
//  Created by NNNO on 8/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

// from Chatroom
class GuestName: UICollectionViewController {
    var mealId = ""
    var orders:[Order] = []
    var userIsHost = false
    var shouldwait = true
    @IBOutlet var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }
    func reload() {
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
//                    print(temp)
                    self.orders = getOrder(temp).filter(){$0.status == "Accepted"}
                    if self.orders.count == 0 {
                        let blankPage = UIImageView(image: UIImage(named: "empty_guestlist_host"))
                        blankPage.frame = self.view.frame
                        self.myCollection.backgroundView = blankPage
                    }else{
                        self.orders.sortInPlace(){$0.userFirstName < $1.userFirstName}
                    }
                    if self.orders.count > 0 {
                        self.userIsHost = self.orders[0].hostId == getUserID()
//                        if !self.userIsHost {
//                            self.orders = self.orders.filter(){$0.userId != getUserID()}
//                        }
                    }
                    self.myCollection.reloadData()
                    self.clearAllNotice()
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: Messages = storyboard.instantiateViewControllerWithIdentifier("Messages") as! Messages
        if !userIsHost && orders[indexPath.row].userId == getUserID() {
            vc.friendId = orders[indexPath.row].hostId
            vc.friendName = orders[indexPath.row].hostFirstName
        }else{
            vc.friendId = orders[indexPath.row].userId
            vc.friendName = orders[indexPath.row].userFirstName
//            if indexPath.row == 0 {
//                vc.friendId = orders[indexPath.row].hostId
//                vc.friendName = orders[indexPath.row].hostFirstName
//            }else{
//                vc.friendId = orders[indexPath.row - 1].userId
//                vc.friendName = orders[indexPath.row - 1].userFirstName
//            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.myCollection.dequeueReusableCellWithReuseIdentifier("GuestCell", forIndexPath: indexPath) as! GuestCell
        if !userIsHost && orders[indexPath.row].userId == getUserID() {
            cell.pic.getAvatarFromCloudinary(orders[indexPath.row].hostPic)
            cell.name.text = orders[indexPath.row].hostFirstName
        }else{
            cell.pic.getAvatarFromCloudinary(orders[indexPath.row].userPic)
            cell.name.text = orders[indexPath.row].userFirstName
//            if indexPath.row == 0 {
//                cell.pic.getAvatarFromCloudinary(orders[indexPath.row].hostPic)
//                cell.name.text = orders[indexPath.row].hostFirstName
//            }else{
//                cell.pic.getAvatarFromCloudinary(orders[indexPath.row - 1].userPic)
//                cell.name.text = orders[indexPath.row - 1].userFirstName
//            }
        }
        cell.pic.layer.cornerRadius = 35
        cell.pic.layer.masksToBounds = true
        cell.pic.layer.borderWidth = 1.0
        cell.pic.layer.borderColor = ColorLightGrey.CGColor
        return cell
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
}