//
//  labelImage.swift
//  Plenry
//
//  Created by NNNO on 6/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class labelImage: UITableViewCell {

    @IBOutlet var myImage: UIImageView!
    @IBOutlet var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
