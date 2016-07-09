//
//  ReviewDetail.swift
//  Plenry
//
//  Created by NNNO on 8/7/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ReviewDetail: UITableViewCell {

    @IBOutlet var pic: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pic.layer.cornerRadius = 22
        self.pic.layer.masksToBounds = true
        self.pic.layer.borderWidth = 1.0
        self.pic.layer.borderColor = ColorLightGrey.CGColor
        self.date.textColor = ColorGrey
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
