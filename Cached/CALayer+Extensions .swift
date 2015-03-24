//
//  CALayer+Extensions .swift
//  RefreshControlDemo
//
//  Created by Daniel on 3/22/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import QuartzCore


extension CALayer {
    
    func applyBasicAnimation(animation:CABasicAnimation, toLayer layer:CALayer) {
        //set the from value (using presentation layer if available)
        
        if let presentationLayer:AnyObject = layer.presentationLayer() {
            animation.fromValue = presentationLayer.valueForKeyPath(animation.keyPath)
            println("if")
        } else {
            println("else")
            animation.fromValue = layer.valueForKeyPath(animation.keyPath)
        }
        
        //update the property in advance
        //note: this approach will only work if toValue != nil
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        layer.setValue(animation.toValue, forKeyPath: animation.keyPath)
        CATransaction.commit()
        
        layer.addAnimation(animation, forKey: nil)
        
    }
    
}

