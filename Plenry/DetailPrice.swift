//
//  DetailPrice.swift
//  Plenry
//
//  Created by NNNO on 8/21/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class DetailPrice: UITableViewCell {

    @IBOutlet var type: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var perPerson: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.type.textColor = ColorGrey
        self.perPerson.textColor = ColorGrey
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
