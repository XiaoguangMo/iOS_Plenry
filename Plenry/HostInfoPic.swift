//
//  HostInfoPic.swift
//  Plenry
//
//  Created by NNNO on 7/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class HostInfoPic: UITableViewCell {

    @IBOutlet var memberSince: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var pic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
