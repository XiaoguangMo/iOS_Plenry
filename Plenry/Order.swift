//
//  Order.swift
//  Plenry
//
//  Created by NNNO on 7/8/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

struct Order {
    let id:String
    let createdAt:String
    let userId:String
    let hostId:String
    let mealEndAt:String
    let mealId:String
    let messageToHost:String
    let respondTime:String
    let status:String
    let numberOfGuests:Int
//payment total
    let donationPerGuest:Int
    let total:Int
    let userFirstName:String
    let userLastName:String
    let userPic:String
    let hostFirstName:String
    let hostLastName:String
    let hostPic:String
    let guestReviewsCount:Int
    let guestTotalOverallRating:Int
    let hostReviewsCount:Int
    let hostOverallRating:Float
    let hostCleanlinessRating:Float
    let guestRate:Float
    let guestEmail:String
    let reviewableToGuest:Int
}

func cancelOrder(userId:String, mealId:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/cancelOrder/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId, "mealId":mealId], options: [])
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

func changeOrder(orderId:String, status:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/changeOrder/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["orderId":orderId, "status":status], options: [])
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

func attendEvent(userId:String, mealId:String, numberOfGuest:String) -> String {
    var returnValue = ""
    let donationPerGuest = 0
    let messageToHost = ""
    let urlPath: String = "https://plenry.com/rest/events/reserve/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId, "mealId":mealId, "numberOfGuest":numberOfGuest, "donationPerGuest":donationPerGuest, "messageToHost":messageToHost], options: [])
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
//        print(returnValue)
        return returnValue
    }
}

func abc(input:[EventData]?){
    if input != nil {
        
    }
}
func getOrder(dataArray:NSArray) -> [Order]{
    var returnData:[Order] = []
//    let urlPath: String = "https://plenry.com/rest/orders"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
////    var err: NSError?
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["mealId":mealId], options: [])
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
        let id = i.valueForKeyPath("_id") as! String
        var respondTime = ""
        if let temp = i.valueForKeyPath("respondTime") as? String{
            respondTime = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String{
            createdAt = temp
        }
        var donationPerGuest = 0
        if let temp = i.valueForKeyPath("donationPerGuest") as? Int{
            donationPerGuest = temp
        }
        var hostId = ""
        if let temp = i.valueForKeyPath("hostId") as? String{
            hostId = temp
        }
        var mealEndAt = ""
        if let temp = i.valueForKeyPath("mealEndAt") as? String{
            mealEndAt = temp
        }
        var mealId = ""
        if let temp = i.valueForKeyPath("mealId") as? String{
            mealId = temp
        }
        var messageToHost = ""
        if let temp = i.valueForKeyPath("messageToHost") as? String{
            messageToHost = temp
        }
        var numberOfGuests = 0
        if let temp = i.valueForKeyPath("numberOfGuests") as? Int{
            numberOfGuests = temp
        }
        var statusBefore = 0
        if let temp = i.valueForKeyPath("status") as? Int{
            statusBefore = temp
        }
        var status = ""
        switch statusBefore{
        case -4:status = "Expired"
        case -3:status = "Event cancelled by host"
        case -2:status = "Cancelled by guest"
        case -1:status = "Declined"
        case 0:status = isExpire(createdAt) ? "Expired" : "Pending"
        case 1:status = "Accepted"
        default:status = "Error, status not found"
        }
        var total = 0
        if let temp = i.valueForKeyPath("total") as? Int{
            total = temp
        }
        var userId = ""
        if let temp = i.valueForKeyPath("userId") as? String{
            userId = temp
        }
        var userFirstName = ""
        if let temp = i.valueForKeyPath("userFirstName") as? String{
            userFirstName = temp
        }
        var userLastName = ""
        if let temp = i.valueForKeyPath("userLastName") as? String{
            userLastName = temp
        }
        var userPic = ""
        if let temp = i.valueForKeyPath("userPic") as? String{
            userPic = temp
        }
        var hostFirstName = ""
        if let temp = i.valueForKeyPath("hostFirstName") as? String{
            hostFirstName = temp
        }
        var hostLastName = ""
        if let temp = i.valueForKeyPath("hostLastName") as? String{
            hostLastName = temp
        }
        var hostPic = ""
        if let temp = i.valueForKeyPath("hostPic") as? String{
            hostPic = temp
        }
        var guestReviewsCount = 0
        if let temp = i.valueForKeyPath("guestReviewsCount") as? Int{
            guestReviewsCount = temp
        }
        var guestTotalOverallRating = 0
        if let temp = i.valueForKeyPath("guestTotalOverallRating") as? Int{
            guestTotalOverallRating = temp
        }
        var hostReviewsCount = 0
        if let temp = i.valueForKeyPath("hostReviewsCount") as? Int{
            hostReviewsCount = temp
        }
        var hostOverallRating = Float(0)
        if let temp = i.valueForKeyPath("hostOverallRating") as? Float{
            hostOverallRating = temp
        }
        var hostCleanlinessRating = Float(0)
        if let temp = i.valueForKeyPath("hostCleanlinessRating") as? Float{
            hostCleanlinessRating = temp
        }
        var guestRate:Float = 0.0
        if guestTotalOverallRating != 0 && guestReviewsCount != 0 {
            guestRate = Float(guestTotalOverallRating/guestReviewsCount)
        }
        var guestEmail:String = ""
        if let temp = i.valueForKeyPath("guestEmail") as? NSArray{
            if temp.count>0 {
                guestEmail = temp[0].valueForKey("address") as! String
            }
        }
        var reviewableToGuest = 0
        if let temp = i.valueForKeyPath("reviewableToGuest") as? Int{
            reviewableToGuest = temp
        }
        returnData.append(Order(id: id, createdAt: createdAt, userId: userId, hostId: hostId, mealEndAt: mealEndAt, mealId: mealId, messageToHost: messageToHost, respondTime: respondTime, status: status, numberOfGuests: numberOfGuests, donationPerGuest: donationPerGuest, total: total, userFirstName: userFirstName, userLastName: userLastName, userPic: userPic, hostFirstName: hostFirstName, hostLastName: hostLastName, hostPic: hostPic, guestReviewsCount: guestReviewsCount, guestTotalOverallRating: guestTotalOverallRating, hostReviewsCount: hostReviewsCount, hostOverallRating: hostOverallRating, hostCleanlinessRating: hostCleanlinessRating, guestRate: guestRate, guestEmail: guestEmail, reviewableToGuest: reviewableToGuest))
    }
    return returnData
}

//func getAttendingStatus(mealId:String) -> String{
//    let returnValue = ""
//    let urlPath: String = "https://plenry.com/rest/orders"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
////    var err: NSError?
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["mealId":mealId], options: [])
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
//    let currentUser = getUserID()
//    for i in dataArray {
//        let statusBefore = i.valueForKeyPath("status") as! Int
//        var status = ""
//        switch statusBefore{
//        case -4:status = "Expired"
//        case -3:status = "Event cancelled by host"
//        case -2:status = "Cancelled by guest"
//        case -1:status = "Declined"
//        case 0:status = "Pending"
//        case 1:status = "Accepted"
//        default:status = "Error, status not found"
//        }
////        var total = i.valueForKeyPath("total") as! Int
//        let userId = i.valueForKeyPath("userId") as! String
//        if userId == currentUser {
//            return status
//        }
//    }
//    return returnValue
//}
//
//
//func getGuestAttendingStatus(mealId:String) -> String{
//    let returnValue = ""
//    let urlPath: String = "https://plenry.com/rest/orders"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
////    var err: NSError?
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["mealId":mealId], options: [])
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
//    let currentUser = getUserID()
//    for i in dataArray {
//        let statusBefore = i.valueForKeyPath("status") as! Int
//        var status = ""
//        switch statusBefore{
//        case -4:status = "Expired"
//        case -3:status = "Event cancelled by host"
//        case -2:status = "Cancelled by guest"
//        case -1:status = "Declined"
//        case 0:status = "Pending"
//        case 1:status = "Accepted"
//        default:status = "Error, status not found"
//        }
////        var total = i.valueForKeyPath("total") as! Int
//        let userId = i.valueForKeyPath("userId") as! String
//        if userId == currentUser {
//            return status
//        }
//    }
//    return returnValue
//}