//
//  NewEventItem.swift
//  Plenry
//
//  Created by NNNO on 8/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class NewEventItem: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var pic: UIImageView!
    @IBOutlet var content: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
