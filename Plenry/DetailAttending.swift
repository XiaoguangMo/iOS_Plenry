//
//  DetailAttending.swift
//  Plenry
//
//  Created by NNNO on 8/21/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class DetailAttending: UITableViewCell {
    @IBOutlet var type: UILabel!
    @IBOutlet var img1: UIImageView!
    @IBOutlet var img2: UIImageView!
    @IBOutlet var img3: UIImageView!
    @IBOutlet var img4: UIImageView!
    @IBOutlet var img5: UIImageView!
    @IBOutlet var img6: UIImageView!
    @IBOutlet var extraGuest: UILabel!
    @IBOutlet var noGuest: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.img1.layer.cornerRadius = 15
        self.img1.layer.masksToBounds = true
        self.img1.layer.borderWidth = 1.0
        self.img1.layer.borderColor = ColorLightGrey.CGColor
        self.img2.layer.cornerRadius = 15
        self.img2.layer.masksToBounds = true
        self.img2.layer.borderWidth = 1.0
        self.img2.layer.borderColor = ColorLightGrey.CGColor
        self.img3.layer.cornerRadius = 15
        self.img3.layer.masksToBounds = true
        self.img3.layer.borderWidth = 1.0
        self.img3.layer.borderColor = ColorLightGrey.CGColor
        self.img4.layer.cornerRadius = 15
        self.img4.layer.masksToBounds = true
        self.img4.layer.borderWidth = 1.0
        self.img4.layer.borderColor = ColorLightGrey.CGColor
        self.img5.layer.cornerRadius = 15
        self.img5.layer.masksToBounds = true
        self.img5.layer.borderWidth = 1.0
        self.img5.layer.borderColor = ColorLightGrey.CGColor
        self.img6.layer.cornerRadius = 15
        self.img6.layer.masksToBounds = true
        self.img6.layer.borderWidth = 1.0
        self.img6.layer.borderColor = ColorLightGrey.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
