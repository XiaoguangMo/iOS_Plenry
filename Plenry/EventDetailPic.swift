//
//  EventDetailPic.swift
//  Plenry
//
//  Created by NNNO on 7/1/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class EventDetailPic: UITableViewCell {
    @IBOutlet var pic: UIImageView!
    @IBOutlet var theme: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
