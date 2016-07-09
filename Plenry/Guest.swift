//
//  Guest.swift
//  Plenry
//
//  Created by NNNO on 7/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class Guest: UITableViewCell {

    @IBOutlet var reviewBtn: UIButton!
    @IBOutlet var pic: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var rate: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codecell.email.textColor = getGold()
        self.pic.layer.cornerRadius = 40
        self.pic.layer.masksToBounds = true
        self.pic.layer.borderWidth = 1.0
        self.pic.layer.borderColor = ColorLightGrey.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
