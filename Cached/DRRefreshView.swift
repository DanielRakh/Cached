//
//  RefreshView.swift
//  RefreshControlDemo
//
//  Created by Daniel on 3/20/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit

protocol DRRefreshViewDelegate {
    
    func refreshViewDidRefresh(refreshView:DRRefreshView)
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
    
    
    private func expandScrollView(scrollView:UIScrollView) {
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            scrollView.contentInset.top = self.upperScrollLimit
            }) { (success:Bool) -> Void in
        }
    }
    
    private func collapseScrollView(scrollView:UIScrollView) {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            scrollView.contentInset.top = self.lowerScrollLimit
            scrollView.contentOffset.y = -self.lowerScrollLimit
            }) { (success:Bool) -> Void in
                self.revealSolidSpinner()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }
    }
    
    
    private func revealSolidSpinner() {
        self.solidRingShapeLayer.opacity = 1.0
        self.gradientRingShapeLayer.opacity = 0
        self.gradientRingShapeLayer.removeAllAnimations()
    }
    
    private func rotateRing() {
        
        println("Rotate")

        let rotationAtStart: AnyObject? = gradientRingShapeLayer.valueForKeyPath("transform.rotation")
        let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation")
        rotationAnimation.duration = 1.0
        rotationAnimation.fromValue = rotationAtStart
        rotationAnimation.toValue = (3 * M_PI) / 2
        rotationAnimation.repeatCount = 100
        
        gradientRingShapeLayer.applyBasicAnimation(rotationAnimation, toLayer: gradientRingShapeLayer)
    }
    
    private func scaleRing() {
        
        
    }
    
    func beginRefreshing() {
        isRefreshing = true
        self.gradientRingShapeLayer.opacity = 1
        self.solidRingShapeLayer.opacity = 0
        rotateRing()
    }
    
    func endRefreshing() {
        isRefreshing = false
        solidRingShapeLayer.transform = CATransform3DMakeScale(1 , 1, 0)
        gradientRingShapeLayer.transform = CATransform3DMakeScale(1 , 1 , 0)
        collapseScrollView(scrollView)
    }
    
    private func resetSpinner() {
        self.solidRingShapeLayer.opacity = 1.0
        self.gradientRingShapeLayer.opacity = 0
        self.gradientRingShapeLayer.removeAllAnimations()
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
                solidRingShapeLayer.transform = CATransform3DMakeScale(1 + (progress/8), 1 + (progress/8), 0)
                gradientRingShapeLayer.transform = CATransform3DMakeScale(1 + (progress/8), 1 + (progress/8), 0)

                
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
            solidRingShapeLayer.transform = CATransform3DMakeScale(1 , 1, 0)
            gradientRingShapeLayer.transform = CATransform3DMakeScale(1 , 1 , 0)
            beginRefreshing()
            delegate?.refreshViewDidRefresh(self)
        }
    }
}





