//
//  PhoneVerify.swift
//  Plenry
//
//  Created by NNNO on 8/20/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class PhoneVerify: UIViewController, UITextFieldDelegate {
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var button: UIButton!
    var stepTwo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.becomeFirstResponder()
        label.text = "Please input your phone number"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func veriryPhone(sender: AnyObject) {
        if stepTwo {
            let result = phoneVerifyTwo(textField.text!, userId: getUserID())
            if result.replace("\"", withString: "") == "verified" {
                textField.resignFirstResponder()
                SweetAlert().showAlert("Congratulation!", subTitle: "Your phone number has been verified.", style: AlertStyle.Success)
                textField.text = ""
                self.navigationController?.popToRootViewControllerAnimated(true)
            }else{
                textField.resignFirstResponder()
                SweetAlert().showAlert("Opps!", subTitle: result, style: AlertStyle.Error)
                textField.text = ""
            }
        }else{
            let result = phoneVerifyOne(textField.text!, userId: getUserID())
            if result.replace("\"", withString: "") == "verification message sent" {
                textField.resignFirstResponder()
                SweetAlert().showAlert("Almost Done!", subTitle: "You will get a text message with a four digit code.", style: AlertStyle.Success)
                textField.text = ""
                label.text = "Please input the 4 digits code shown in your message."
                stepTwo = true
            }else{
                textField.resignFirstResponder()
                SweetAlert().showAlert("Opps!", subTitle: result, style: AlertStyle.Error)
                textField.text = ""
            }
        }
    }
}
