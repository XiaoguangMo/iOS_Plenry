//
//  Inbox.swift
//  Plenry
//
//  Created by NNNO on 7/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
struct Inbox {
    let id:String
    let toUserId:String
    let userId:String
    let content:String
    let createdAt:String
    let readBy:String
    let fromFirstName:String
    let fromLastName:String
    let fromPicture:String
    let toFirstName:String
    let toLastName:String
    let toPicture:String
}

//func readInbox(friendId:String) -> String {
//    var returnValue = ""
//    let urlPath: String = "https://plenry.com/rest/readBy/"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
////    var err: NSError?
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":getUserID(), "friendId":friendId], options: [])
//    } catch let error as NSError {
//        _ = error
//        request.HTTPBody = nil
//    }
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
//    let requestError: NSErrorPointer = nil
//    var dataVal: NSData?
//    do {
//        dataVal = try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
//    } catch let error as NSError {
//        requestError.memory = error
//        dataVal = nil
//    }
//    if dataVal == nil {
//        if requestError != nil {
//            return requestError.debugDescription
//        }
//        return "return is nil"
//    }else{
//        if let temp = NSString(data:dataVal!, encoding:NSUTF8StringEncoding) as? String {
//            returnValue = temp
//        }
//        return returnValue
//    }
//}

func sendMessages(userId:String, content:String, toUserId:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/inbox/new"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId, "content":content, "toUserId":toUserId], options: [])
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

func getInbox(dataArray:NSArray) -> [Inbox]{
    var returnData:[Inbox] = []
//    let urlPath: String = "https://plenry.com/rest/inbox"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
////    var err: NSError?
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId], options: [])
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
        var id = ""
        if let temp = i.valueForKeyPath("_id") as? String {
            id = temp
        }
        var toUserId = ""
        if let temp = i.valueForKeyPath("toUserId") as? NSArray {
            if temp.count > 0 {
                if let temp2 = temp[0] as? String {
                    toUserId = temp2
                }
            }
        }
//        let toUserId = i.valueForKeyPath("toUserId") as! NSArray
        var userId = ""
        if let temp = i.valueForKeyPath("fromUserId") as? String {
            userId = temp
        }
        var fromFirstName = ""
        if let temp = i.valueForKeyPath("fromFirstName") as? String {
            fromFirstName = temp
        }
        var fromLastName = ""
        if let temp = i.valueForKeyPath("fromLastName") as? String {
            fromLastName = temp
        }
        var fromPicture = ""
        if let temp = i.valueForKeyPath("fromPicture") as? String {
            fromPicture = temp
        }
        var toFirstName = ""
        if let temp = i.valueForKeyPath("toFirstName") as? String {
            toFirstName = temp
        }
        var toLastName = ""
        if let temp = i.valueForKeyPath("toLastName") as? String {
            toLastName = temp
        }
        var toPicture = ""
        if let temp = i.valueForKeyPath("toPicture") as? String {
            toPicture = temp
        }
        let content = i.valueForKeyPath("content") as! String
        let createdAt = i.valueForKeyPath("createdAt") as! String
        var readBy = ""
        if let temp = i.valueForKeyPath("readBy") as? NSArray {
            if temp.count > 0 {
                if let temp2 = temp[0] as? String {
                    readBy = temp2
                }
            }
        }
        returnData.append(Inbox(id: id, toUserId: toUserId, userId: userId, content: content, createdAt:createdAt, readBy: readBy, fromFirstName: fromFirstName, fromLastName: fromLastName, fromPicture: fromPicture, toFirstName: toFirstName, toLastName: toLastName, toPicture: toPicture))
    }
    return returnData
}