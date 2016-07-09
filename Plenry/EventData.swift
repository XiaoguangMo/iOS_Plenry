//
//  EventData.swift
//  Plenry
//
//  Created by NNNO on 6/26/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
//autoAccept,title,summary,pricePerGuest,maxParty,startAt,endAt,deadline,placeType,interaction,note,questionForGuest,addressuserId,cover
//?cloudinary, address
struct EventData {
    let id:String
    let address_city:String
    let address:String
    let address_state:String
    let autoAccept:Bool
    let cloudinary:String
    let image:String
    let createdAt:String
    let hostID:String
    let location_lat:Float
    let location_lng:Float
    let location_latApprox:Float
    let location_lngApprox:Float
    let maxParty:Int
    let acceptedGuests:Int
    let totalGuests:Int
    let placeType:Int
    let price:Int
    let spotsLeft:Int
    let status:Int
    let summary:String
    let time_deadline:String
    let time_endAt:String
    let time_startAt:String
    let time_zone:Int
    let theme:String
    let interaction:String
    let note:String
    let question:String
    let updatedAt:String
    let hostFirstName:String
    let hostLastName:String
    let hostPic:String
    let reviewable:Int
    let orderStatus:String
    let hostOverallRating:Float
    let guestList:NSArray
    let hostReviewsCount:Int
}

// charlie Bhs2LfFWiTZbQgdi7
// momo AzjGMQ3vAo4K9gKm4
// mo bXXTJsg4A4y34zSGi

func editEvent(mealId:String, autoAccept:String, title:String, summary:String, pricePerGuest:String, maxParty:String, startAt:String, endAt:String, deadline:String, placeType:String, cloudinaryPublicId:String, interaction:String, note:String, questionForGuest:String, address:String, userId:String) -> String {
    var returnValue = ""
    let urlPath: String = "https://plenry.com/rest/editEvent/"
    let url: NSURL = NSURL(string: urlPath)!

    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)

    request.HTTPMethod = "POST"

//    var err: NSError?

    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["mealId":mealId, "autoAccept":autoAccept, "title":title, "summary":summary, "pricePerGuest":pricePerGuest, "maxParty":maxParty, "startAt":startAt.replace(" ", withString: "T"), "endAt":endAt.replace(" ", withString: "T"), "deadline":deadline.replace(" ", withString: "T"), "placeType":placeType, "cloudinaryPublicId":cloudinaryPublicId, "interaction":interaction, "note":note, "questionForGuest":questionForGuest, "address":address, "userId":userId], options: [])
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



func checkAddress(address:String) -> String {

    var returnValue = ""

    let urlPath: String = "https://plenry.com/rest/checkAddress/"

    let url: NSURL = NSURL(string: urlPath)!

    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)

    request.HTTPMethod = "POST"

//    var err: NSError?

    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["address":address], options: [])
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



func createEvent(userId:String, autoAccept:String, title:String, summary:String, pricePerGuest:String, maxParty:String, startAt:String, deadline:String, placeType:String, cloudinaryPublicId:String, address:String, endAt:String, interaction:String, note:String, questionForGuest:String) -> String {

    var returnValue = ""

    let urlPath: String = "https://plenry.com/rest/events/new/"

    let url: NSURL = NSURL(string: urlPath)!

    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)

    request.HTTPMethod = "POST"

//    var err: NSError?

    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId, "autoAccept":autoAccept, "title":title, "summary":summary, "pricePerGuest":pricePerGuest, "maxParty":maxParty, "startAt":startAt, "deadline":deadline, "placeType":placeType, "cloudinaryPublicId":cloudinaryPublicId, "address":address, "endAt":endAt, "interaction":interaction, "note":note, "questionForGuest":questionForGuest], options: [])
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





func hostingList(dataArray:NSArray) -> [EventData] {
    var data:[EventData] = []
    for i in dataArray{
        //        id,address_city,address,address_state,autoAccept,cloudinary,image,createdAt,hostID,location_lat,location_lng,location_latApprox,location_lngApprox,maxParty,acceptedGuests,totalGuests,placeType,price,spotsLeft,status,summary,time_deadline,time_endAt,time_startAt,time_zone,theme,interaction,note,question
        var id = ""
        if let temp = i.valueForKeyPath("_id") as? String {
            id = temp
        }
        var address_city = ""
        if let temp = i.valueForKeyPath("address.city") as? String {
            address_city = temp
        }
        var address = ""
        if let temp = i.valueForKeyPath("address.full") as? String {
            address = temp
        }
        var address_state = ""
        if let temp = i.valueForKeyPath("address.state") as? String {
            address_state = temp
        }
        var cloudinary = ""
        if let temp = i.valueForKeyPath("cover.cloudinaryPublicId") as? String {
            cloudinary = temp
        }
        var image = ""
        if let temp = i.valueForKeyPath("cover.cloudinaryPublicId") as? String {
            image = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String {
            createdAt = temp
        }
        var hostID = ""
        if let temp = i.valueForKeyPath("hostId") as? String {
            hostID = temp
        }
        var location_lat = Float(0)
        if let temp = i.valueForKeyPath("location.lat") as? Float {
            location_lat = temp
        }
        var location_lng = Float(0)
        if let temp = i.valueForKeyPath("location.lng") as? Float {
            location_lng = temp
        }
        var location_latApprox = Float(0)
        if let temp = i.valueForKeyPath("location.latApprox") as? Float {
            location_latApprox = temp
        }
        var location_lngApprox = Float(0)
        if let temp = i.valueForKeyPath("location.lngApprox") as? Float {
            location_lngApprox = temp
        }
        var maxParty = 0
        if let temp = i.valueForKeyPath("maxParty") as? Int {
            maxParty = temp
        }
        var acceptedGuests = 0
        if let temp = i.valueForKeyPath("numberOfAcceptedGuests") as? Int {
            acceptedGuests = temp
        }
        var totalGuests = 0
        if let temp = i.valueForKeyPath("numberOfGuests") as? Int {
            totalGuests = temp
        }
        var placeType = 0
        if let temp = i.valueForKeyPath("placeType") as? Int {
            placeType = temp
        }
        var price = 0
        if let temp = i.valueForKeyPath("pricePerGuest") as? Int {
            price = temp
        }
        var spotsLeft = 0
        if let temp = i.valueForKeyPath("spotsLeft") as? Int {
            spotsLeft = temp
        }
        var status = 0
        if let temp = i.valueForKeyPath("status") as? Int {
            status = temp
        }
        var summary = ""
        if let temp = i.valueForKeyPath("summary") as? String {
            summary = temp
        }
        var time_deadline = ""
        if let temp = i.valueForKeyPath("time.deadline") as? String {
            time_deadline = temp
        }
        var time_endAt = ""
        if let temp = i.valueForKeyPath("time.endAt") as? String {
            time_endAt = temp
        }
        var time_startAt = ""
        if let temp = i.valueForKeyPath("time.startAt") as? String {
            time_startAt = temp
        }
        var time_zone = 0
        if let temp = i.valueForKeyPath("time.zone") as? Int {
            time_zone = temp
        }
        var theme = ""
        if let temp = i.valueForKeyPath("title") as? String {
            theme = temp
        }
        let interaction = ""
        if let temp = i.valueForKeyPath("interaction") as? String {
            id = temp
        }
        var note = ""
        if let temp = i.valueForKeyPath("note") as? String {
            note = temp
        }
        var question = ""
        if let temp = i.valueForKeyPath("question") as? String {
            question = temp
        }
        var autoAccept = false
        if let temp = i.valueForKeyPath("autoAccept") as? Bool {
            autoAccept = temp
        }
        var updatedAt = ""
        if let temp = i.valueForKeyPath("updatedAt") as? String {
            updatedAt = temp
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
        var reviewable = 0
        if let temp = i.valueForKeyPath("reviewable") as? Int {
            reviewable = temp
        }
        var statusBefore = -5
        if let temp = i.valueForKeyPath("orderStatus") as? Int {
            statusBefore = temp
        }
        var orderStatus = ""
        switch statusBefore{
        case -4:orderStatus = "Expired"
        case -3:orderStatus = "Event cancelled by host"
        case -2:orderStatus = "Cancelled by guest"
        case -1:orderStatus = "Declined"
        case 0:orderStatus = "Pending"
        case 1:orderStatus = "Accepted"
        default:orderStatus = "Error, status not found"
        }
        var hostOverallRating = Float(0)
        if let temp = i.valueForKeyPath("hostOverallRating") as? Float {
            hostOverallRating = temp
        }
        var guestList = []
        if let temp = i.valueForKeyPath("guestList") as? NSArray {
            guestList = temp
        }
        var hostReviewsCount = 0
        if let temp = i.valueForKeyPath("hostReviewsCount") as? Int {
            hostReviewsCount = temp
        }
        if status == 1 {
            data.append(EventData(id: id, address_city: address_city, address: address, address_state: address_state, autoAccept: autoAccept, cloudinary: cloudinary, image: image, createdAt: createdAt, hostID: hostID, location_lat: location_lat, location_lng: location_lng, location_latApprox: location_latApprox, location_lngApprox: location_lngApprox, maxParty: maxParty, acceptedGuests: acceptedGuests, totalGuests: totalGuests, placeType: placeType, price: price, spotsLeft: spotsLeft, status: status, summary: summary, time_deadline: time_deadline, time_endAt: time_endAt, time_startAt: time_startAt, time_zone: time_zone, theme: theme, interaction: interaction, note: note, question: question, updatedAt: updatedAt, hostFirstName:hostFirstName, hostLastName: hostLastName, hostPic: hostPic, reviewable: reviewable, orderStatus: orderStatus, hostOverallRating: hostOverallRating, guestList: guestList, hostReviewsCount: hostReviewsCount))
        }
    }
    return data
}



func attendingList(dataArray:NSArray) -> [EventData] {
    var data:[EventData] = []
    for i in dataArray{
        //        id,address_city,address,address_state,autoAccept,cloudinary,image,createdAt,hostID,location_lat,location_lng,location_latApprox,location_lngApprox,maxParty,acceptedGuests,totalGuests,placeType,price,spotsLeft,status,summary,time_deadline,time_endAt,time_startAt,time_zone,theme,interaction,note,question
        var id = ""
        if let temp = i.valueForKeyPath("_id") as? String {
            id = temp
        }
        var address_city = ""
        if let temp = i.valueForKeyPath("address.city") as? String {
            address_city = temp
        }
        var address = ""
        if let temp = i.valueForKeyPath("address.full") as? String {
            address = temp
        }
        var address_state = ""
        if let temp = i.valueForKeyPath("address.state") as? String {
            address_state = temp
        }
        var cloudinary = ""
        if let temp = i.valueForKeyPath("cover.cloudinaryPublicId") as? String {
            cloudinary = temp
        }
        var image = ""
        if let temp = i.valueForKeyPath("cover.cloudinaryPublicId") as? String {
            image = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String {
            createdAt = temp
        }
        var hostID = ""
        if let temp = i.valueForKeyPath("hostId") as? String {
            hostID = temp
        }
        var location_lat = Float(0)
        if let temp = i.valueForKeyPath("location.lat") as? Float {
            location_lat = temp
        }
        var location_lng = Float(0)
        if let temp = i.valueForKeyPath("location.lng") as? Float {
            location_lng = temp
        }
        var location_latApprox = Float(0)
        if let temp = i.valueForKeyPath("location.latApprox") as? Float {
            location_latApprox = temp
        }
        var location_lngApprox = Float(0)
        if let temp = i.valueForKeyPath("location.lngApprox") as? Float {
            location_lngApprox = temp
        }
        var maxParty = 0
        if let temp = i.valueForKeyPath("maxParty") as? Int {
            maxParty = temp
        }
        var acceptedGuests = 0
        if let temp = i.valueForKeyPath("numberOfAcceptedGuests") as? Int {
            acceptedGuests = temp
        }
        var totalGuests = 0
        if let temp = i.valueForKeyPath("numberOfGuests") as? Int {
            totalGuests = temp
        }
        var placeType = 0
        if let temp = i.valueForKeyPath("placeType") as? Int {
            placeType = temp
        }
        var price = 0
        if let temp = i.valueForKeyPath("pricePerGuest") as? Int {
            price = temp
        }
        var spotsLeft = 0
        if let temp = i.valueForKeyPath("spotsLeft") as? Int {
            spotsLeft = temp
        }
        var status = 0
        if let temp = i.valueForKeyPath("status") as? Int {
            status = temp
        }
        var summary = ""
        if let temp = i.valueForKeyPath("summary") as? String {
            summary = temp
        }
        var time_deadline = ""
        if let temp = i.valueForKeyPath("time.deadline") as? String {
            time_deadline = temp
        }
        var time_endAt = ""
        if let temp = i.valueForKeyPath("time.endAt") as? String {
            time_endAt = temp
        }
        var time_startAt = ""
        if let temp = i.valueForKeyPath("time.startAt") as? String {
            time_startAt = temp
        }
        var time_zone = 0
        if let temp = i.valueForKeyPath("time.zone") as? Int {
            time_zone = temp
        }
        var theme = ""
        if let temp = i.valueForKeyPath("title") as? String {
            theme = temp
        }
        let interaction = ""
        if let temp = i.valueForKeyPath("interaction") as? String {
            id = temp
        }
        var note = ""
        if let temp = i.valueForKeyPath("note") as? String {
            note = temp
        }
        var question = ""
        if let temp = i.valueForKeyPath("question") as? String {
            question = temp
        }
        var autoAccept = false
        if let temp = i.valueForKeyPath("autoAccept") as? Bool {
            autoAccept = temp
        }
        var updatedAt = ""
        if let temp = i.valueForKeyPath("updatedAt") as? String {
            updatedAt = temp
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
        var reviewable = 0
        if let temp = i.valueForKeyPath("reviewable") as? Int {
            reviewable = temp
        }
        var statusBefore = -5
        if let temp = i.valueForKeyPath("orderStatus") as? Int {
            statusBefore = temp
        }
        var orderStatus = ""
        switch statusBefore{
        case -4:orderStatus = "Expired"
        case -3:orderStatus = "Event cancelled by host"
        case -2:orderStatus = "Cancelled by guest"
        case -1:orderStatus = "Declined"
        case 0:orderStatus = "Pending"
        case 1:orderStatus = "Accepted"
        default:orderStatus = "Error, status not found"
        }
        var hostOverallRating = Float(0)
        if let temp = i.valueForKeyPath("hostOverallRating") as? Float {
            hostOverallRating = temp
        }
        var guestList = []
        if let temp = i.valueForKeyPath("guestList") as? NSArray {
            guestList = temp
        }
        var hostReviewsCount = 0
        if let temp = i.valueForKeyPath("hostReviewsCount") as? Int {
            hostReviewsCount = temp
        }
        if status == 1 && orderStatus != "Cancelled by guest" {
            data.append(EventData(id: id, address_city: address_city, address: address, address_state: address_state, autoAccept: autoAccept, cloudinary: cloudinary, image: image, createdAt: createdAt, hostID: hostID, location_lat: location_lat, location_lng: location_lng, location_latApprox: location_latApprox, location_lngApprox: location_lngApprox, maxParty: maxParty, acceptedGuests: acceptedGuests, totalGuests: totalGuests, placeType: placeType, price: price, spotsLeft: spotsLeft, status: status, summary: summary, time_deadline: time_deadline, time_endAt: time_endAt, time_startAt: time_startAt, time_zone: time_zone, theme: theme, interaction: interaction, note: note, question: question, updatedAt: updatedAt, hostFirstName:hostFirstName, hostLastName: hostLastName, hostPic: hostPic, reviewable: reviewable, orderStatus: orderStatus, hostOverallRating: hostOverallRating, guestList: guestList, hostReviewsCount: hostReviewsCount))
        }
    }
    return data
}
func loginVerify(userEmail:String, password:String) -> String{
//    var data:[EventData] = []
    let urlPath: String = "https://plenry.com/rest/login"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userEmail":userEmail, "password":password], options: [])
    } catch let error as NSError {
        _ = error
        request.HTTPBody = nil
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
//    var error: NSErrorPointer = nil
    let dataVal: NSData =  try! NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
    let returnData = NSString(data: dataVal, encoding: NSUTF8StringEncoding) as! String
//    println(returnData)
    setUserID(returnData.replace("\"", withString: ""))
    return getUserID()
}
func explore_All(input:NSArray) -> [EventData] {
    var data:[EventData] = []
    for i in input{
        //        id,address_city,address,address_state,autoAccept,cloudinary,image,createdAt,hostID,location_lat,location_lng,location_latApprox,location_lngApprox,maxParty,acceptedGuests,totalGuests,placeType,price,spotsLeft,status,summary,time_deadline,time_endAt,time_startAt,time_zone,theme,interaction,note,question
        var id = ""
        if let temp = i.valueForKeyPath("_id") as? String {
            id = temp
        }
//        print(id)
        var address_city = ""
        if let temp = i.valueForKeyPath("address.city") as? String {
            address_city = temp
        }
        var address = ""
        if let temp = i.valueForKeyPath("address.full") as? String {
            address = temp
        }
        var address_state = ""
        if let temp = i.valueForKeyPath("address.state") as? String {
            address_state = temp
        }
        var cloudinary = ""
        if let temp = i.valueForKeyPath("cover.cloudinaryPublicId") as? String {
            cloudinary = temp
        }
        var image = ""
        if let temp = i.valueForKeyPath("cover.cloudinaryPublicId") as? String {
            image = temp
        }
        var createdAt = ""
        if let temp = i.valueForKeyPath("createdAt") as? String {
            createdAt = temp
        }
        var hostID = ""
        if let temp = i.valueForKeyPath("hostId") as? String {
            hostID = temp
        }
        var location_lat = Float(0)
        if let temp = i.valueForKeyPath("location.lat") as? Float {
            location_lat = temp
        }
        var location_lng = Float(0)
        if let temp = i.valueForKeyPath("location.lng") as? Float {
            location_lng = temp
        }
        var location_latApprox = Float(0)
        if let temp = i.valueForKeyPath("location.latApprox") as? Float {
            location_latApprox = temp
        }
        var location_lngApprox = Float(0)
        if let temp = i.valueForKeyPath("location.lngApprox") as? Float {
            location_lngApprox = temp
        }
        var maxParty = 0
        if let temp = i.valueForKeyPath("maxParty") as? Int {
            maxParty = temp
        }
        var acceptedGuests = 0
        if let temp = i.valueForKeyPath("numberOfAcceptedGuests") as? Int {
            acceptedGuests = temp
        }
        var totalGuests = 0
        if let temp = i.valueForKeyPath("numberOfGuests") as? Int {
            totalGuests = temp
        }
        var placeType = 0
        if let temp = i.valueForKeyPath("placeType") as? Int {
            placeType = temp
        }
        var price = 0
        if let temp = i.valueForKeyPath("pricePerGuest") as? Int {
            price = temp
        }
        var spotsLeft = 0
        if let temp = i.valueForKeyPath("spotsLeft") as? Int {
            spotsLeft = temp
        }
        var status = 0
        if let temp = i.valueForKeyPath("status") as? Int {
            status = temp
        }
        var summary = ""
        if let temp = i.valueForKeyPath("summary") as? String {
            summary = temp
        }
        var time_deadline = ""
        if let temp = i.valueForKeyPath("time.deadline") as? String {
            time_deadline = temp
        }
        var time_endAt = ""
        if let temp = i.valueForKeyPath("time.endAt") as? String {
            time_endAt = temp
        }
        var time_startAt = ""
        if let temp = i.valueForKeyPath("time.startAt") as? String {
            time_startAt = temp
        }
        var time_zone = 0
        if let temp = i.valueForKeyPath("time.zone") as? Int {
            time_zone = temp
        }
        var theme = ""
        if let temp = i.valueForKeyPath("title") as? String {
            theme = temp
        }
        let interaction = ""
        if let temp = i.valueForKeyPath("interaction") as? String {
            id = temp
        }
        var note = ""
        if let temp = i.valueForKeyPath("note") as? String {
            note = temp
        }
        var question = ""
        if let temp = i.valueForKeyPath("question") as? String {
            question = temp
        }
        var autoAccept = false
        if let temp = i.valueForKeyPath("autoAccept") as? Bool {
            autoAccept = temp
        }
        var updatedAt = ""
        if let temp = i.valueForKeyPath("updatedAt") as? String {
            updatedAt = temp
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
        var reviewable = 0
        if let temp = i.valueForKeyPath("reviewable") as? Int {
            reviewable = temp
        }
        var statusBefore = -5
        if let temp = i.valueForKeyPath("orderStatus") as? Int {
            statusBefore = temp
        }
        var orderStatus = ""
        switch statusBefore{
        case -4:orderStatus = "Expired"
        case -3:orderStatus = "Event cancelled by host"
        case -2:orderStatus = "Cancelled by guest"
        case -1:orderStatus = "Declined"
        case 0:orderStatus = "Pending"
        case 1:orderStatus = "Accepted"
        default:orderStatus = "Error, status not found"
        }
        var hostOverallRating = Float(0)
        if let temp = i.valueForKeyPath("hostOverallRating") as? Float {
            hostOverallRating = temp
        }
        var guestList = []
        if let temp = i.valueForKeyPath("guestList") as? NSArray {
            guestList = temp
        }
        var hostReviewsCount = 0
        if let temp = i.valueForKeyPath("hostReviewsCount") as? Int {
            hostReviewsCount = temp
        }
        if status == 1 {
            data.append(EventData(id: id, address_city: address_city, address: address, address_state: address_state, autoAccept: autoAccept, cloudinary: cloudinary, image: image, createdAt: createdAt, hostID: hostID, location_lat: location_lat, location_lng: location_lng, location_latApprox: location_latApprox, location_lngApprox: location_lngApprox, maxParty: maxParty, acceptedGuests: acceptedGuests, totalGuests: totalGuests, placeType: placeType, price: price, spotsLeft: spotsLeft, status: status, summary: summary, time_deadline: time_deadline, time_endAt: time_endAt, time_startAt: time_startAt, time_zone: time_zone, theme: theme, interaction: interaction, note: note, question: question, updatedAt: updatedAt, hostFirstName:hostFirstName, hostLastName: hostLastName, hostPic: hostPic, reviewable: reviewable, orderStatus: orderStatus, hostOverallRating: hostOverallRating, guestList: guestList, hostReviewsCount: hostReviewsCount))
        }
    }
    return data
}
//func explorer_All() -> [EventData]{
//    var data:[EventData] = []
//
////    let urlPath: String = "https://plenry.com/rest/events/"
//    let urlPath: String = "https://plenry.com/rest/events/active"
//    let url: NSURL = NSURL(string: urlPath)!
//    let request: NSURLRequest = NSURLRequest(URL: url)
////    request.HTTPMethod =
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
//        return [fakeData()]
//    }else{
//        let dataArray: NSArray = (try! NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers)) as! NSArray
////        println(dataArray)
//        for i in dataArray{
//            //        id,address_city,address,address_state,autoAccept,cloudinary,image,createdAt,hostID,location_lat,location_lng,location_latApprox,location_lngApprox,maxParty,acceptedGuests,totalGuests,placeType,price,spotsLeft,status,summary,time_deadline,time_endAt,time_startAt,time_zone,theme,interaction,note,question
//            var id = ""
//            if let temp = i.valueForKeyPath("_id") as? String {
//                id = temp
//            }
//            var address_city = ""
//            if let temp = i.valueForKeyPath("address.city") as? String {
//                address_city = temp
//            }
//            var address = ""
//            if let temp = i.valueForKeyPath("address.full") as? String {
//                address = temp
//            }
//            var address_state = ""
//            if let temp = i.valueForKeyPath("address.state") as? String {
//                address_state = temp
//            }
//            var cloudinary = ""
//            if let temp = i.valueForKeyPath("cover.cloudinaryPublicId") as? String {
//                cloudinary = temp
//            }
//            var image = ""
//            if let temp = i.valueForKeyPath("cover.cloudinaryPublicId") as? String {
//                image = temp
//            }
//            var createdAt = ""
//            if let temp = i.valueForKeyPath("createdAt") as? String {
//                createdAt = temp
//            }
//            var hostID = ""
//            if let temp = i.valueForKeyPath("hostId") as? String {
//                hostID = temp
//            }
//            var location_lat = Float(0)
//            if let temp = i.valueForKeyPath("location.lat") as? Float {
//                location_lat = temp
//            }
//            var location_lng = Float(0)
//            if let temp = i.valueForKeyPath("location.lng") as? Float {
//                location_lng = temp
//            }
//            var location_latApprox = Float(0)
//            if let temp = i.valueForKeyPath("location.latApprox") as? Float {
//                location_latApprox = temp
//            }
//            var location_lngApprox = Float(0)
//            if let temp = i.valueForKeyPath("location.lngApprox") as? Float {
//                location_lngApprox = temp
//            }
//            var maxParty = 0
//            if let temp = i.valueForKeyPath("maxParty") as? Int {
//                maxParty = temp
//            }
//            var acceptedGuests = 0
//            if let temp = i.valueForKeyPath("numberOfAcceptedGuests") as? Int {
//                acceptedGuests = temp
//            }
//            var totalGuests = 0
//            if let temp = i.valueForKeyPath("numberOfGuests") as? Int {
//                totalGuests = temp
//            }
//            var placeType = 0
//            if let temp = i.valueForKeyPath("placeType") as? Int {
//                placeType = temp
//            }
//            var price = 0
//            if let temp = i.valueForKeyPath("pricePerGuest") as? Int {
//                price = temp
//            }
//            var spotsLeft = 0
//            if let temp = i.valueForKeyPath("spotsLeft") as? Int {
//                spotsLeft = temp
//            }
//            var status = 0
//            if let temp = i.valueForKeyPath("status") as? Int {
//                status = temp
//            }
//            var summary = ""
//            if let temp = i.valueForKeyPath("summary") as? String {
//                summary = temp
//            }
//            var time_deadline = ""
//            if let temp = i.valueForKeyPath("time.deadline") as? String {
//                time_deadline = temp
//            }
//            var time_endAt = ""
//            if let temp = i.valueForKeyPath("time.endAt") as? String {
//                time_endAt = temp
//            }
//            var time_startAt = ""
//            if let temp = i.valueForKeyPath("time.startAt") as? String {
//                time_startAt = temp
//            }
//            var time_zone = 0
//            if let temp = i.valueForKeyPath("time.zone") as? Int {
//                time_zone = temp
//            }
//            var theme = ""
//            if let temp = i.valueForKeyPath("title") as? String {
//                theme = temp
//            }
//            let interaction = ""
//            if let temp = i.valueForKeyPath("interaction") as? String {
//                id = temp
//            }
//            var note = ""
//            if let temp = i.valueForKeyPath("note") as? String {
//                note = temp
//            }
//            var question = ""
//            if let temp = i.valueForKeyPath("question") as? String {
//                question = temp
//            }
//            var autoAccept = false
//            if let temp = i.valueForKeyPath("autoAccept") as? Bool {
//                autoAccept = temp
//            }
//            var updatedAt = ""
//            if let temp = i.valueForKeyPath("updatedAt") as? String {
//                updatedAt = temp
//            }
//            var hostFirstName = ""
//            if let temp = i.valueForKeyPath("hostFirstName") as? String {
//                hostFirstName = temp
//            }
//            var hostLastName = ""
//            if let temp = i.valueForKeyPath("hostLastName") as? String {
//                hostLastName = temp
//            }
//            var hostPic = ""
//            if let temp = i.valueForKeyPath("hostPic") as? String {
//                hostPic = temp
//            }
//            var reviewable = 0
//            if let temp = i.valueForKeyPath("reviewable") as? Int {
//                reviewable = temp
//            }
//            let statusBefore = i.valueForKeyPath("orderStatus") as! Int
//            var orderStatus = ""
//            switch statusBefore{
//            case -4:orderStatus = "Expired"
//            case -3:orderStatus = "Event cancelled by host"
//            case -2:orderStatus = "Cancelled by guest"
//            case -1:orderStatus = "Declined"
//            case 0:orderStatus = "Pending"
//            case 1:orderStatus = "Accepted"
//            default:orderStatus = "Error, status not found"
//            }
//            var hostOverallRating = Float(0)
//            if let temp = i.valueForKeyPath("hostOverallRating") as? Float {
//                hostOverallRating = temp
//            }
//            var guestList = []
//            if let temp = i.valueForKeyPath("guestList") as? NSArray {
//                guestList = temp
//            }
//            var hostReviewsCount = 0
//            if let temp = i.valueForKeyPath("hostReviewsCount") as? Int {
//                hostReviewsCount = temp
//            }
//            if status == 1 {
//                data.append(EventData(id: id, address_city: address_city, address: address, address_state: address_state, autoAccept: autoAccept, cloudinary: cloudinary, image: image, createdAt: createdAt, hostID: hostID, location_lat: location_lat, location_lng: location_lng, location_latApprox: location_latApprox, location_lngApprox: location_lngApprox, maxParty: maxParty, acceptedGuests: acceptedGuests, totalGuests: totalGuests, placeType: placeType, price: price, spotsLeft: spotsLeft, status: status, summary: summary, time_deadline: time_deadline, time_endAt: time_endAt, time_startAt: time_startAt, time_zone: time_zone, theme: theme, interaction: interaction, note: note, question: question, updatedAt: updatedAt, hostFirstName:hostFirstName, hostLastName: hostLastName, hostPic: hostPic, reviewable: reviewable, orderStatus: orderStatus, hostOverallRating: hostOverallRating, guestList: guestList, hostReviewsCount: hostReviewsCount))
//            }
//        }
//        return data
//    }
//}

extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}

func fakeData() -> EventData {
    return EventData(id: "", address_city: "", address: "", address_state: "", autoAccept: true, cloudinary: "", image: "", createdAt: "", hostID: "", location_lat: 0.0, location_lng: 0.0, location_latApprox: 0.0, location_lngApprox: 0.0, maxParty: 0, acceptedGuests: 0, totalGuests: 0, placeType: 0, price: 0, spotsLeft: 0, status: 0, summary: "", time_deadline: "", time_endAt: "", time_startAt: "", time_zone: 0, theme: "", interaction: "", note: "", question: "", updatedAt: "", hostFirstName:"", hostLastName: "", hostPic: "", reviewable: 0, orderStatus: "", hostOverallRating: 0, guestList: [], hostReviewsCount: 0)
}
