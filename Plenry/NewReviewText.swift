//
//  NewReviewText.swift
//  Plenry
//
//  Created by NNNO on 8/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class NewReviewText: UITableViewCell {

    @IBOutlet var type: UILabel!
    @IBOutlet var summary: UILabel!
    @IBOutlet var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
