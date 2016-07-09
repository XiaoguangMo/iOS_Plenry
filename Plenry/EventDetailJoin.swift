//
//  EventDetailJoin.swift
//  Plenry
//
//  Created by NNNO on 7/1/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class EventDetailJoin: UITableViewCell {

    @IBOutlet var minus: UIButton!
    @IBOutlet var join: UIButton!
    @IBOutlet var plus: UIButton!
    @IBOutlet var guestNum: UILabel!
    @IBOutlet var money: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
