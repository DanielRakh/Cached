//
//  RefreshView.swift
//  RefreshControlDemo
//
//  Created by Daniel on 3/20/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import pop


protocol DRRefreshViewDelegate {
    
    func refreshViewDidRefresh(refreshView:DRRefreshView)
}


enum DRRingAnimationScale:CGFloat {
    
    case Down = 0
    case Identity = 1
    case Up = 1.3
}

class DRRefreshView: UIView {
    
    private unowned let scrollView: UIScrollView
    private let solidRingShapeLayer:DRRingShapeLayer
    private let gradientRingShapeLayer:DRRingGradientLayer
    
    var upperScrollLimit:CGFloat = 140
    var lowerScrollLimit:CGFloat = 64
    
    
    var delegate:DRRefreshViewDelegate?
    var isRefreshing = false
    
    
    required init(coder aDecoder: NSCoder) {
        self.scrollView = UIScrollView()
        solidRingShapeLayer =  DRRingShapeLayer(size:(w:24, h:24), strokeWidth: 3, strokeColor: UIColor.cdOrange())
        gradientRingShapeLayer = DRRingGradientLayer(shape: solidRingShapeLayer, colors: (UIColor.cdOrange(), UIColor(red:0.988, green:0.400 , blue:0.129, alpha: 0.1)))
        super.init(coder: aDecoder)
        assert(false, "use init(frame:scrollView:")
    }
    
    required init(frame:CGRect, scrollView:UIScrollView)  {
        self.scrollView = scrollView
        solidRingShapeLayer =  DRRingShapeLayer(size:(w:24, h:24), strokeWidth: 3, strokeColor: UIColor.cdOrange())
        gradientRingShapeLayer = DRRingGradientLayer(shape: solidRingShapeLayer, colors: (UIColor.cdOrange(), UIColor(red:0.988, green:0.400 , blue:0.129, alpha: 0.1)))
        
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        backgroundColor = UIColor.cdOffWhite()
        solidRingShapeLayer.ringDelegate = self
        gradientRingShapeLayer.opacity = 0
        
        layer.addSublayer(solidRingShapeLayer)
        layer.addSublayer(gradientRingShapeLayer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        solidRingShapeLayer.position = CGPoint(x: bounds.width / 2, y: bounds.height - solidRingShapeLayer.bounds.height)
        gradientRingShapeLayer.position = solidRingShapeLayer.position
    }
    
    
    private func beginRefreshing() {
        isRefreshing = true
        self.gradientRingShapeLayer.opacity = 1
        self.solidRingShapeLayer.opacity = 0
        rotateRing()
        scaleRingUp()
    }
    
    func endRefreshing() {
        isRefreshing = false
        scaleRingDown()
        collapseScrollView(scrollView)
    }
    
    
    private func expandScrollView(scrollView:UIScrollView) {
        UIView.animateWithDuration(0.35,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                scrollView.contentInset.top = self.upperScrollLimit
            }) { (sucess:Bool) -> Void in
                //
        }
    }
    
    private func collapseScrollView(scrollView:UIScrollView) {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            scrollView.contentInset.top = self.lowerScrollLimit
            scrollView.contentOffset.y = -self.lowerScrollLimit
            }) { (success:Bool) -> Void in
                self.resetSpinner()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
    }
    
    private func scaleRingUp() {
        
        scaleRing(.Up, spring: false) {
            self.scaleRing(.Identity, spring: true) {}
        }
    }
    
    private func scaleRingDown() {
        scaleRing(.Down, spring: false){}
    }
    
    
    private func resetSpinner() {
        self.solidRingShapeLayer.opacity = 1.0
        self.gradientRingShapeLayer.opacity = 0
        self.gradientRingShapeLayer.transform = CATransform3DMakeScale(1, 1, 1)
        self.solidRingShapeLayer.transform = CATransform3DMakeScale(1, 1, 1)
        self.gradientRingShapeLayer.pop_removeAllAnimations()
        self.solidRingShapeLayer.pop_removeAllAnimations()
    }
    
    private func rotateRing() {
        let spinAnimation:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        spinAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        spinAnimation.fromValue = -90 * CGFloat(M_PI / 180) // -90 Deg
        spinAnimation.toValue = 270 * CGFloat(M_PI / 180) // 270 Deg
        spinAnimation.repeatForever = true
        spinAnimation.duration = 1.0
        spinAnimation.delegate = self
        gradientRingShapeLayer.pop_addAnimation(spinAnimation, forKey: "spin")
    }
    
    private func scaleRing(type:DRRingAnimationScale, spring:Bool, completion:()->()) {
        
        let scaleAnimation:POPPropertyAnimation
        if spring {
            scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            (scaleAnimation as! POPSpringAnimation).springBounciness = CGFloat(20)
            (scaleAnimation as! POPSpringAnimation).springSpeed = CGFloat(4)
        } else {
            scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
            (scaleAnimation as! POPBasicAnimation).duration = 0.15
            
        }
        
        scaleAnimation.toValue = NSValue(CGPoint: CGPoint(x: type.rawValue, y: type.rawValue))
        scaleAnimation.removedOnCompletion = true
        
        solidRingShapeLayer.pop_addAnimation(scaleAnimation, forKey: "scaleRing\(type)")
        gradientRingShapeLayer.pop_addAnimation(scaleAnimation, forKey: "scaleGradient\(type)")
        
        scaleAnimation.completionBlock = { (anim:POPAnimation!, finished:Bool) in
            completion()
        }
    }
}

/// We're not really conforming to the delegate. We're just forwarding the methods from the actual delegate to have the scollview respond accrodingly to the UI of the spinner.

extension DRRefreshView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if !isRefreshing {
            //Make sure we're not already refreshing.
            let contentOffset = min(upperScrollLimit, -scrollView.contentOffset.y)
            
            
            if contentOffset >= lowerScrollLimit && contentOffset <= upperScrollLimit {
                
                let scrollArea = upperScrollLimit - lowerScrollLimit
                let progress = (contentOffset - lowerScrollLimit) / scrollArea
                
                solidRingShapeLayer.strokeEnd = progress
                
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isRefreshing {
            expandScrollView(scrollView)
        }
    }
}


extension DRRefreshView : DRRingShapeLayerDelegate {
    func ringIsFullyCompleted() {
        if !isRefreshing {
            beginRefreshing()
            delegate?.refreshViewDidRefresh(self)
        }
    }
}





