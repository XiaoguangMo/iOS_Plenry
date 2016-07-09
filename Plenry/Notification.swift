//
//  Notification.swift
//  Plenry
//
//  Created by NNNO on 9/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

struct Notification {
    var id:String
    var type:Int
    var subType:Int
    var createdAt:String
    var hidden:Int
    var mealId:String
    var fromUserId:String
    var toUserId:String
    var content:String
}

func cleariOSToken() -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/cleariOSToken/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    //    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject([], options: [])
    } catch let error as NSError {
        _ = error
        request.HTTPBody = nil
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
    let requestError: NSErrorPointer = nil
    var dataVal: NSData?
    do {
        dataVal = try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
    } catch let error as NSError {
        requestError.memory = error
        dataVal = nil
    }
    if dataVal == nil {
        if requestError != nil {
            return requestError.debugDescription
        }
        return "return is nil"
    }else{
        if let temp = NSString(data:dataVal!, encoding:NSUTF8StringEncoding) as? String {
            returnValue = temp
        }
        print(returnValue)
        return returnValue
    }
}

func readNotification(notificationId:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/notificationRead/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":getUserID(), "notificationId":notificationId], options: [])
    } catch let error as NSError {
        _ = error
        request.HTTPBody = nil
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
    let requestError: NSErrorPointer = nil
    var dataVal: NSData?
    do {
        dataVal = try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
    } catch let error as NSError {
        requestError.memory = error
        dataVal = nil
    }
    if dataVal == nil {
        if requestError != nil {
            return requestError.debugDescription
        }
        return "return is nil"
    }else{
        if let temp = NSString(data:dataVal!, encoding:NSUTF8StringEncoding) as? String {
            returnValue = temp
        }
        return returnValue
    }
}

//If notification is not read, hidden is 0
func getNotification(dataArray:NSArray) -> [Notification] {
//    var countHidden = 0
    var returnData:[Notification] = []
//    let urlPath: String = "https://plenry.com/rest/notifications"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
////    var err: NSError?
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":getUserID()], options: [])
//    } catch let error as NSError {
//        _ = error
//        request.HTTPBody = nil
//    }
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
////    var error: NSErrorPointer = nil
//    let dataVal: NSData =  try! NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
//    var dataArray: NSArray = []
//    if let temp = (try? NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers)) as? NSArray {
//        dataArray = temp
//    }
    //    println(dataArray)
    for i in dataArray {
        
//        var id:String
//        var type:Int
//        var subType:Int
//        var createdAt:String
//        var hidden:Bool
//        var mealId:String
//        var fromUserId:String
//        var toUserId:String

        
        
        var id = ""
        if let temp = i.valueForKeyPath("_id") as? String {
            id = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String {
            createdAt = temp
        }
        var fromUserId = ""
        if let temp = i.valueForKeyPath("fromUserId") as? String {
            fromUserId = temp
        }
        var toUserId = ""
        if let temp = i.valueForKeyPath("toUserId") as? String {
            toUserId = temp
        }
        var type = 0
        if let temp = i.valueForKeyPath("type") as? Int {
            type = temp
        }
        var subType = 0
        if let temp = i.valueForKeyPath("subType") as? Int {
            subType = temp
        }
        var hidden = 0
        if let temp = i.valueForKeyPath("hidden") as? Int {
//            if temp == 0 {
//                countHidden++
//            }
            hidden = temp
        }
        var mealId = ""
        if let temp = i.valueForKeyPath("mealId") as? String {
            mealId = temp
        }
        var content = ""
        if let temp = i.valueForKeyPath("content") as? String {
            content = temp
        }
        returnData.append(Notification(id: id, type:type, subType: subType, createdAt: createdAt, hidden: hidden, mealId: mealId, fromUserId: fromUserId, toUserId: toUserId, content: content))
    }
//    println(countHidden)
    return returnData
}