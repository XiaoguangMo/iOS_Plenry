//
//  DetailLocation.swift
//  Plenry
//
//  Created by NNNO on 8/21/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class DetailLocation: UITableViewCell {
    @IBOutlet weak var address: UICopiableLabel!
    @IBOutlet var type: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.type.textColor = ColorGrey
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
