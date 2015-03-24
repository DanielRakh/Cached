//
//  CDThinLineButton.swift
//  Cached
//
//  Created by Daniel on 3/6/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit


class CDThinLineButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        
        backgroundColor = UIColor.clearColor()
        layer.cornerRadius = 4.0
        layer.borderColor = UIColor.cdOrange().CGColor
        layer.borderWidth = 0.5
        titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 10.0)
        setTitleColor(UIColor.cdOrange(), forState: .Normal)
        setTitle("10 Comments", forState: .Normal)
    }
    
}
