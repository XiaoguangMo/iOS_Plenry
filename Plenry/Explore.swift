//
//  Explore.swift
//  Plenry
//
//  Created by NNNO on 6/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Explore: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UITextFieldDelegate {
    @IBOutlet var tableView: UITableView!
    var selectedIndex = -1
    @IBOutlet var textField: UITextField!
    var eventData:[EventData] = []
    var filteredData: [EventData] = []
    var selectedEvent = fakeData()
    var shouldwait = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(3) as! UITabBarItem
        tabItem.badgeValue = String(UIApplication.sharedApplication().applicationIconBadgeNumber)
        if tabItem.badgeValue == "0" {
            tabItem.badgeValue = nil
        }
        if getSmallImage() {
            tableView.separatorStyle = .None
        }else{
            tableView.separatorStyle = .SingleLine
        }
        self.textField.frame = CGRectMake(0, 0, ScreenBounds.width, 30)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "titleshadow"), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        reload()
        self.tableView.addPullToRefresh({ [weak self] in
            sleep(1)
            self?.reload()
            })
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:ColorGreen], forState: .Selected)
        tabBarItem.selectedImage = UIImage(named: "magnify_slct.png")!.imageWithRenderingMode(.AlwaysOriginal)
        
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        selectedIndex = -1
        tableView.delegate = self
        tableView.dataSource = self
    }
    func reload() {
        if shouldwait {
            self.pleaseWait()
            shouldwait = !shouldwait
        }
        Alamofire.request(.POST, "https://plenry.com/rest/events/active2", parameters: ["userId": getUserID()])
            .responseJSON { _,_,result in
                if result.isFailure {
//                    print("fail")
                    return
                }
                if let temp = result.value as? NSArray {
                    print(temp)
                    self.eventData = explore_All(temp).sort(){$0.time_startAt < $1.time_startAt}
                    self.filteredData = self.eventData.filter({ (text:EventData) -> Bool in
                        if self.textField.text!.characters.count < 1 {
                            return true
                        }
                        return text.theme.lowercaseString.contains(self.textField.text!.lowercaseString) || text.address_city.lowercaseString.contains(self.textField.text!.lowercaseString)
                    })
                    if self.filteredData.count == 0 {
                        let blankPage = UIImageView(image: UIImage(named: "no_search_result"))
                        blankPage.frame = self.tableView.frame
                        self.tableView.backgroundView = blankPage
                        self.tableView.separatorStyle = .None
                    }else{
                        self.tableView.backgroundView = nil
                        self.tableView.separatorStyle = .SingleLine
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    @IBAction func didTextFieldChanged(sender: AnyObject) {
        filteredData = eventData.filter({ (text:EventData) -> Bool in
            if self.textField.text!.characters.count < 1 {
                return true
            }
            return text.theme.lowercaseString.contains(self.textField.text!.lowercaseString) || text.address_city.lowercaseString.contains(self.textField.text!.lowercaseString)
        })
        tableView.reloadData()
        if filteredData.count == 0 {
            let blankPage = UIImageView(image: UIImage(named: "no_search_result"))
            blankPage.frame = self.tableView.frame
            tableView.backgroundView = blankPage
            tableView.separatorStyle = .None
        }else{
            tableView.backgroundView = nil
            tableView.separatorStyle = .SingleLine
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return !getSmallImage() ? ScreenBounds.width * 180 / 320 : 76
    }
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if !getSmallImage() {
            let cell = tableView.dequeueReusableCellWithIdentifier("Detail", forIndexPath: indexPath) as! Detail
            cell.theme.text = filteredData[indexPath.row].theme
            cell.time.text = getEventTime(filteredData[indexPath.row].time_startAt)
            cell.city.text = filteredData[indexPath.row].address_city
            cell.pic.image = UIImage(named: "picture 320*180")
            cell.pic.getDetailImageFromCloudinary(filteredData[indexPath.row].image)
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("Glance", forIndexPath: indexPath) as! Glance
            cell.theme.text = filteredData[indexPath.row].theme
            cell.time.text = getEventTime(filteredData[indexPath.row].time_startAt)
            cell.city.text = filteredData[indexPath.row].address_city
            cell.pic.getExplorerFromCloudinary(filteredData[indexPath.row].image)
            if(indexPath.row%2==1){
                cell.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.04)
            }else{
                cell.backgroundColor = UIColor.whiteColor()
            }
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        textField.resignFirstResponder()
        if segue.identifier == "showEventDetail" {
            let svc = segue.destinationViewController as! EventDetail
            svc.currentEvent = selectedEvent
            svc.operation = 1
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedEvent = filteredData[indexPath.row]
        return indexPath
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension String {
    func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }
}
