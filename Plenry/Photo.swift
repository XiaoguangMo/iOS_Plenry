//
//  Photo.swift
//  Plenry
//
//  Created by NNNO on 7/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Cloudinary

func changePhoto(userId:String, cloudinary:String) -> Bool {
    var returnValue = false
    let urlPath: String = "https://plenry.com/rest/changePhoto/"
    let url: NSURL = NSURL(string: urlPath)!
    let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
//    var err: NSError?
    do {
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["userId":userId,"cloudinary":cloudinary], options: [])
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
//    println(dataVal)
    if dataVal == nil {
        if requestError != nil {
            return false
        }
        return false
    }else{
        if let temp = NSString(data:dataVal!, encoding:NSUTF8StringEncoding) as? String {
//            println(temp)
            if temp.replace("\"", withString: "") == "true" {
                returnValue = true
            }
        }
        return returnValue
    }
}
//func getDetailPhoto(urlString: String) -> UIImage {
//    let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_fill,h_358,w_640/"+urlString+".jpg")
//    if let temp = NSData(contentsOfURL: url!){
//        return UIImage(data: temp)!
//    }else{
//        return UIImage()
//    }
//}

func getFriendPhoto(urlString: String) -> UIImage {
    let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_fill,g_face,h_240,q_100,w_240/"+urlString+".jpg")
    let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
    return UIImage(data: data!)!
}

func getMapImage(urlString: String) -> UIImage {
    let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_scale,h_85,w_150/"+urlString+".jpg")
    let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
    return UIImage(data: data!)!
    
//    if let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_lpad,g_center,h_85,w_150/"+urlString+".jpg") {
//        let request = NSURLRequest(URL: url)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
//            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            if error == nil {
//                self.image = UIImage(data: data)
//                //                    self.image = UIImage(named: "picture 150*85")
//
//            }else{
//                self.image = UIImage(named: "picture 150*85")
//            }
//        }
//    }
}
extension UIImageView {
    public func getAvatarFromCloudinary(urlString: String) {
        if let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_fill,g_face,h_80,q_100,w_80/"+urlString+".jpg") {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    self.image = UIImage(data: data!)
                    
                }else{
                    self.image = UIImage(named: "avatar")
                }
            }
        }
    }
    public func getBigAvatarFromCloudinary(urlString: String) {
        if let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_thumb,g_face,h_256,w_320/"+urlString+".jpg") {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    self.image = UIImage(data: data!)
                    
                }else{
                    self.image = UIImage(named: "avatar")
                }
            }
        }
    }
    public func getPreviewAvatarFromCloudinary(urlString: String) {
        if let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_fill,g_face,h_240,q_100,w_240/"+urlString+".jpg") {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    self.image = UIImage(data: data!)
                    
                }else{
                    self.image = UIImage(named: "avatar")
                }
            }
        }
    }
    public func getDetailImageFromCloudinary(urlString: String) {
        if let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_fill,h_358,w_640/"+urlString+".jpg") {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    let myImage = UIImage(data: data!)
                    if myImage?.size.width > myImage?.size.height {
                        self.image = UIImage(data: data!)
                    }else{
                        let myWidth = myImage?.size.width
                        self.image = UIImage(data: data!)?.imageWithInsets(UIEdgeInsetsMake(0.0, (320 - myWidth!) / 2, 0.0, (320 - myWidth!) / 2))
                    }
                }else{
                    self.image = UIImage(named: "picture 320*180")
                }
            }
        }
    }
    public func getAttendingFromCloudinary(urlString: String) {
        if let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_fill,h_316,w_560/"+urlString+".jpg") {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    let myImage = UIImage(data: data!)
                    if myImage?.size.width > myImage?.size.height {
                        self.image = myImage
                    }else{
                        let myWidth = myImage?.size.width
                        self.image = UIImage(data: data!)?.imageWithInsets(UIEdgeInsetsMake(0.0, (280 - myWidth!) / 2, 0.0, (280 - myWidth!) / 2))
                    }
                }else{
                    self.image = UIImage(named: "picture 280*158")
                }
            }
        }
    }
    public func getExplorerFromCloudinary(urlString: String) {
        if let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_fill,h_100,w_178/"+urlString+".jpg") {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    let myImage = UIImage(data: data!)
                    if myImage?.size.width > myImage?.size.height {
                        self.image = myImage
                    }else{
                        let myWidth = myImage?.size.width
                        self.image = UIImage(data: data!)?.imageWithInsets(UIEdgeInsetsMake(0.0, (89 - myWidth!) / 2, 0.0, (89 - myWidth!) / 2))
                    }
                }else{
                    self.image = UIImage(named: "picture 89*50")
                }
            }
        }
    }
    public func getMapFromCloudinary(urlString: String) {
        if let url = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/c_fill,h_85,w_150/"+urlString+".jpg") {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    let myImage = UIImage(data: data!)
                    if myImage?.size.width > myImage?.size.height {
                        self.image = myImage
                    }else{
                        let myWidth = myImage?.size.width
                        self.image = UIImage(data: data!)?.imageWithInsets(UIEdgeInsetsMake(0.0, (150 - myWidth!) / 2, 0.0, (150 - myWidth!) / 2))
                    }
                }else{
                    self.image = UIImage(named: "picture 150*85")
                }
            }
        }
    }
}

//func uploadImageToCloudinary(img:UIImage) -> Bool {
//    let cloudinary_url = "cloudinary://391732461231266:hcMfSQu5FdwZ822O4gdAwRekQOY@plenry"
//    
//    let uploader = CLUploader(CLCloudinary(url: cloudinary_url),delegate:self)
//    var new_image = UIImage()
//    var urlString = "https://http://res.cloudinary.com/plenry/image/upload/kkynber5ul5ddgxtr4es.jpg"
//    var imgURL: NSURL = NSURL(string: urlString)!
//    let request: NSURLRequest = NSURLRequest(URL: imgURL)
//    NSURLConnection.sendAsynchronousRequest(
//        request, queue: NSOperationQueue.mainQueue(),
//        completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
//            if error == nil {
//                new_image = UIImage(data: data)!
//            }
//    })
//    uploader.upload( UIImageJPEGRepresentation(img, 0.8), options: ["format":"jpg"], withCompletion: { ([NSObject : AnyObject]!, errorResult:String!, code:Int, context:AnyObject!) -> Void in
//        println(errorResult)
//        println(code)
//        println(context)
//        }, andProgress: { (p1:Int, p2:Int, p3:Int, p4:AnyObject!) -> Void in
//            println("hello")
//    })
//    return true
//}
//func getImageFromCloudinary(url:String) -> UIImage {
//    var returnImage:UIImage = UIImage()
//    let imgURL = NSURL(string: "https://res.cloudinary.com/plenry/image/upload/"+url+".jpg")!
//    println(imgURL)
//    let request = NSURLRequest(URL: imgURL)
//    let blabla: Void = NSURLConnection.sendAsynchronousRequest(
//        request, queue: NSOperationQueue.mainQueue(),
//        completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
//            if error == nil {
//                return UIImage(data: data)!
//            }else {
//                return = UIImage(named: "Icon")!
//            }
//    })
//    
//    return returnImage
//}


////import ParseStarterProject_Bridging_Header_h
////import AWSCore
////import AWSS3
////import AWSDynamoDB
////import AWSSQS
////import AWSSNS
////import AWSCognito
//class Photo {
//    func uploadPhoto() {
//        println("uploading")
//        let clouder = CLCloudinary(url: "cloudinary://your:cloudinary@url")
//        
//        let forUpload = UIImagePNGRepresentation(image) as NSData
//        let uploader = CloudinaryFactory.create(clouder, delegate: self)
//        
//        uploader.upload(forUpload, options: ["public_id":"testo"])
//        
//        
//        
//        let cloudinary_url = "cloudinary://391732461231266:hcMfSQu5FdwZ822O4gdAwRekQOY@plenry"
////        var uploader:CLUploader = CLUploader(cloudinary_url,delegate:self)
//        let a:CLUploaderDelegate = self
//        let uploader = CloudinaryFactory.create(CLCloudinary(url: cloudinary_url)!, delegate: CLUploaderDelegate())
//        let a = CloudinaryFactory.create(<#cloudinary: CLCloudinary!#>, delegate: <#CLUploaderDelegate!#>)
//        var uploader = CloudinaryFactory.create(cloudinary_url, delegate: self)
//        uploader.upload(UIImageJPEGRepresentation(new_image, 0.8), options: ["format":"jpg"])
//        var uploader:CLUploader = CLUploader(cloudinary_url, delegate: self)
//        let a = CLUploader
//            var uploader:CLUploader = CLUploader(cloudinary, delegate: self)
//        var new_image = UIImage()
//        var urlString = "https://pbs.twimg.com/profile_images/522909800191901697/FHCGSQg0.png"
//        var imgURL: NSURL = NSURL(string: urlString)!
//        let request: NSURLRequest = NSURLRequest(URL: imgURL)
//        NSURLConnection.sendAsynchronousRequest(
//            request, queue: NSOperationQueue.mainQueue(),
//            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
//                if error == nil {
//                    new_image = UIImage(data: data)!
//                }
//        })
//        uploader.upload( UIImageJPEGRepresentation(new_image, 0.8), options: ["format":"jpg"], withCompletion: { ([NSObject : AnyObject]!, errorResult:String!, code:Int, context:AnyObject!) -> Void in
//            
//            }, andProgress: { (p1:Int, p2:Int, p3:Int, p4:AnyObject!) -> Void in
//
//        })
//        //    var uploadRequest = AWSS3TransferManagerUploadRequest.new()
//        //    uploadRequest.bucket = "this is a bucket"
//        //    uploadRequest.key = "AKIAJKNDRFQWEUU57MMQ"
//        //    var urlString = "https://pbs.twimg.com/profile_images/522909800191901697/FHCGSQg0.png"
//        //    var imgURL: NSURL = NSURL(string: urlString)!
//        //    let request: NSURLRequest = NSURLRequest(URL: imgURL)
//        //    NSURLConnection.sendAsynchronousRequest(
//        //        request, queue: NSOperationQueue.mainQueue(),
//        //        completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
//        //            if error == nil {
//        //                uploadRequest.body = UIImage(data: data)
//        //            }
//        //    })
//        //
//        //
//        //    uploadRequest.body = UIImage
//        //    AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
//        //    uploadRequest.bucket = @"example-bucket";
//        //    uploadRequest.key = @"test.txt";
//        //    uploadRequest.body = self.downloadFileURL;
//        //    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
//        //
//        //    [[transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
//        //    withBlock:^id(AWSTask *task) {
//        //    if (task.error != nil) {
//        //    NSLog(@"%s %@","Error uploading :", uploadRequest.key);
//        //    }
//        //    else { NSLog(@"Upload completed"); }
//        //    return nil;
//        //    }];
//        
//        //    let credentialsProvider = AWSCognitoCredentialsProvider(
//        //        regionType: CognitoRegionType,
//        //        identityPoolId: CognitoIdentityPoolId)
//        //    let configuration = AWSServiceConfiguration(
//        //        region: DefaultServiceRegionType,
//        //        credentialsProvider: credentialsProvider)
//        //    AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
//    }
//    
//}
////lass Photo {
//
////}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(
            CGSizeMake(self.size.width + insets.left + insets.right,
                self.size.height + insets.top + insets.bottom), false, self.scale)
//        let context = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.drawAtPoint(origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
