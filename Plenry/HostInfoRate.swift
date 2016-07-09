//
//  HostInfoRate.swift
//  Plenry
//
//  Created by NNNO on 7/13/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class HostInfoRate: UITableViewCell {

    @IBOutlet var rate: UILabel!
    @IBOutlet var count: UILabel!
    @IBOutlet var star: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
