//
//  ChatCell.swift
//  Plenry
//
//  Created by NNNO on 8/25/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet var pic2: UIImageView!

    @IBOutlet var pic: UIButton!
    @IBOutlet var name: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pic2.layer.cornerRadius = 27.5
        self.pic2.layer.cornerRadius = 27.5
        self.pic2.layer.masksToBounds = true
        self.pic2.layer.borderWidth = 1.0
        self.pic2.layer.borderColor = ColorLightGrey.CGColor
        self.pic.layer.cornerRadius = 27.5
        self.pic.layer.cornerRadius = 27.5
        self.pic.layer.masksToBounds = true
        self.pic.layer.borderWidth = 1.0
        self.pic.layer.borderColor = ColorLightGrey.CGColor
        self.content.textColor = ColorGrey
        self.time.textColor = ColorGrey
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
