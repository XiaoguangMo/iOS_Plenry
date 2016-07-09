//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
//import LoginVerify
import Cloudinary

class ViewController: UIViewController,FBSDKLoginButtonDelegate, UIScrollViewDelegate, CLUploaderDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
//    @IBOutlet var textView2: UITextView!
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var FBLogin: FBSDKLoginButton!
//    @IBOutlet var textView3: UITextView!
//    @IBOutlet var textView4: UITextView!
//    @IBOutlet var logo: UIImageView!
    @IBOutlet var SignupButton: UIButton!
    @IBOutlet var LoginButton: UIButton!
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil) {
            print(error)
            // Process error
        } else if result.isCancelled {
//            println("isCancelled")
            // Handle cancellations
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email"){
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: TabViewController = storyboard.instantiateViewControllerWithIdentifier("MainTabView") as! TabViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
            self.returnUserData()
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData() {
        print("returnUserData")
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
//                println(result.valueForKey("last_name") as! NSString)
//                println(result.valueForKey("first_name") as! NSString)
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                
//                println("access token:")
//                println(accessToken)
//                println(facebookRegister(a))
                setUserID(facebookRegister(accessToken).replace("\"", withString: ""))
                let _ = addiOSToken(getUserID(), deviceToken: myDeviceToken)
//                println("fetched user: \(result)")
//                let userName : NSString = result.valueForKey("name") as! NSString
//                println("User Name is: \(userName)")
//                let userEmail : NSString = result.valueForKey("email") as! NSString
//                println("User Email is: \(userEmail)")
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SignupButton.backgroundColor = ColorGreen
        LoginButton.backgroundColor = ColorGreen
        FBSDKLoginManager().logOut()
        SignupButton.layer.cornerRadius = 5
        SignupButton.layer.masksToBounds = true
        LoginButton.layer.cornerRadius = 5
        LoginButton.layer.masksToBounds = true
        FBLogin.layer.cornerRadius = 5
        FBLogin.layer.masksToBounds = true
//        FBLogin.setTitle("hello", forState: .Normal)
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            print(FBSDKAccessToken.currentAccessToken().tokenString)
//            println(facebookRegister(FBSDKAccessToken.currentAccessToken().tokenString))
//            FBSDKLoginManager().logOut()
            // User is already logged in, do work such as go to next view controller.
        } else {
            FBLogin.readPermissions = ["public_profile", "email", "user_friends"]
            FBLogin.delegate = self
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        //1
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        //2
        textView.textAlignment = .Center
        textView.text = "Explore fun activities around you"
        textView.textColor = .whiteColor()
//        textView2.textAlignment = .Center
//        textView2.text = "many more friends"
//        textView2.textColor = .whiteColor()
        //3
        let imgOne = UIImageView(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
        imgOne.image = UIImage(named: "launch_01")
        let imgTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
        imgTwo.image = UIImage(named: "launch_02")
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
        imgThree.image = UIImage(named: "launch_03")
        let imgFour = UIImageView(frame: CGRectMake(scrollViewWidth*3, 0,scrollViewWidth, scrollViewHeight))
        imgFour.image = UIImage(named: "launch_04")
//        let imgFive = UIImageView(frame: CGRectMake(scrollViewWidth*4, 0,scrollViewWidth, scrollViewHeight))
//        imgFive.image = UIImage(named: "plenry_app_1st Login 1")
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        self.scrollView.addSubview(imgFour)
//        self.scrollView.addSubview(imgFive)
        //4
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 4, self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        textView.alpha = 0
//        textView2.alpha = 0
//        textView3.alpha = 0
//        textView4.alpha = 0
//        logo.alpha = 0
//        if Int(currentPage) == 4 {
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                self.logo.alpha = 1.0
//                self.textView3.alpha = 1.0
//                self.textView4.alpha = 1.0
//            })
//        }else{
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                if Int(currentPage) == 0{
                    self.textView.text = "Explore fun activities around you"
//                    self.textView2.text = "many more friends"
                }else if Int(currentPage) == 1{
                    self.textView.text = "Join an event or create your own"
//                    self.textView2.text = "home-dining experience around your area"
                }else if Int(currentPage) == 2{
                    self.textView.text = "Stay connected with people you meet"
//                    self.textView2.text = "through Plenry's trusted service"
                }else if Int(currentPage) == 3{
                    self.textView.text = "Make new friends anywhere you go"
//                    self.textView2.text = "of socializing"
                }
                self.textView.alpha = 1.0
//                self.textView2.alpha = 1.0
            })
//        }
//        if Int(currentPage) == 0{
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                self.textView.text = "One more culture"
//                self.textView2.text = "many more friends"
//                self.textView.alpha = 1.0
//                self.textView2.alpha = 1.0
//            })
//        }else if Int(currentPage) == 4 {
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                self.logo.alpha = 1.0
//                self.textView3.alpha = 1.0
//                self.textView4.alpha = 1.0
//            })
//        }else{
//            self.textView.alpha = 1.0
//            self.textView2.alpha = 1.0
//        }
    }
    
}