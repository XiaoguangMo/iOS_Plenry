//
//  ForgotPassword.swift
//  Plenry
//
//  Created by NNNO on 6/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class ForgotPassword: UIViewController {
    @IBOutlet var SendBtn: UIButton!
    @IBOutlet var emailAdd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        SendBtn.backgroundColor = ColorGreen
        SendBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        SendBtn.layer.cornerRadius = 5
        SendBtn.layer.masksToBounds = true
        emailAdd.borderStyle = .RoundedRect
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = Double(0.30)
        UIView.beginAnimations("ResizeView", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, -120, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = Double(0.30)
        UIView.beginAnimations("ResizeView", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }
    
    @IBAction func clickBackground(sender: AnyObject) {
        emailAdd.resignFirstResponder()
    }
    
    @IBAction func forgotPW(sender: AnyObject) {
        let result = forgotPassword(emailAdd.text!)
        self.view.endEditing(true)
        if result.replace("\"", withString: "") == "done" {
            SweetAlert().showAlert("Almost Done", subTitle: "Please follow the instruction in your email!", style: AlertStyle.Success)
        }else{
            SweetAlert().showAlert("Opps", subTitle: "We couldn't find your email!", style: AlertStyle.Error)
        }
    }
}
