//
//  MeAboutMe.swift
//  Plenry
//
//  Created by NNNO on 8/6/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class MeAboutMe: UITableViewCell {

    @IBOutlet var textview: UITextView!
    @IBOutlet var label: UILabel!
    
    @IBOutlet var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
