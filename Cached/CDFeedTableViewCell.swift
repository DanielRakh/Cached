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
    let kInnerViewInset:CGFloat = 8
    
    
    var cardView = UIView.newAutoLayoutView()
    var titleLabel = UILabel.newAutoLayoutView()
    var infoLabel = UILabel.newAutoLayoutView()
    var commentsButton = CDThinLineButton.newAutoLayoutView()
    
    
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
        
        contentView.addSubview(cardView)
        
        // Set up Title Label
        titleLabel.lineBreakMode = .ByTruncatingTail
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Left
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14.0)
        
        cardView.addSubview(titleLabel)
        
        // Set up Info Label
        infoLabel.lineBreakMode = .ByTruncatingTail
        infoLabel.numberOfLines = 1
        infoLabel.textAlignment = .Left
        infoLabel.font = UIFont(name: "AvenirNext-Regular", size: 10.0)
        
        cardView.addSubview(infoLabel)
        
        // Set up Comments Button
        cardView.addSubview(commentsButton)
    }
    
    
    override func updateConstraints() {
        if !didSetupConstraints {
            
            // Card View Constraints
            cardView.autoPinEdgeToSuperviewEdge(.Top)
            cardView.autoPinEdgeToSuperviewEdge(.Leading, withInset: kCardViewInset)
            cardView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: kCardViewInset)
            UIView.autoSetPriority(750) {
                         cardView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: kCardViewInset)
            }
   
            // Title Label Constraints
            UIView.autoSetPriority(1000) {
                self.titleLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
            }
            titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: kInnerViewInset)
            titleLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: kInnerViewInset)
            titleLabel.autoPinEdgeToSuperviewEdge(.Trailing, withInset: kInnerViewInset)
            
            // Comments Button Constraints
            commentsButton.autoSetDimensionsToSize(CGSizeMake(84, 26))
            commentsButton.autoPinEdgeToSuperviewEdge(.Trailing, withInset: kCardViewInset)
            commentsButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: kCardViewInset)
            commentsButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 14.0, relation: .Equal)

            // Info Label Constraints
            infoLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: titleLabel)
            infoLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: commentsButton)
            
            didSetupConstraints = true
            
        }
        
        super.updateConstraints()
    }
    
}
