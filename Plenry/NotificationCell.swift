//
//  NotificationCell.swift
//  Plenry
//
//  Created by NNNO on 9/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet var pic: UIImageView!
    @IBOutlet var header: UILabel!
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
