//
//  CDFeedTableViewCell.swift
//  Cached
//
//  Created by Daniel on 3/6/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class CDFeedTableViewCell: UITableViewCell {
    
    let kCardViewInset:CGFloat = 10
    
    
    var cardView = UIView.newAutoLayoutView()
    var titleLabel = UIView.newAutoLayoutView()
    
    
    var didSetupConstraints = false
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    
    
    func setupViews() {
        
        // We are creating a rounded corner view to serve as the background
        // of the cell so we need to make the real cell background clear.
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        
        
        // Set up Card View - rounded corner cell background
        cardView.backgroundColor = UIColor.cdWhite()
        cardView.layer.cornerRadius = 8.0
        cardView.layer.borderWidth = 0.5
        cardView.layer.borderColor = UIColor.cdLightGray().CGColor
        
        addSubview(cardView)
        
        //TODO: Set up Title Label
        
    }
    
    
    override func updateConstraints() {
        if !didSetupConstraints {
            
            // Setup Card View Auto Layout
            cardView.autoPinEdgeToSuperviewEdge(.Top)
            cardView.autoPinEdgeToSuperviewEdge(.Leading, withInset: kCardViewInset)
            cardView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: kCardViewInset)
            cardView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: kCardViewInset)
            
            // 
            
            
            didSetupConstraints = true
            
        }
        
        super.updateConstraints()
    }
    
}
