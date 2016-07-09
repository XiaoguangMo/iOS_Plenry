//
//  WriteAboutMe.swift
//  Plenry
//
//  Created by NNNO on 9/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

protocol WriteDes{
    func didFinishTwoVC(controller:WriteAboutMe)
}

class WriteAboutMe: UIViewController, UITextViewDelegate {
    @IBOutlet var textView: UITextView!
    var des = ""
    var delegate:WriteDes!=nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WriteAboutMe.goBack(_:)))
        self.navigationItem.setLeftBarButtonItem(backItem, animated: false)
        textView.text = des
    }
    override func viewDidAppear(animated: Bool) {
        textView.becomeFirstResponder()
    }
    func goBack(sender: UIBarButtonItem) {
        delegate.didFinishTwoVC(self)
    }
    
    func textViewDidChange(textView: UITextView) {
        des = textView.text
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}