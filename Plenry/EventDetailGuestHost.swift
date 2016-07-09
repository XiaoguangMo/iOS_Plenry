//
//  EventDetailGuestHost.swift
//  Plenry
//
//  Created by NNNO on 7/1/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class EventDetailGuestHost: UITableViewCell {

    @IBOutlet var guest: UILabel!
    @IBOutlet var host: UILabel!
    @IBOutlet var hostPic: UIImageView!
    @IBOutlet var hostRate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
