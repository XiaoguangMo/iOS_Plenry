//
//  Review.swift
//  Plenry
//
//  Created by NNNO on 7/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
struct Review {
    let hostId:String
    let mealId:String
    let content:String
    let createdAt:String
    let overallRating:Int
    let privateFeedback:String
    let userId:String
    let userToHost:Int
    let guestFirstName:String
    let guestLastName:String
    let guestPic:String
    let hostFirstName:String
    let hostLastName:String
    let hostPic:String
    let communicationRating:Int
}

//func reviewable(mealId:String, reviewFrom:String, reviewTo:String) -> String {
//    var returnValue = ""
//    let urlPath: String = "https://plenry.com/rest/reviewable/"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
////    var err: NSError?
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["mealId":mealId, "reviewFrom":reviewFrom, "reviewTo":reviewTo], options: [])
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

func newReview(mealId:String, userId:String, guestId:String, content:String, userToHost:String, overallRating:String, communicationRating:String, privateFeedback:String, improvement:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/reviews/new/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["mealId":mealId,"guestId":guestId,"userId":userId,"content":content,"userToHost":userToHost,"overallRating":overallRating,"communicationRating":communicationRating,"privateFeedback":privateFeedback,"improvement":improvement], options: [])
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
    print(dataVal)
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

func getReview(dataArray:NSArray) -> [Review]{
    var returnData:[Review] = []
//    let urlPath: String = "https://plenry.com/rest/reviews"
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
//    //        println(dataArray)
    for i in dataArray {
        let content = i.valueForKeyPath("content") as! String
        let createdAt = i.valueForKeyPath("createdAt") as! String
        let hostId = i.valueForKeyPath("hostId") as! String
        let mealId = i.valueForKeyPath("mealId") as! String
        let overallRating = i.valueForKeyPath("overallRating") as! Int
        let privateFeedback = i.valueForKeyPath("privateFeedback") as! String
        let userId = i.valueForKeyPath("userId") as! String
        let userToHost = i.valueForKeyPath("userToHost") as! Int
        var guestFirstName = ""
        if let temp = i.valueForKeyPath("guestFirstName") as? String {
            guestFirstName = temp
        }
        var guestLastName = ""
        if let temp = i.valueForKeyPath("guestLastName") as? String {
            guestLastName = temp
        }
        var guestPic = ""
        if let temp = i.valueForKeyPath("guestPic") as? String {
            guestPic = temp
        }
        var hostFirstName = ""
        if let temp = i.valueForKeyPath("hostFirstName") as? String {
            hostFirstName = temp
        }
        var hostLastName = ""
        if let temp = i.valueForKeyPath("hostLastName") as? String {
            hostLastName = temp
        }
        var hostPic = ""
        if let temp = i.valueForKeyPath("hostPic") as? String {
            hostPic = temp
        }
        var communicationRating = 0
        if let temp = i.valueForKeyPath("communicationRating") as? Int {
            communicationRating = temp
        }
        //        if toUserId.count>1 {
        //            println(toUserId)
        //        }
        //        println(toUserId)
        //        println(userId)
        //        println(content)
        //        println(createdAt)
        returnData.append(Review(hostId: hostId, mealId: mealId, content: content, createdAt: createdAt, overallRating: overallRating, privateFeedback: privateFeedback, userId: userId, userToHost: userToHost, guestFirstName: guestFirstName, guestLastName: guestLastName,guestPic: guestPic, hostFirstName: hostFirstName, hostLastName: hostLastName, hostPic: hostPic, communicationRating: communicationRating))
    }
    return returnData
}

func meToGuest(dataArray:NSArray) -> [Review]{
    var returnData:[Review] = []
//    let urlPath: String = "https://plenry.com/rest/reviews/meToGuest"
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
//    //    println(dataArray)
    for i in dataArray {
        var content = ""
        if let temp = i.valueForKeyPath("content") as? String {
            content = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String {
            createdAt = temp
        }
        var hostId = ""
        if let temp = i.valueForKeyPath("hostId") as? String {
            hostId = temp
        }
        var mealId = ""
        if let temp = i.valueForKeyPath("mealId") as? String {
            mealId = temp
        }
        var overallRating = 0
        if let temp = i.valueForKeyPath("overallRating") as? Int {
            overallRating = temp
        }
        var privateFeedback = ""
        if let temp = i.valueForKeyPath("privateFeedback") as? String {
            privateFeedback = temp
        }
        var userId = ""
        if let temp = i.valueForKeyPath("userId") as? String {
            userId = temp
        }
        var userToHost = 0
        if let temp = i.valueForKeyPath("userToHost") as? Int {
            userToHost = temp
        }
        var guestFirstName = ""
        if let temp = i.valueForKeyPath("guestFirstName") as? String {
            guestFirstName = temp
        }
        var guestLastName = ""
        if let temp = i.valueForKeyPath("guestLastName") as? String {
            guestLastName = temp
        }
        var guestPic = ""
        if let temp = i.valueForKeyPath("guestPic") as? String {
            guestPic = temp
        }
        var hostFirstName = ""
        if let temp = i.valueForKeyPath("hostFirstName") as? String {
            hostFirstName = temp
        }
        var hostLastName = ""
        if let temp = i.valueForKeyPath("hostLastName") as? String {
            hostLastName = temp
        }
        var hostPic = ""
        if let temp = i.valueForKeyPath("hostPic") as? String {
            hostPic = temp
        }
        var communicationRating = 0
        if let temp = i.valueForKeyPath("communicationRating") as? Int {
            communicationRating = temp
        }
//        var content = i.valueForKeyPath("content") as! String
//        var createdAt = i.valueForKeyPath("createdAt") as! String
//        var hostId = i.valueForKeyPath("hostId") as! String
//        var mealId = i.valueForKeyPath("mealId") as! String
//        var overallRating = i.valueForKeyPath("overallRating") as! Int
//        var privateFeedback = i.valueForKeyPath("privateFeedback") as! String
//        var userId = i.valueForKeyPath("userId") as! String
//        var userToHost = i.valueForKeyPath("userToHost") as! Int

        returnData.append(Review(hostId: hostId, mealId: mealId, content: content, createdAt: createdAt, overallRating: overallRating, privateFeedback: privateFeedback, userId: userId, userToHost: userToHost, guestFirstName: guestFirstName, guestLastName: guestLastName,guestPic: guestPic, hostFirstName: hostFirstName, hostLastName: hostLastName, hostPic: hostPic, communicationRating: communicationRating))
    }
    return returnData
}

func guestToMe(dataArray:NSArray) -> [Review]{
    var returnData:[Review] = []
//    let urlPath: String = "https://plenry.com/rest/reviews/guestToMe"
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
//    //    println(dataArray)
    for i in dataArray {
        var content = ""
        if let temp = i.valueForKeyPath("content") as? String {
            content = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String {
            createdAt = temp
        }
        var hostId = ""
        if let temp = i.valueForKeyPath("hostId") as? String {
            hostId = temp
        }
        var mealId = ""
        if let temp = i.valueForKeyPath("mealId") as? String {
            mealId = temp
        }
        var overallRating = 0
        if let temp = i.valueForKeyPath("overallRating") as? Int {
            overallRating = temp
        }
        var privateFeedback = ""
        if let temp = i.valueForKeyPath("privateFeedback") as? String {
            privateFeedback = temp
        }
        var userId = ""
        if let temp = i.valueForKeyPath("userId") as? String {
            userId = temp
        }
        var userToHost = 0
        if let temp = i.valueForKeyPath("userToHost") as? Int {
            userToHost = temp
        }
        var guestFirstName = ""
        if let temp = i.valueForKeyPath("guestFirstName") as? String {
            guestFirstName = temp
        }
        var guestLastName = ""
        if let temp = i.valueForKeyPath("guestLastName") as? String {
            guestLastName = temp
        }
        var guestPic = ""
        if let temp = i.valueForKeyPath("guestPic") as? String {
            guestPic = temp
        }
        var hostFirstName = ""
        if let temp = i.valueForKeyPath("hostFirstName") as? String {
            hostFirstName = temp
        }
        var hostLastName = ""
        if let temp = i.valueForKeyPath("hostLastName") as? String {
            hostLastName = temp
        }
        var hostPic = ""
        if let temp = i.valueForKeyPath("hostPic") as? String {
            hostPic = temp
        }
        var communicationRating = 0
        if let temp = i.valueForKeyPath("communicationRating") as? Int {
            communicationRating = temp
        }
        
        returnData.append(Review(hostId: hostId, mealId: mealId, content: content, createdAt: createdAt, overallRating: overallRating, privateFeedback: privateFeedback, userId: userId, userToHost: userToHost, guestFirstName: guestFirstName, guestLastName: guestLastName, guestPic: guestPic, hostFirstName: hostFirstName, hostLastName: hostLastName, hostPic: hostPic, communicationRating: communicationRating))
    }
    return returnData
}


func HostToMe(dataArray:NSArray) -> [Review]{
    var returnData:[Review] = []
//    let urlPath: String = "https://plenry.com/rest/reviews/HostToMe"
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
////        println(dataArray)
    for i in dataArray {
        var content = ""
        if let temp = i.valueForKeyPath("content") as? String {
            content = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String {
            createdAt = temp
        }
        var hostId = ""
        if let temp = i.valueForKeyPath("hostId") as? String {
            hostId = temp
        }
        var mealId = ""
        if let temp = i.valueForKeyPath("mealId") as? String {
            mealId = temp
        }
        var overallRating = 0
        if let temp = i.valueForKeyPath("overallRating") as? Int {
            overallRating = temp
        }
        var privateFeedback = ""
        if let temp = i.valueForKeyPath("privateFeedback") as? String {
            privateFeedback = temp
        }
        var userId = ""
        if let temp = i.valueForKeyPath("userId") as? String {
            userId = temp
        }
        var userToHost = 0
        if let temp = i.valueForKeyPath("userToHost") as? Int {
            userToHost = temp
        }
        var guestFirstName = ""
        if let temp = i.valueForKeyPath("guestFirstName") as? String {
            guestFirstName = temp
        }
        var guestLastName = ""
        if let temp = i.valueForKeyPath("guestLastName") as? String {
            guestLastName = temp
        }
        var guestPic = ""
        if let temp = i.valueForKeyPath("guestPic") as? String {
            guestPic = temp
        }
        var hostFirstName = ""
        if let temp = i.valueForKeyPath("hostFirstName") as? String {
            hostFirstName = temp
        }
        var hostLastName = ""
        if let temp = i.valueForKeyPath("hostLastName") as? String {
            hostLastName = temp
        }
        var hostPic = ""
        if let temp = i.valueForKeyPath("hostPic") as? String {
            hostPic = temp
        }
        var communicationRating = 0
        if let temp = i.valueForKeyPath("communicationRating") as? Int {
            communicationRating = temp
        }
        
        returnData.append(Review(hostId: hostId, mealId: mealId, content: content, createdAt: createdAt, overallRating: overallRating, privateFeedback: privateFeedback, userId: userId, userToHost: userToHost, guestFirstName: guestFirstName, guestLastName: guestLastName, guestPic: guestPic, hostFirstName: hostFirstName, hostLastName: hostLastName, hostPic: hostPic, communicationRating: communicationRating))
    }
    return returnData
}

func meToHost(dataArray:NSArray) -> [Review]{
    var returnData:[Review] = []
//    let urlPath: String = "https://plenry.com/rest/reviews/meToHost"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
////    var _: NSError?
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
//        println(dataArray)
    for i in dataArray {
        var content = ""
        if let temp = i.valueForKeyPath("content") as? String {
            content = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String {
            createdAt = temp
        }
        var hostId = ""
        if let temp = i.valueForKeyPath("hostId") as? String {
            hostId = temp
        }
        var mealId = ""
        if let temp = i.valueForKeyPath("mealId") as? String {
            mealId = temp
        }
        var overallRating = 0
        if let temp = i.valueForKeyPath("overallRating") as? Int {
            overallRating = temp
        }
        var privateFeedback = ""
        if let temp = i.valueForKeyPath("privateFeedback") as? String {
            privateFeedback = temp
        }
        var userId = ""
        if let temp = i.valueForKeyPath("userId") as? String {
            userId = temp
        }
        var userToHost = 0
        if let temp = i.valueForKeyPath("userToHost") as? Int {
            userToHost = temp
        }
        var guestFirstName = ""
        if let temp = i.valueForKeyPath("guestFirstName") as? String {
            guestFirstName = temp
        }
        var guestLastName = ""
        if let temp = i.valueForKeyPath("guestLastName") as? String {
            guestLastName = temp
        }
        var guestPic = ""
        if let temp = i.valueForKeyPath("guestPic") as? String {
            guestPic = temp
        }
        var hostFirstName = ""
        if let temp = i.valueForKeyPath("hostFirstName") as? String {
            hostFirstName = temp
        }
        var hostLastName = ""
        if let temp = i.valueForKeyPath("hostLastName") as? String {
            hostLastName = temp
        }
        var hostPic = ""
        if let temp = i.valueForKeyPath("hostPic") as? String {
            hostPic = temp
        }
        var communicationRating = 0
        if let temp = i.valueForKeyPath("communicationRating") as? Int {
            communicationRating = temp
        }
        
        returnData.append(Review(hostId: hostId, mealId: mealId, content: content, createdAt: createdAt, overallRating: overallRating, privateFeedback: privateFeedback, userId: userId, userToHost: userToHost, guestFirstName: guestFirstName, guestLastName: guestLastName, guestPic: guestPic, hostFirstName: hostFirstName, hostLastName: hostLastName, hostPic: hostPic, communicationRating: communicationRating))
    }
    return returnData
}