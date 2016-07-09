//
//  AppDelegate.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit

import Bolts
import GoogleMaps

import FBSDKCoreKit
import FBSDKLoginKit
//import Alamofire

// If you want to use any of the UI components, uncomment this line
// import ParseUI

// If you want to use Crash Reporting - uncomment this line
// import ParseCrashReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    //--------------------------------------
    // MARK: - UIApplicationDelegate
    //--------------------------------------
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCR-RnHUdt98uyXTH__k0Te_KiZp_Flius")
//        census()
        // Enable storing and querying data from Local Datastore.
        // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
//        Parse.enableLocalDatastore()
        
        // ****************************************************************************
        // Uncomment this line if you want to enable Crash Reporting
        // ParseCrashReporting.enable()
        //
        // Uncomment and fill in with your Parse credentials:
//        Parse.setApplicationId("KjFK25M5cxlOUqeeTZt9MIxhfi7PzPyx1c1mXiuh", clientKey: "hniUXjJ1TqlasxYC2xIZbCR6TIkpxEcs1KmJ3Yry")
        // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
        // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
        // Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
        // PFFacebookUtils.initializeFacebook()
        // ****************************************************************************
        
//        PFUser.enableAutomaticUser()
        
//        let defaultACL = PFACL();
        
        // If you would like all objects to be private by default, remove this line.
//        defaultACL.setPublicReadAccess(true)
        
//        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)
        
//        if application.applicationState != UIApplicationState.Background {
//            // Track an app open here if we launch with a push, unless
//            // "content_available" was used to trigger a background push (introduced in iOS 7).
//            // In that case, we skip tracking here to avoid double counting the app-open.
//            
//            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
//            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
//            var noPushPayload = false;
//            if let options = launchOptions {
//                noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
//            }
//            if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
//                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
//            }
//        }
//        if application.respondsToSelector("registerUserNotificationSettings:") {
//            let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
//            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
//            application.registerUserNotificationSettings(settings)
//            application.registerForRemoteNotifications()
//        } else {
//            let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
//            application.registerForRemoteNotificationTypes(types)
//        }
        
        
        
//        setUserID("bXXTJsg4A4y34zSGi")
//        setUserID("KJvAesFmkBEWE7g3L")//celine
//        setUserID("mLNFKprks9gcmj7qJ")//lisha
//        setUserID("qEZi8QzdCQja2MWh9")//momo
//        let a:[Int] = [32,23]
//        let aa = a.map{String($0)}
//        let x = a.reduce(0, combine: +) == 0 ? "0" : a.map{String($0)}.sort{$0>$1}.reduce("",combine: +)
//        print(a.map(){String($0)}.sort(){$0<$1}.reduce("",combine: +).toInt()==0 ? )
//        let characters = Array(string.characters)
//        print(characters)
//        print(getComment("WQrCH5sBiAKmAC2Z2"));
        UIApplication.sharedApplication().registerForRemoteNotifications()
        let settings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        let settings2 = UIUserNotificationSettings(forTypes: .Badge, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings2)
        let settings3 = UIUserNotificationSettings(forTypes: .Sound, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings3)
        if getUserID() != "" {
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("MainTabView")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            let _ = addiOSToken(getUserID(), deviceToken: myDeviceToken)
        }
//        let sharedApplication = UIApplication.sharedApplication()
//        let _ = sharedApplication.canOpenURL(NSURL(fileURLWithPath: "fbauth://authorize"))
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
//    func largestNumber(num:[Int]) -> String {
//        return num.reduce(0, combine: +)==0 ? "0" : num.map(){String($0)}.sort{$0+$1>$1+$0}.reduce("",combine: +)
//    }
    
//    func printSomthing(input:AnyObject?) {
//        print(input)
//    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//        println("Got token data! \(deviceToken)")
//        cleariOSToken()
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        for i in 0 ..< deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        if tokenString.characters.count == 64 {
            let _ = addiOSToken(getUserID(), deviceToken: tokenString)
            myDeviceToken = tokenString
            print(myDeviceToken)
        }
//        println(result)
//        println(count(tokenString))
//        let a = NSString(data: deviceToken, encoding: NSUTF32BigEndianStringEncoding)
//        println(deviceToken)
    }

//    func shuffleArray(array:[Int]) -> [Int] {
//        let n:Int = array.count
//        var index:Int = 0
//        while (index < n) {
//            let randomNumber = arc4random(). % n
//            let temp = array[index]
//            array[index] = array[randomNumber]
//            array[randomNumber] = temp
//        }
//        return array
//    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//        println("Couldn't register: \(error)")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)

    }
//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: NSString?, annotation: AnyObject) -> Bool {
//        var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
//        return wasHandled
//    }
    
    
    //--------------------------------------
    // MARK: Push Notifications
    //--------------------------------------
    
//    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//        let installation = PFInstallation.currentInstallation()
//        installation.setDeviceTokenFromData(deviceToken)
//        installation.saveInBackground()
//        
//        PFPush.subscribeToChannelInBackground("", block: { (succeeded: Bool, error: NSError?) -> Void in
//            if succeeded {
//                println("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
//            } else {
//                println("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.", error)
//            }
//        })
//    }
    
//    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//        if error.code == 3010 {
//            println("Push notifications are not supported in the iOS Simulator.")
//        } else {
//            println("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
//        }
//    }
    
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        PFPush.handlePush(userInfo)
//        if application.applicationState == UIApplicationState.Inactive {
//            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
//        }
//    }
    
    ///////////////////////////////////////////////////////////
    // Uncomment this method if you want to use Push Notifications with Background App Refresh
    ///////////////////////////////////////////////////////////
    // func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    //     if application.applicationState == UIApplicationState.Inactive {
    //         PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
    //     }
    // }
    
    //--------------------------------------
    // MARK: Facebook SDK Integration
    //--------------------------------------
    
    ///////////////////////////////////////////////////////////
    // Uncomment this method if you are using Facebook
    ///////////////////////////////////////////////////////////
    // func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    //     return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, session:PFFacebookUtils.session())
    // }
}
