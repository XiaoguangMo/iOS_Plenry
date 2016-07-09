//
//  NewEventExtend.swift
//  Plenry
//
//  Created by NNNO on 8/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Cloudinary

protocol TwoVCDelegate{
    func didFinishTwoVC(controller:NewEventExtend)
}

class NewEventExtend: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    var delegate:TwoVCDelegate!=nil
    @IBOutlet var tableView: UITableView!
    var whichPickerIsVisible = 1
    var startAtDate = NSDate(timeIntervalSince1970: 0)
    var startAtText = ""
    var endAtDate = NSDate(timeIntervalSince1970: 0)
    var endAtText = ""
    var deadlineDate = NSDate(timeIntervalSince1970: 0)
    var deadlineText = "When do you want to stop accepting requests?"
    var titles = ["until event starts","1 hr before starting time","2 hrs before starting time","5 hrs before starting time","12 hrs before starting time","1 day before starting time","2 days before starting time","3 days before starting time"]
    var pickerRow = 0
//comeFrom: 0:time picker, 1: event detail textView
    var comeFrom = 0
    var summary = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewEventExtend.goBack(_:)))
        self.navigationItem.setLeftBarButtonItem(backItem, animated: false)
        self.tableView.separatorStyle = comeFrom == 1 ? .None : .SingleLine
    }
    func goBack(sender: UIBarButtonItem) {
        delegate.didFinishTwoVC(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if comeFrom == 1 {
            return ScreenBounds.height - 330
        }else{
//            0,1,2,3...-1,0,1,2
            if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 {
                return 65
            }else if indexPath.row == whichPickerIsVisible {
                return 163
            }else{
                return 0
            }
        }
    }
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        let cell = sender.superview?.superview as! NewEventPicker
        let indexPath = tableView.indexPathForCell(cell)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        if indexPath?.row == 1 {
            startAtDate = sender.date
            startAtText = dateFormatter.stringFromDate(sender.date)
            startAtDate = sender.date
            let indexPath = NSIndexPath(forRow:0,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            
//            let dateFormatter = NSDateFormatter()
            let components = NSDateComponents()
//            dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
            if pickerRow != 1 {
                if pickerRow == 0 {
                    deadlineDate = startAtDate
                } else {
                    components.setValue(pickerRow, forComponent: NSCalendarUnit.Hour);
                    deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
                }
                deadlineText = dateFormatter.stringFromDate(deadlineDate)
                print(deadlineText)
                let indexPath1 = NSIndexPath(forRow:4,inSection:0)
                tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            }
//            deadlineDate = startAtDate
//            if row == 0 {
//                deadlineDate = startAtDate
//                pickerRow = 0
//            }else if row == 1 {
//                components.setValue(-1, forComponent: NSCalendarUnit.Hour);
//                deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
//                pickerRow = -1
//            }else if row == 2 {
//                components.setValue(-2, forComponent: NSCalendarUnit.Hour);
//                deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
//                pickerRow = -2
//            }else if row == 3 {
//                components.setValue(-5, forComponent: NSCalendarUnit.Hour);
//                deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
//                pickerRow = -5
//            }else if row == 4 {
//                components.setValue(-12, forComponent: NSCalendarUnit.Hour);
//                deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
//                pickerRow = -12
//            }else if row == 5 {
//                components.setValue(-24, forComponent: NSCalendarUnit.Hour);
//                deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
//                pickerRow = -24
//            }else if row == 6 {
//                components.setValue(-48, forComponent: NSCalendarUnit.Hour);
//                deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
//                pickerRow = -48
//            }else if row == 7 {
//                components.setValue(-72, forComponent: NSCalendarUnit.Hour);
//                deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
//                pickerRow = -72
//            }
//            deadlineText = dateFormatter.stringFromDate(deadlineDate)
//            print(deadlineText)
//            let indexPath1 = NSIndexPath(forRow:4,inSection:0)
//            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
            
            
        }else{
            endAtDate = sender.date
            endAtText = dateFormatter.stringFromDate(sender.date)
            endAtDate = sender.date
            let indexPath = NSIndexPath(forRow:2,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titles.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titles[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dateFormatter = NSDateFormatter()
        let components = NSDateComponents()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        deadlineDate = startAtDate
        if row == 0 {
            deadlineDate = startAtDate
            pickerRow = 0
        }else if row == 1 {
            components.setValue(-1, forComponent: NSCalendarUnit.Hour);
            deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
            pickerRow = -1
        }else if row == 2 {
            components.setValue(-2, forComponent: NSCalendarUnit.Hour);
            deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
            pickerRow = -2
        }else if row == 3 {
            components.setValue(-5, forComponent: NSCalendarUnit.Hour);
            deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
            pickerRow = -5
        }else if row == 4 {
            components.setValue(-12, forComponent: NSCalendarUnit.Hour);
            deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
            pickerRow = -12
        }else if row == 5 {
            components.setValue(-24, forComponent: NSCalendarUnit.Hour);
            deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
            pickerRow = -24
        }else if row == 6 {
            components.setValue(-48, forComponent: NSCalendarUnit.Hour);
            deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
            pickerRow = -48
        }else if row == 7 {
            components.setValue(-72, forComponent: NSCalendarUnit.Hour);
            deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startAtDate, options: NSCalendarOptions(rawValue: 0))!
            pickerRow = -72
        }
        deadlineText = dateFormatter.stringFromDate(deadlineDate)
        print(deadlineText)
        let indexPath1 = NSIndexPath(forRow:4,inSection:0)
        tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .None)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        println(indexPath.row)
//        println(whichPickerIsVisible)
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 {
            if indexPath.row == whichPickerIsVisible - 1 {
                whichPickerIsVisible = -1
            }else{
                whichPickerIsVisible = indexPath.row + 1
            }
            var indexPath1 = NSIndexPath(forRow:1,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .Fade)
            indexPath1 = NSIndexPath(forRow:3,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .Fade)
            indexPath1 = NSIndexPath(forRow:5,inSection:0)
            tableView.reloadRowsAtIndexPaths([indexPath1], withRowAnimation: .Fade)
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if comeFrom == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("NewEventTitle", forIndexPath: indexPath) as! NewEventTitle
                cell.labelLeft.text = "Event start time"
                cell.labelLeft.textColor = ColorGreen
                if startAtDate != NSDate(timeIntervalSince1970: 0) {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
                    startAtText = dateFormatter.stringFromDate(startAtDate)
                }
                cell.labelBottom.text = startAtText
                if startAtText == "" {
                    cell.labelBottom.textColor = ColorGrey
                }else{
                    cell.labelBottom.textColor = UIColor.blackColor()
                }
                return cell
            }else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCellWithIdentifier("NewEventPicker", forIndexPath: indexPath) as! NewEventPicker
                if startAtDate == NSDate(timeIntervalSince1970: 0) {
                    cell.picker.date = NSDate()
                }else{
                    cell.picker.date = startAtDate
                }
                if whichPickerIsVisible != 1 {
                    cell.hidden = true
                }else{
                    cell.hidden = false
                }
                return cell
            }else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCellWithIdentifier("NewEventTitle", forIndexPath: indexPath) as! NewEventTitle
                cell.labelLeft.text = "Event end time (optional)"
                cell.labelLeft.textColor = ColorGreen
                if endAtDate != NSDate(timeIntervalSince1970: 0) {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
                    endAtText = dateFormatter.stringFromDate(endAtDate)
                }
                cell.labelBottom.text = endAtText
                if endAtText == "" {
                    cell.labelBottom.textColor = ColorGrey
                }else{
                    cell.labelBottom.textColor = UIColor.blackColor()
                }
                return cell
            }else if indexPath.row == 3{
                let cell = tableView.dequeueReusableCellWithIdentifier("NewEventPicker", forIndexPath: indexPath) as! NewEventPicker
                if whichPickerIsVisible != 3 {
                    if endAtDate == NSDate(timeIntervalSince1970: 0) {
                        cell.picker.date = NSDate()
                    }else{
                        cell.picker.date = endAtDate
                    }
                    cell.hidden = true
                }else{
                    cell.hidden = false
                }
                return cell
            }else if indexPath.row == 4{
                let cell = tableView.dequeueReusableCellWithIdentifier("NewEventTitle", forIndexPath: indexPath) as! NewEventTitle
                cell.labelLeft.text = "Reservation deadline"
                cell.labelLeft.textColor = ColorGreen
                if deadlineDate != NSDate(timeIntervalSince1970: 0) {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
                    deadlineText = dateFormatter.stringFromDate(deadlineDate)
                    pickerRow = Int(deadlineDate.timeIntervalSinceDate(startAtDate)/3600)
                }
                cell.labelBottom.text = deadlineText
                if deadlineText == "When do you want to stop accepting requests?" {
                    cell.labelBottom.textColor = ColorGrey
                }else{
                    cell.labelBottom.textColor = UIColor.blackColor()
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("NewEventDeadline", forIndexPath: indexPath) as! NewEventDeadline
                cell.picker.delegate = self
                cell.picker.dataSource = self
                cell.hidden = whichPickerIsVisible != 5
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("NewEventDetail", forIndexPath: indexPath) as! NewEventDetail
            cell.textView.text = summary
            cell.textView.becomeFirstResponder()
            return cell
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comeFrom == 0 {
            return 6
        } else {
            return 1
        }
    }
    func textViewDidChange(textView: UITextView) {
        summary = textView.text
    }
}
