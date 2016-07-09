//
//  Event.swift
//  Plenry
//
//  Created by NNNO on 6/22/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class Event: UITableViewCell {
    @IBOutlet var outerView: UIView!
    @IBOutlet var eventPic: UIImageView!
    @IBOutlet var theme: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var hostPic: UIImageView!
    @IBOutlet var hostName: UILabel!
    @IBOutlet var hostPicButton: UIButton!
    @IBOutlet var writeReview: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.hostPic.layer.cornerRadius = 35
        self.hostPic.layer.masksToBounds = true
        self.hostPic.layer.borderWidth = 1.0
        self.hostPic.layer.borderColor = ColorLightGrey.CGColor
        self.outerView.layer.borderWidth = 1.0
        self.outerView.layer.borderColor = ColorLightGrey.CGColor
        self.backgroundColor = ColorSuperLightGrey
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
