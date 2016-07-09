//
//  Status.swift
//  Plenry
//
//  Created by NNNO on 6/22/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class Status: UITableViewCell {

    @IBOutlet var status: UILabel!
    @IBOutlet var collapseStatus: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
