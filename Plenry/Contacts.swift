//
//  Contacts.swift
//  Plenry
//
//  Created by NNNO on 9/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

//import Foundation
//
//struct Contacts {
//    var userId:String
//    var first_name:String
//    var last_name:String
//    var thumbnail:String
//}
//
//func getAllContacts() -> [Contacts] {
//    var returnData:[Contacts] = []
//    let urlPath: String = "https://plenry.com/rest/searchAllContacts"
//    let url: NSURL = NSURL(string: urlPath)!
//
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//
//    request.HTTPMethod = "POST"
//
////    var err: NSError?
//
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":getUserID()], options: [])
//    } catch let error as NSError {
//        _ = error
//        request.HTTPBody = nil
//    }
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
//    let dataVal: NSData =  try! NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
//
//    let dataArray: NSArray = (try! NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers)) as! NSArray
//
//    print(dataArray)
//    for i in dataArray {
//        var userId = ""
//        if let temp = i.valueForKeyPath("userId") as? String {
//            userId = temp
//        }
//        var first_name = ""
//        if let temp = i.valueForKeyPath("first_name") as? String {
//            first_name = temp
//        }
//        var last_name = ""
//        if let temp = i.valueForKeyPath("last_name") as? String {
//            last_name = temp
//        }
//        var thumbnail = ""
//        if let temp = i.valueForKeyPath("thumbnail") as? String {
//            thumbnail = temp
//        }
//        returnData.append(Contacts(userId: userId, first_name:first_name, last_name: last_name, thumbnail: thumbnail))
//    }
//    return returnData
//}