//
//  DRRingLayer.swift
//  RefreshControlDemo
//
//  Created by Daniel on 3/20/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit

protocol DRRingShapeLayerDelegate {
    
    func ringIsFullyCompleted()
    
}

class DRRingShapeLayer: CAShapeLayer {
    
    override var strokeEnd: CGFloat {
        willSet {
//            println("New Val \(newValue)")
            if newValue >= 0.99 {
                // Tell the delegate we've completed the full circle.
//                println(strokeEnd)
                self.ringDelegate?.ringIsFullyCompleted()
            }
        }
    }
    
    var ringDelegate:DRRingShapeLayerDelegate?

    
    ///*** THESE ARE METHODS TO KEEP THE COMPILER HAPPY BECAUSE SWIFT ***///
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assert(false, "use init(frame:lineWidth:")
    }
    
    override init!(layer: AnyObject!) {
        super.init(layer: layer)
    }
    ///*****************************************************************///


    
    required init(size:(w:CGFloat, h:CGFloat), strokeWidth:CGFloat, strokeColor:UIColor) {
        super.init()
        setup(size: size, width: strokeWidth, color: strokeColor)
    }
    


    func setup(#size:(w:CGFloat, h:CGFloat), width:CGFloat, color: UIColor) {
        
        bounds = CGRectMake(0, 0, size.w, size.h)
        lineWidth = width
        fillColor = UIColor.clearColor().CGColor
        strokeColor = color.CGColor
        strokeEnd = 0
        path = ringPath()
        
    }
    
    func ringPath() -> CGPathRef {
        
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let radius = CGRectGetMidX(bounds) - lineWidth / 2
        let startAngle = -90 * CGFloat(M_PI / 180) //DEG -> RAD
        let endAngle = 270 * CGFloat(M_PI / 180)
        
        return UIBezierPath(arcCenter: center, radius:radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        
    }
}

