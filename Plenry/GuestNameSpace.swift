//
//  GuestName.swift
//  Plenry
//
//  Created by NNNO on 8/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

//from EventDetail
class GuestNameSpace: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    var currentEvent = fakeData()
    @IBOutlet var spotInfo: UIView!
    @IBOutlet var spotLabel: UILabel!
    @IBOutlet var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spotInfo.backgroundColor = ColorLightGrey
        spotLabel.text = String(currentEvent.totalGuests) + " joined, " + String(currentEvent.spotsLeft) + " spots left"
        self.title = currentEvent.theme
        if currentEvent.guestList.count == 0 {
            let blankPage = UIImageView(image: UIImage(named: "empty_guestlist_host"))
            blankPage.frame = self.view.frame
            myCollection.backgroundView = blankPage
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.tabBarController!.view.alpha = 0.5
        let popImage = UIView()
        popImage.frame = CGRectMake(0, 0, ScreenBounds.width, ScreenBounds.height)
        popImage.backgroundColor = UIColor.clearColor()
        let avatar = UIImageView(frame: CGRectMake(0, (ScreenBounds.height - ScreenBounds.width) / 2, ScreenBounds.width, ScreenBounds.width))
        avatar.userInteractionEnabled = false
        avatar.getPreviewAvatarFromCloudinary(currentEvent.guestList[indexPath.row]["guestPic"] as! String)
        popImage.addSubview(avatar)
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        popImage.frame = window.bounds
        window.addSubview(popImage)
        window.bringSubviewToFront(popImage)
        let tap = UITapGestureRecognizer(target: self, action: #selector(GuestNameSpace.handleTap(_:)))
        tap.delegate = self
        popImage.addGestureRecognizer(tap)
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.myCollection.dequeueReusableCellWithReuseIdentifier("GuestCell", forIndexPath: indexPath) as! GuestCell
        cell.pic.getAvatarFromCloudinary(currentEvent.guestList[indexPath.row]["guestPic"] as! String)
        if currentEvent.guestList[indexPath.row]["numberOfGuests"] as? Int == 1 {
            cell.name.text = currentEvent.guestList[indexPath.row]["guestFirstName"] as? String
        }else{
            cell.name.text = (currentEvent.guestList[indexPath.row]["guestFirstName"] as? String)! + " + " + String((currentEvent.guestList[indexPath.row]["numberOfGuests"] as? Int)! - 1)
        }
        cell.pic.layer.cornerRadius = 35
        cell.pic.layer.masksToBounds = true
        cell.pic.layer.borderWidth = 1.0
        cell.pic.layer.borderColor = ColorLightGrey.CGColor
        return cell
    }
    func handleTap(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        self.tabBarController!.view.alpha = 1.0
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentEvent.guestList.count
    }
}