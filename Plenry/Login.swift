//
//  Login.swift
//  Plenry
//
//  Created by NNNO on 6/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class Login: UIViewController {
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var loginBtn: UIButton!
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "loginButtonClicked" {
            let result = loginCheck(email.text!, password: password.text!)
            print(result)
            self.view.endEditing(true)
            if result.replace("\"", withString:"") == "error" || result.replace("\"", withString: "") == "null" || result == "Server error." || result.replace("\"", withString: "") == "wrong password or invalid login email"{
                SweetAlert().showAlert("Opps", subTitle: "Login failed, please check your email and password!", style: AlertStyle.Error)
                return false
            }else{
                setUserID(result.replace("\"", withString: ""))
                let _ = addiOSToken(getUserID(), deviceToken: myDeviceToken)
                return true
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.backgroundColor = ColorGreen
        loginBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
        email.borderStyle = .RoundedRect
        password.borderStyle = .RoundedRect
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = Double(0.30)
        UIView.beginAnimations("ResizeView", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    @IBAction func clickBackground(sender: AnyObject) {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    func textFieldDidEndEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = Double(0.30)
        UIView.beginAnimations("ResizeView", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }
}