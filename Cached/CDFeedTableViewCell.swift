//
//  CDFeedTableViewCell.swift
//  Cached
//
//  Created by Daniel on 3/6/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class CDFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        cardView.backgroundColor = UIColor.cdWhite()
        cardView.layer.cornerRadius = 8.0
        cardView.layer.borderWidth = 0.5
        cardView.layer.borderColor = UIColor.cdLightGray().CGColor
    }
    
}
