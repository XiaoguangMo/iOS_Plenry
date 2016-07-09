//
//  hostEvent.swift
//  Plenry
//
//  Created by NNNO on 6/23/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class hostEvent: UITableViewCell {
    @IBOutlet var hostOuterView: UIView!
    @IBOutlet var edit: UIButton!
    @IBOutlet var guestList: UIButton!
    @IBOutlet var guestSpots: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var hostLocation: UILabel!
    @IBOutlet var hostTime: UILabel!
    @IBOutlet var hostTheme: UILabel!
    @IBOutlet var hostEventPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.hostOuterView.layer.borderWidth = 1.0
        self.hostOuterView.layer.borderColor = ColorLightGrey.CGColor
        self.guestList.layer.borderWidth = 1.0
        self.guestList.layer.borderColor = ColorGreen.CGColor
        self.guestList.setTitleColor(ColorGreen, forState: UIControlState.Normal)
        self.backgroundColor = ColorSuperLightGrey
        self.edit.layer.borderWidth = 1.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
