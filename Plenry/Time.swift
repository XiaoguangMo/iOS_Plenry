//
//  Time.swift
//  Plenry
//
//  Created by NNNO on 8/8/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

func getTimeZone() -> Int { return NSTimeZone.localTimeZone().secondsFromGMT/3600 }

func getTimeZoneForString() -> String {
    let timezone = NSTimeZone.localTimeZone().secondsFromGMT/3600
    var returnTimezone = ""
    if timezone < 0 {
        if timezone < -9 {
            returnTimezone = String(timezone) + "00"
        }else{
            returnTimezone = "-0" + String(timezone * -1) + "00"
        }
    }else{
        if timezone > 9 {
            returnTimezone = "+" + String(timezone) + "00"
        }else{
            returnTimezone = "+0" + String(timezone) + "00"
        }
    }
    return returnTimezone
}
func isExpire(time:String) -> Bool {
    if time.characters.count < 16 {
        return false
    }
    var temp = time
    let dateFormatter = NSDateFormatter()
    //    var components = NSDateComponents()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    temp = temp.substringToIndex(temp.startIndex.advancedBy(16))
    //    println(temp)
    temp = temp.replace("T", withString:" ")
    var a = NSDate()
    if let temp2 = dateFormatter.dateFromString(temp) {
        a = temp2
    }
    let components = NSDateComponents()
    components.setValue(24 + getTimeZone(), forComponent: NSCalendarUnit.Hour);
    let expireDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: a, options: NSCalendarOptions(rawValue: 0))!
    let timeInterval: Double = NSDate().timeIntervalSinceDate(expireDate)
//    print(NSDate())
//    print(a)
//    print(expireDate)
//    print(time)
//    print(timeInterval)
    if timeInterval < 0 {
        return false
    }else{
        return true
    }
}
func isUpcoming(time:String) -> Bool {
    if time.characters.count < 16 {
        return false
    }
    var temp = time
    let dateFormatter = NSDateFormatter()
    //    var components = NSDateComponents()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    temp = temp.substringToIndex(temp.startIndex.advancedBy(16))
    //    println(temp)
    temp = temp.replace("T", withString:" ")
    var a = NSDate()
    if let temp2 = dateFormatter.dateFromString(temp) {
        a = temp2
    }
    let timeInterval: Double = NSDate().timeIntervalSinceDate(a)
    if timeInterval > 0 {
        return false
    }else{
        return true
    }
}

func getEventTime(eventTime:String) -> String {
    if eventTime.characters.count < 16 {
        return ""
    }
    var temp = eventTime
    let dateFormatter = NSDateFormatter()
    let components = NSDateComponents()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    temp = temp.substringToIndex(temp.startIndex.advancedBy(16))
//    println(temp)
    temp = temp.replace("T", withString:" ")
    var a = NSDate()
    if let temp2 = dateFormatter.dateFromString(temp) {
        a = temp2
    }
    var deadlineDate = NSDate()
    components.setValue(getTimeZone(), forComponent: NSCalendarUnit.Hour);
    deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: a, options: NSCalendarOptions(rawValue: 0))!
    dateFormatter.dateFormat = "eee, MMM d, h:mm a"
    let deadline = dateFormatter.stringFromDate(deadlineDate)
    return deadline
}

func getDetailedEventTime(eventTime:String) -> String {
    if eventTime.characters.count < 16 {
        return ""
    }
    var temp = eventTime
    let dateFormatter = NSDateFormatter()
    let components = NSDateComponents()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    temp = temp.substringToIndex(temp.startIndex.advancedBy(16))
    //    println(temp)
    temp = temp.replace("T", withString:" ")
    var a = NSDate()
    if let temp2 = dateFormatter.dateFromString(temp) {
        a = temp2
    }
    var deadlineDate = NSDate()
    components.setValue(getTimeZone(), forComponent: NSCalendarUnit.Hour);
    deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: a, options: NSCalendarOptions(rawValue: 0))!
    dateFormatter.dateFormat = "eee, MMM d, yyyy, h:mm a"
    let deadline = dateFormatter.stringFromDate(deadlineDate)
    return deadline
}

func getMemberSince(time:String) -> String {
    if time.characters.count < 16 {
        return ""
    }
    var temp = time
    let dateFormatter = NSDateFormatter()
    let components = NSDateComponents()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    temp = temp.substringToIndex(temp.startIndex.advancedBy(16))
    //    println(temp)
    temp = temp.replace("T", withString:" ")
    var a = NSDate()
    if let temp2 = dateFormatter.dateFromString(temp) {
        a = temp2
    }
    var deadlineDate = NSDate()
    components.setValue(getTimeZone(), forComponent: NSCalendarUnit.Hour);
    deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: a, options: NSCalendarOptions(rawValue: 0))!
    dateFormatter.dateFormat = "MMM, yyyy"
    let deadline = dateFormatter.stringFromDate(deadlineDate)
    return deadline
}

func getDateOnly(birthday:String) -> String {
    if birthday.characters.count < 11 {
        return ""
    }
//    println(birthday)
    var temp = birthday
    let dateFormatter = NSDateFormatter()
//    let components = NSDateComponents()
    dateFormatter.dateFormat = "yyyy-MM-dd"
//    dateFormatter.dateStyle = .MediumStyle
//    dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: -3600 * 7)
    temp = temp.substringToIndex(temp.startIndex.advancedBy(10))
//    println(temp)
        temp = temp.replace("T", withString:" ")
    let a:NSDate = dateFormatter.dateFromString(temp)!
    dateFormatter.dateStyle = .MediumStyle
//    var deadlineDate = NSDate()
//    components.setValue(getTimeZone(), forComponent: NSCalendarUnit.CalendarUnitHour);
//    deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: a, options: NSCalendarOptions(0))!
//    var deadline = dateFormatter.stringFromDate(deadlineDate)
    let deadline = dateFormatter.stringFromDate(a)
    return deadline
    
}

//func getMemberShip(memberSince:String) -> String {
////    println(memberSince)
//    if count(memberSince) < 11 {
//        return ""
//    }
//    var temp = memberSince
//    var dateFormatter = NSDateFormatter()
//    var components = NSDateComponents()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    temp = temp.substringToIndex(advance(temp.startIndex, 10))
////    println(temp)
//    temp = temp.replace("T", withString:" ")
//    var a:NSDate = dateFormatter.dateFromString(temp)!
//    var deadlineDate = NSDate()
//    components.setValue(getTimeZone(), forComponent: NSCalendarUnit.CalendarUnitHour);
//    deadlineDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: a, options: NSCalendarOptions(0))!
//    var deadline = dateFormatter.stringFromDate(deadlineDate)
//    return deadline
//
//}

//
//
//
//temp = temp.substringToIndex(advance(temp.startIndex, 16))
//temp = temp.replace("T", withString:" ")