//
//  MeUser.swift
//  Plenry
//
//  Created by NNNO on 6/23/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class MeUser: UITableViewCell {

    @IBOutlet var history: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userPhoto.layer.cornerRadius = 37.5
        self.userPhoto.layer.masksToBounds = true
        self.userPhoto.layer.borderWidth = 1.0
        self.userPhoto.layer.borderColor = ColorLightGrey.CGColor
        self.backgroundColor = ColorSuperLightGrey
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
