//
//  User.swift
//  Plenry
//
//  Created by NNNO on 6/26/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//
import UIKit
import Foundation

var myDeviceToken:String = ""
struct UserData {
    let firstName:String
    let lastName:String
    var gender:String
    var photo:String
    var id:String
    var memberSince:String
    var description:String
    var school:String
    var work:String
    var language:String
    var guestRate:Float
    var hostRate:Float
    var verifyPhone:Int
    var verifyEmail:Int
    var verifyEdu:Int
    var verifyFB:Int
    var phone:String
    var email:String
    var reviewsCount:Int
    var birthday:String
}

//func census() {
//    let test1 = explorer_All()
//    var allUserId = Set<String>()
//    for temp in test1 {
//        let temp3 = getOrder(temp.id)
//        for temp4 in temp3 {
//            allUserId.insert(temp4.userId)
//            allUserId.insert(temp4.hostId)
//        }
//    }
//    for i in allUserId {
//        let tempUser = profile(i)
//        print(tempUser.firstName+" "+tempUser.lastName+" "+tempUser.email)
//    }
//}
func setUserID(ID:String) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(ID, forKey: "plenryUser")
    defaults.synchronize()
}
func getUserID() -> String {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let userId = defaults.stringForKey("plenryUser")
    {
        return userId
    }else {
        return ""
    }
}
func setSmallImage(statue:Bool) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(statue, forKey: "SmallImage")
    defaults.synchronize()
}
func getSmallImage() -> Bool {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let status = defaults.boolForKey("SmallImage") as Bool? {
        return status
    }else {
        setSmallImage(true)
        return true
    }
}
func addiOSToken(userId:String, deviceToken:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/addiOSToken/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId, "deviceToken":deviceToken], options: [])
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

//func deleteiOSToken(userId:String, deviceToken:String) -> String {
//    var returnValue = ""
//    let urlPath: String = "https://plenry.com/rest/deliOSToken/"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//    request.HTTPMethod = "POST"
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId, "deviceToken":deviceToken], options: [])
//    } catch let error as NSError {
//        _ = error
//        request.HTTPBody = nil
//    }
//    
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

func editProfile(userId:String, gender:String, birthday:String, description:String, school:String, work:String, language:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/editProfile/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId, "gender":gender, "birthday":birthday, "description":description, "school":school, "work":work, "language":language], options: [])
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

func forgotPassword(email:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/forgotpassword/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["email":email], options: [])
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
//            print(temp)
        }
        return returnValue
    }
}

func emailCheck(email:String) -> Bool {
    var returnValue = false
    let urlPath: String = "https://plenry.com/rest/checkEmail/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["email":email], options: [])
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
        if let temp = NSString(data:dataVal!, encoding:NSUTF8StringEncoding) as? String {
//            print(temp)
            if temp.replace("\"", withString: "") == "true" {
                returnValue = true
            }
        }
        return returnValue
    }
    return returnValue
}

func loginCheck(userEmail:String, password:String) -> String {
    var returnValue:String = ""
    let urlPath: String = "https://plenry.com/rest/login/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userEmail":userEmail,"password":password], options: [])
    } catch let error as NSError {
        _ = error
        request.HTTPBody = nil
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
    let requestError: NSErrorPointer = nil
    //    println()
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
func trimVerification(user:UserData) -> String {
    var returnString = ""
    if user.verifyFB == 1 {
        returnString += " · Facebook"
    }
    if user.verifyEmail == 1 {
        returnString += " · Email"
    }
    if user.verifyEdu == 1 {
        returnString += " · Edu"
    }
    if user.verifyPhone == 1 {
        returnString += " · Phone"
    }
    if returnString == "" {
        return "This user has no verification yet"
    }else {
        return returnString+" verified"
    }
}

func emptyUser() -> UserData {
    return UserData(firstName: "", lastName: "", gender: "", photo: "", id: "", memberSince: "", description: "", school: "", work: "", language: "", guestRate: 0.0, hostRate: 0.0, verifyPhone: 0, verifyEmail: 0, verifyEdu: 0, verifyFB: 0, phone: "", email: "", reviewsCount: 0, birthday: "")
}

func profile(userId:String) -> UserData{
    if userId == "" {
        return emptyUser()
    }
    let urlPath: String = "https://plenry.com/rest/me/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId], options: [])
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
    } catch _ as NSError {
//        requestError.memory = error
        dataVal = nil
    }
    if dataVal == nil {
        if requestError != nil {
            
        }
        return emptyUser()
    }else{
//        println(dataVal)
//        var dataDic2 = NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        var dataDic = NSDictionary()
        if let temp = (try? NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary {
            dataDic = temp
        }
//        var dataDic = NSDictionary()
//        if let temp = NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
//            dataDic = temp
//        }
//        var dataDic: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary

//        println(dataDic)
        
        var memberSince = ""
        if let temp = dataDic.valueForKeyPath("createdAt") as? String{
            memberSince = temp
        }
        var id = ""
        if let temp = dataDic.valueForKeyPath("_id") as? String{
            id = temp
        }
        
        var description = ""
        if let temp = dataDic.valueForKeyPath("profile.description") as? String{
            description = temp
        }
        var lastName = ""
        if let temp = dataDic.valueForKeyPath("profile.lastName") as? String{
            lastName = temp
        }
        var school = ""
        if let temp = dataDic.valueForKeyPath("profile.school") as? String{
            school = temp
        }
        var firstName = ""
        if let temp = dataDic.valueForKeyPath("profile.firstName") as? String{
            firstName = temp
        }
        var photo = ""
        if let temp = dataDic.valueForKeyPath("profile.thumbnail.cloudinaryPublicId") as? String{
            photo = temp
        }
        var verifyFB:Int = 0
        if let temp = dataDic.valueForKeyPath("services.facebook.accessToken") as? String{
            if temp.characters.count>0 {
                verifyFB = 1
            }
        }
        var verifyPhone = 0
        if let temp = dataDic.valueForKeyPath("phoneVerification.status") as? Int{
            verifyPhone = temp
        }
        var work = ""
        if let temp = dataDic.valueForKeyPath("profile.work") as? String{
            work = temp
        }
        var language = ""
        if let temp = dataDic.valueForKeyPath("profile.language") as? String{
            language = temp
        }
        var phone = ""
        if let temp = dataDic.valueForKeyPath("profile.phone") as? String{
            phone = temp
        }
        var birthday = ""
        if let temp = dataDic.valueForKeyPath("profile.birthday") as? String{
            birthday = temp
        }
        var email:String = ""
        if let temp = dataDic.valueForKeyPath("emails") as? NSArray{
            if temp.count>0 {
                email = temp[0].valueForKey("address") as! String
            }
        }
        var gender:String = ""
        if let temp = dataDic.valueForKeyPath("profile.gender") as? Int {
            switch temp{
            case 0:gender = "Male"
            case 1:gender = "Female"
            default:gender = "Other"
            }
        }
        var totalRating = 0
        var reviewsCount = 0
        if let temp = dataDic.valueForKeyPath("guest.totalOverallRating") as? Int{
            totalRating = temp
        }
        if let temp = dataDic.valueForKeyPath("guest.reviewsCount") as? Int{
            reviewsCount = temp
        }
        var guestRate:Float = 0.0
        if totalRating != 0 && reviewsCount != 0 {
            guestRate = Float(totalRating/reviewsCount)
        }
        
        
        
        var hostRate = Float(0)
        if let temp = dataDic.valueForKeyPath("host.overallRating") as? Float{
            hostRate = temp
        }
        if let temp = dataDic.valueForKeyPath("host.reviewsCount") as? Int{
            reviewsCount = temp + reviewsCount
        }
//        let hostRate:Float = dataDic.valueForKeyPath("host.overallRating") as! Float
        var verifyEmail:Int = -1
        var verifyEdu:Int = -1
        if let test2:NSArray = dataDic.valueForKeyPath("emails.verified") as? NSArray {
            if test2.count>0 {
                if let temp = test2[0] as? Int{
                    verifyEmail = temp
                }
//                verifyEmail=test2[0] as! Int
                if test2.count>1 {
                    if let temp = test2[1] as? Int{
                        verifyEdu = temp
                    }
//                    verifyEdu=test2[1] as! Int
                }
            }
        }else{
//            println("nothing")
        }
        return UserData(firstName: firstName, lastName: lastName, gender: gender, photo: photo, id: id, memberSince: memberSince, description: description, school: school, work: work, language: language, guestRate: guestRate, hostRate: hostRate, verifyPhone: verifyPhone, verifyEmail: verifyEmail, verifyEdu: verifyEdu, verifyFB: verifyFB, phone: phone, email: email, reviewsCount:reviewsCount, birthday: birthday)
    }
}

//func getHostInfo(userId:String) -> NSArray{
//    var returnData:[String] = []
//    let urlPath: String = "https://plenry.com/rest/me/"
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
//            
//        }
//        return returnData
//    }else{
//        let dataDic: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
//        
//        //    println(dataDic)
//        var firstName = ""
//        var lastName = ""
//        if let temp = dataDic.valueForKeyPath("profile.firstName") as? String {
//            firstName = temp
//        }
//        if let temp = dataDic.valueForKeyPath("profile.lastName") as? String {
//            lastName = temp
//        }
//        var photo = ""
//        if let temp = dataDic.valueForKeyPath("profile.thumbnail.cloudinaryPublicId") as? String {
//            photo = temp
//        }
//        returnData += [firstName+" "+String(lastName[lastName.startIndex])+".",photo]
//        return returnData
//    }
//}
//func me(userId:String) -> [EventData] {
//
//    let data:[EventData] = []
//
//    
//
//    
//
//    let urlPath: String = "https://plenry.com/rest/me"
//
//    let url: NSURL = NSURL(string: urlPath)!
//
//    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
//
//    request.HTTPMethod = "POST"
//
////    var err: NSError?
//
//    do {
//        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId], options: [])
//    } catch let error as NSError {
//        _ = error
//        request.HTTPBody = nil
//    }
//
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
//
////    var error: NSErrorPointer = nil
//
//    let dataVal: NSData =  try! NSURLConnection.sendSynchronousRequest(request, returningResponse: response)

//    var dataArray = NSDictionary()

//    if let temp = (try? NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary {
//        dataArray = temp
//    }
    
//    println(dataArray)
//    println(dataArray.valueForKeyPath("profile.thumbnail.cloudinaryPublicId") as! String)
//    println(dataArray.valueForKeyPath("profile.firstName") as! String)
//    for i in dataArray{
//        //        id,address_city,address,address_state,autoAccept,cloudinary,image,createdAt,hostID,location_lat,location_lng,location_latApprox,location_lngApprox,maxParty,acceptedGuests,totalGuests,placeType,price,spotsLeft,status,summary,time_deadline,time_endAt,time_startAt,time_zone,theme,interaction,note,question
//        var id = i.valueForKeyPath("_id") as! String
//        var address_city:String
//        if i.valueForKeyPath("address.city") is String {
//            address_city = i.valueForKeyPath("address.city") as! String
//        }else{
//            address_city = String("")
//        }
//        var address = i.valueForKeyPath("address.full") as! String
//        var address_state = i.valueForKeyPath("address.full") as! String
//        var cloudinary = i.valueForKeyPath("cover.cloudinaryPublicId") as! String
//        var image = i.valueForKeyPath("cover.org") as! String
//        var createdAt = i.valueForKeyPath("createdAt") as! String
//        var hostID = i.valueForKeyPath("hostId") as! String
//        var location_lat = i.valueForKeyPath("location.lat") as! Float
//        var location_lng = i.valueForKeyPath("location.lng") as! Float
//        var location_latApprox = i.valueForKeyPath("location.latApprox") as! Float
//        var location_lngApprox = i.valueForKeyPath("location.lngApprox") as! Float
//        var maxParty = i.valueForKeyPath("maxParty") as! Int
//        var acceptedGuests = i.valueForKeyPath("numberOfAcceptedGuests") as! Int
//        var totalGuests = i.valueForKeyPath("numberOfGuests") as! Int
//        var placeType = i.valueForKeyPath("placeType") as! Int
//        var price = i.valueForKeyPath("pricePerGuest") as! Int
//        var spotsLeft = i.valueForKeyPath("spotsLeft") as! Int
//        var status = i.valueForKeyPath("status") as! Int
//        var summary = i.valueForKeyPath("summary") as! String
//        var time_deadline = i.valueForKeyPath("time.deadline") as! String
//        var time_endAt:String
//        if i.valueForKey("") is String {
//            time_endAt = i.valueForKeyPath("time.endAt") as! String
//        }else{
//            time_endAt = String("")
//        }
//        var time_startAt = i.valueForKeyPath("time.startAt") as! String
//        //        time_startAt = time_startAt.substringToIndex(count(time_startAt) - 8)
//        time_startAt = time_startAt.substringToIndex(advance(time_startAt.startIndex, 16))
//        time_startAt = time_startAt.replace("T", withString:" ")
//        var time_zone = i.valueForKeyPath("time.zone") as! Int
//        var theme = i.valueForKeyPath("title") as! String
//        var interaction:String
//        if i.valueForKey("interaction") is String{
//            interaction = i.valueForKeyPath("interaction") as! String
//        }else{
//            interaction = String("")
//        }
//        var note:String
//        var question:String
//        if i.valueForKey("note") is String{
//            note = i.valueForKeyPath("note") as! String
//        }else{
//            note = String("")
//        }
//        if i.valueForKey("question") is String{
//            question = i.valueForKeyPath("question") as! String
//        }else{
//            question = String("")
//        }
//        //        let note = i.valueForKeyPath("note") as! String
//        //        let question = i.valueForKeyPath("questionForGuest") as! String
//        var autoAccept:Bool
//        if i.valueForKey("autoAccept") is Bool{
//            autoAccept = i.valueForKeyPath("autoAccept") as! Bool
//        }else{
//            autoAccept = false
//        }
//        //        let autoAccept = i.valueForKeyPath("autoAccept") as! Bool
//        
//        var updatedAt:String
//        if i.valueForKey("updatedAt") is String{
//            updatedAt = i.valueForKeyPath("updatedAt") as! String
//        }else{
//            updatedAt = String("")
//        }
//        if status == 1 {
//            data.append(EventData(id: id, address_city: address_city, address: address, address_state: address_state, autoAccept: autoAccept, cloudinary: cloudinary, image: image, createdAt: createdAt, hostID: hostID, location_lat: location_lat, location_lng: location_lng, location_latApprox: location_latApprox, location_lngApprox: location_lngApprox, maxParty: maxParty, acceptedGuests: acceptedGuests, totalGuests: totalGuests, placeType: placeType, price: price, spotsLeft: spotsLeft, status: status, summary: summary, time_deadline: time_deadline, time_endAt: time_endAt, time_startAt: time_startAt, time_zone: time_zone, theme: theme, interaction: interaction, note: note, question: question, updatedAt: updatedAt))
//        }
//    }
//    return data
//}
//var something = ""
//func loginVerification(userEmail:String, password:String) -> Bool {
////    var request = NSMutableURLRequest(URL: NSURL(string: "https://plenry.com/rest/login")!)
////    var session = NSURLSession.sharedSession()
////    request.HTTPMethod = "POST"
////    var err: NSError?
////    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(["userId":userEmail, "password":password], options: nil, error: &err)
////    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////    request.addValue("application/json", forHTTPHeaderField: "Accept")
////    var returnData = ""
////    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
////        println("Response: \(response)")
////        println("set user id")
//////        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
//////        println("Body: \(strData)")
////        returnData = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
////        if returnData != "error" {
////            println("set user id:"+returnData)
////            setUserID(returnData)
//////            postCompleted(succeeded: true, msg: "Logged in.")
//////            return true
////        }else{
//////            postCompleted(succeeded: false, msg: "Wrong username or password")
//////            return false
////        }
////        //        println(returnData)
////    })
////    task.resume()
//    
////    self.something = "sdaf"
//
//    post(["userId":userEmail, "password":password], "https://plenry.com/rest/login"){ (succeeded: Bool, msg: String) -> () in
//        var alert = UIAlertView(title: "Success!", message: msg, delegate: nil, cancelButtonTitle: "Okay.")
//        if(succeeded) {
//            alert.title = "Success!"
//            alert.message = msg
//        }
//        else {
//            alert.title = "Login failed"
//            alert.message = msg
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                alert.show()
//            })
//        }
//    }
//    return true
//}
//
////func attendingList(userId:String) -> [EventData]{
////    var data:[EventData] = []
////    let urlPath: String = "https://plenry.com/rest/user/events"
////    var url: NSURL = NSURL(string: urlPath)!
//////    var request: NSURLRequest = NSURLRequest(URL: url)
////
////    var request = NSMutableURLRequest(URL: NSURL(string: urlPath)!)
////    var session = NSURLSession.sharedSession()
////    request.HTTPMethod = "POST"
////    var err: NSError?
////    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(["userId":userId], options: nil, error: &err)
////    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////    request.addValue("application/json", forHTTPHeaderField: "Accept")
////    var returnData = ""
////    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//////        println("Response: \(response)")
//////        println("set user id")
////        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
////        println("Body: \(strData)")
////        returnData = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
////        if returnData != "error" {
////            println("set user id"+returnData)
////            setUserID(returnData)
//////            postCompleted(succeeded: true, msg: "Logged in.")
////            return
////        }else{
//////            postCompleted(succeeded: false, msg: "Wrong username or password")
////            return
////        }
////        //        println(returnData)
////    })
////    task.resume()
////    
////    
////    return data
////}
//
//func loginVerification2(userId:String) -> Bool {
//    post2(["userId":userId], "https://plenry.com/rest/user/events"){ (succeeded: Bool, msg: String) -> () in
//        var alert = UIAlertView(title: "Success!", message: msg, delegate: nil, cancelButtonTitle: "Okay.")
//        if(succeeded) {
//            alert.title = "Success!"
//            alert.message = msg
//        }
//        else {
//            alert.title = "Failed : ("
//            alert.message = msg
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                // Show the alert
//                alert.show()
//            })
//        }
//        
//        // Move to the UI thread
//        
//    }
//    
//    return true
//}
//var string = ""
//func post2(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, msg: String) -> ()) {
//    var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//    var session = NSURLSession.sharedSession()
//    request.HTTPMethod = "POST"
//    
//    var err: NSError?
//    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    var returnData = ""
//    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error in
//        if error == nil {
////                    println("Response: \(response)")
////                    println("set user id")
//            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
////                    println("Body: \(strData)")
//            returnData = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
//            var dataVal: NSData = NSData(data: data)
////                    println(returnData)
//            
//            string = strData as! String
////                    var dataArray: NSArray = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSArray
////                    println(dataArray)
//            if returnData != "error" {
//                setUserID(returnData)
//                postCompleted(succeeded: true, msg: "Logged in.")
//                return
//            }else{
//                postCompleted(succeeded: false, msg: "Wrong username or password")
//                return
//            }
////                    println(returnData)
//        }
//        
//        
//        
//        
//
//    })
//    println(string)
////    println(task.description)
////    println(task.response?.MIMEType)
////    string = task.response?.description
//    task.resume()
//
//}
//
//func login(){
////    var url = NSURL(string: "https://plenry.com/rest/user/events")
////    var request = NSMutableURLRequest(URL: url!)
////    request.HTTPMethod = "POST"
////    
////    var dataString = "some data"
////    let data = (anySwiftString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
////    request.HTTPBody = data
////    
////    var connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
////    
////    println("sending request...")
////    
////    connection.start()}
//    let myUrl = NSURL(string: "https://plenry.com/rest/user/events");
//    let request = NSMutableURLRequest(URL:myUrl!);
//    request.HTTPMethod = "POST";
////    println("ss")
//    
//    // Compose a query string
//    let postString = "userId=bXXTJsg4A4y34zSGi";
//    
//    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
//    
//    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//        data, response, error in
//        
//        if error != nil
//        {
//            println("error=\(error)")
//            return
//        }
//        
//        // You can print out response object
//        println("response = \(response)")
//        
//        // Print out response body
//        let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
//        println("responseString = \(responseString)")
//        
//        //Let's convert response sent from a server side script to a NSDictionary object:
//        
//        var err: NSError?
//        var myJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:&err) as? NSDictionary
//        
//        if let parseJSON = myJSON {
//            // Now we can access value of First Name by its key
//            var firstNameValue = parseJSON["firstName"] as? String
//            println("firstNameValue: \(firstNameValue)")
//        }
//        
//    }
//    }
//func post(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, msg: String) -> ()) {
//    var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//    var session = NSURLSession.sharedSession()
//    request.HTTPMethod = "POST"
//    var err: NSError?
//    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    var returnData = ""
//    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//        println("Response: \(response)")
//        println("set user id")
//        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
//        println("Body: \(strData)")
//        returnData = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
//        if returnData != "error" {
//            println("set user id"+returnData)
//            setUserID(returnData)
//            postCompleted(succeeded: true, msg: returnData)
//            return
//        }else{
//            postCompleted(succeeded: false, msg: "Wrong username or password")
//            return
//        }
////        println(returnData)
//    })
//    task.resume()
//}
//func post3(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, msg: String) -> ()) {
//    var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//    var session = NSURLSession.sharedSession()
//    request.HTTPMethod = "POST"
//    
//    var err: NSError?
//    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    
//    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//        println("Response: \(response)")
//        var strData = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
//        println("Body: \(strData)")
//        var err: NSError?
//        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
//        
//        var msg = "No message"
//        
//        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//        if(err != nil) {
//            println(err!.localizedDescription)
//            let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//            println("Error could not parse JSON: '\(jsonStr)'")
//            postCompleted(succeeded: false, msg: "Error")
//        }
//        else {
//            // The JSONObjectWithData constructor didn't return an error. But, we should still
//            // check and make sure that json has a value using optional binding.
//            if let parseJSON = json {
//                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//                if let success = parseJSON["success"] as? Bool {
//                    println("Succes: \(success)")
//                    postCompleted(succeeded: success, msg: "Logged in.")
//                }
//                return
//            }
//            else {
//                // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
//                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                println("Error could not parse JSON: \(jsonStr)")
//                postCompleted(succeeded: false, msg: "Error")
//            }
//        }
//    })
//    
//    task.resume()
//}
//
