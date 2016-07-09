//
//  SignupEmail.swift
//  Plenry
//
//  Created by NNNO on 6/18/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class SignupEmail: UIViewController,UITextFieldDelegate {
    @IBOutlet var email: UITextField!
    @IBOutlet var pw: UITextField!
    @IBOutlet var confirm: UITextField!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var SendBtn: UIButton!
    @IBOutlet var checkBtn: UIButton!
    @IBOutlet var terms: UIButton!
    @IBOutlet var policy: UIButton!
    
    var checked = false
    let nameRegex = "^([a-zA-Z ]+)$"
//    let passwordRegex = "^([0-9a-zA-Z]+)$"
    let emailRegex = "^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$"
    override func viewDidLoad() {
        super.viewDidLoad()
        SendBtn.backgroundColor = ColorGreen
        SendBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        email.borderStyle = .RoundedRect
        pw.borderStyle = .RoundedRect
        confirm.borderStyle = .RoundedRect
        firstName.borderStyle = .RoundedRect
        lastName.borderStyle = .RoundedRect
        terms.setTitleColor(ColorRed, forState: .Normal)
        policy.setTitleColor(ColorRed, forState: .Normal)
        SendBtn.layer.cornerRadius = 5
        SendBtn.layer.masksToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func termsOfServices(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://plenry.com/terms")!)
        
    }
    @IBAction func privacyPolicy(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://plenry.com/privacy")!)
    }
    @IBAction func checkBtnClicked(sender: AnyObject) {
        checked = !checked
        if checked {
            checkBtn.setImage(UIImage(named: "checkmark_checked"), forState: .Normal)
        }else{
            checkBtn.setImage(UIImage(named: "checkmark"), forState: .Normal)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        self.view.endEditing(true)
        if identifier == "signUp" {
            if email.text == "" || firstName.text == "" || lastName.text == "" || pw.text == "" || confirm.text == "" {
                SweetAlert().showAlert("Opps", subTitle: "Please fill in every field", style: AlertStyle.Error)
                return false
            }
            if pw.text!.characters.count < 8 {
                SweetAlert().showAlert("Opps", subTitle: "Your password should be at least 8 characters long", style: AlertStyle.Error)
                return false
            }
            if pw.text != confirm.text {
                SweetAlert().showAlert("Opps", subTitle: "Password dosen't match", style: AlertStyle.Error)
                return false
            }
            if let _ = email.text!.rangeOfString(emailRegex, options: .RegularExpressionSearch){
            }else{
                SweetAlert().showAlert("Opps", subTitle: "The email you entered is invalid", style: AlertStyle.Error)
                return false
            }
            if let _ = firstName.text!.rangeOfString(nameRegex, options: .RegularExpressionSearch){
            }else{
                SweetAlert().showAlert("Opps", subTitle: "Your name cannot contain any special character or numbers", style: AlertStyle.Error)
                return false
            }
            if let _ = lastName.text!.rangeOfString(nameRegex, options: .RegularExpressionSearch){
            }else{
                SweetAlert().showAlert("Opps", subTitle: "Your name cannot contain any special character or numbers", style: AlertStyle.Error)
                return false
            }
            
//            var letterCounter = 0
//            var digitCount = 0
//            let phrase = "The final score was 32-31!"
//            for tempChar in phrase.unicodeScalars {
//                if tempChar.isAlpha() {
//                    letterCounter++
//                } else if tempChar.isDigit() {
//                    digitCount++
//                }
//            }
            let letters = NSCharacterSet.letterCharacterSet()
            let digits = NSCharacterSet.decimalDigitCharacterSet()
            
            var letterCount = 0
            var digitCount = 0
            
            for uni in pw.text!.unicodeScalars {
                if letters.longCharacterIsMember(uni.value) {
                    letterCount += 1
                } else if digits.longCharacterIsMember(uni.value) {
                    digitCount += 1
                }
            }
            if letterCount < 1 || digitCount < 1 {
                SweetAlert().showAlert("Opps", subTitle: "Your password should contain at least one letter and one number", style: AlertStyle.Error)
                return false
            }
//            if let _ = pw.text!.rangeOfString(passwordRegex, options: .RegularExpressionSearch){
//            }else{
//                SweetAlert().showAlert("Opps", subTitle: "Your password should contain at least one letter and one number", style: AlertStyle.Error)
//                return false
//            }
            
            if !checked {
                SweetAlert().showAlert("Opps", subTitle: "Your need to accept our terms of service and privacy policy.", style: AlertStyle.Error)
                return false
            }
            let a = emailRegister(firstName.text!, lastName: lastName.text!, email: email.text!, password: pw.text!)
            if a.replace("\"", withString: "") == "error" {
                SweetAlert().showAlert("Opps", subTitle: "Sorry, we couldn't process your request.", style: AlertStyle.Error)
                return false
            }else{
                SweetAlert().showAlert("Activate Your Account", subTitle: "You will receive an email to activate your accout", style: .Success, buttonTitle: "OK", buttonColor: ColorGreen)
//                return true
            }
        }
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = Double(0.30)
        UIView.beginAnimations("ResizeView", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == email {
            pw.becomeFirstResponder()
        }else if textField == pw {
            confirm.becomeFirstResponder()
        }else if textField == confirm {
            firstName.becomeFirstResponder()
        }else if textField == firstName {
            lastName.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    @IBAction func clickBackground(sender: AnyObject) {
        email.resignFirstResponder()
        pw.resignFirstResponder()
        confirm.resignFirstResponder()
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
    }
    func textFieldDidEndEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = Double(0.30)
        UIView.beginAnimations("ResizeView", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }
}
