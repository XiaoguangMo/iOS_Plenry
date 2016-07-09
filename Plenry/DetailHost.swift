//
//  DetailHost.swift
//  Plenry
//
//  Created by NNNO on 8/21/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class DetailHost: UITableViewCell {

    @IBOutlet var type: UILabel!
    @IBOutlet var pic: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var stars: UIImageView!
    @IBOutlet var rate: UILabel!
    @IBOutlet var reviews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.type.textColor = ColorGrey
        self.pic.layer.cornerRadius = 15
        self.pic.layer.masksToBounds = true
        self.pic.layer.borderWidth = 1.0
        self.pic.layer.borderColor = ColorLightGrey.CGColor
        self.rate.textColor = ColorGold
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
