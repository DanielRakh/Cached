//
//  DRRingGradientLayer.swift
//  RefreshControlDemo
//
//  Created by Daniel on 3/21/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class DRRingGradientLayer: AngleGradientLayer {
    
    ///*** THESE ARE METHODS TO KEEP THE COMPILER HAPPY BECAUSE SWIFT ***///
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init!(layer: AnyObject!) {
        super.init(layer: layer)
    }
    ///*****************************************************************///
    
    
    required init(shape:CAShapeLayer, colors:(startColor:UIColor, endColor:UIColor)) {
        super.init()
        setup(shape: shape, colors: colors)
    }
    
    func setup(#shape:CAShapeLayer, colors:(startColor:UIColor, endColor:UIColor)){
        
        let maskShape = DRRingShapeLayer(size: (w: shape.bounds.size.width, h: shape.bounds.size.height),
            strokeWidth: shape.lineWidth,
            strokeColor: UIColor(CGColor: shape.strokeColor)!)
        maskShape.strokeEnd = 1

        self.frame = CGRectMake(0, 0, maskShape.bounds.width, maskShape.bounds.height)
        self.backgroundColor = UIColor.clearColor().CGColor
        self.colors = [colors.startColor.CGColor, colors.endColor.CGColor]
        self.masksToBounds = true
        self.mask = maskShape
        self.mask.frame = bounds
        self.transform = CATransform3DMakeRotation(-CGFloat(M_PI_2), CGFloat(0), CGFloat(0), CGFloat(1))
    }
   
}


