//
//  Glance.swift
//  Plenry
//
//  Created by NNNO on 6/22/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class Glance: UITableViewCell {

    @IBOutlet var pic: UIImageView!
    @IBOutlet var theme: UITextView!
    @IBOutlet var time: UILabel!
    @IBOutlet var city: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.theme.textColor = UIColor.blackColor()
        self.time.textColor = UIColor.whiteColor()
        self.city.textColor = UIColor.whiteColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
