//
//  Register.swift
//  Plenry
//
//  Created by NNNO on 7/17/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

func emailRegister(firstName:String, lastName:String, email:String, password:String) -> String {
    var returnValue:String = ""
    let urlPath: String = "https://plenry.com/rest/signup/"
    let url: NSURL = NSURL(string: urlPath)!

    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)

    request.HTTPMethod = "POST"

//    var err: NSError?

    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["email":email,"password":password,"firstName":firstName,"lastName":lastName], options: [])
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

            

        }

    }else{

        if let temp = NSString(data:dataVal!, encoding:NSUTF8StringEncoding) {

            returnValue = temp as String

        }

        return returnValue

    }

    return returnValue

}



func facebookRegister(accessToken:String) -> String {

    var returnValue:String = ""

    let urlPath: String = "https://plenry.com/rest/signup/facebook/"

    let url: NSURL = NSURL(string: urlPath)!

    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)

    request.HTTPMethod = "POST"

//    var err: NSError?

    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["accessToken":accessToken], options: [])
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

            

        }

    }else{

        if let temp = NSString(data:dataVal!, encoding:NSUTF8StringEncoding) {

            returnValue = temp as String
        }
        return returnValue
    }
    return returnValue
}