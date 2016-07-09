//
//  Comment.swift
//  Plenry
//
//  Created by NNNO on 7/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

//import Foundation
//struct Comment {
//    let mealId:String
//    let userId:String
//    let content:String
//    let createdAt:String
//}
//
//func getComment(mealId:String) -> [Comment]{
//    
//    var returnData:[Comment] = []
//    let urlPath: String = "https://plenry.com/rest/comments"
//    let url: NSURL = NSURL(string: urlPath)!
//
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//
//    request.HTTPMethod = "POST"
//
////    var err: NSError?
//
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["mealId":mealId], options: [])
//    } catch let error as NSError {
//        _ = error
//        request.HTTPBody = nil
//    }
//
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
//    let dataVal: NSData =  try! NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
//
//    var dataArray: NSArray = []
//
//    if let temp = (try? NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers)) as? NSArray {
//
//        dataArray = temp
//
//    }
//
//    print(dataArray)
//
//    for i in dataArray {
//
//        let mealId = i.valueForKeyPath("mealId") as! String
//
//        let createdAt = i.valueForKeyPath("createdAt") as! String
//
//        let userId = i.valueForKeyPath("userId") as! String
//
//        let content = i.valueForKeyPath("content") as! String
////                println(mealId)
////                println(userId)
////                println(content)
////                println(createdAt)
//        returnData.append(Comment(mealId: mealId, userId: userId, content: content, createdAt: createdAt))
//    }
//    return returnData
//}