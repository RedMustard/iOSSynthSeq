//
//  rotaryUIControlRenderer.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/7/16.
//
//
//  Implementation credit:
//      https://www.raywenderlich.com/82058/custom-control-tutorial-ios-swift-reusable-knob


import UIKit
import UIKit.UIGestureRecognizerSubclass

class RotaryUIControlRenderer {
    init() {
        trackLayer.fillColor = UIColor.clearColor().CGColor
        pointerLayer.fillColor = UIColor.clearColor().CGColor
    }
    
    
    
    // MARK: Rendering
    func setPointerAngle(pointerAngle: CGFloat, animated: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        pointerLayer.transform = CATransform3DMakeRotation(pointerAngle, 0.0, 0.0, 0.1)
        
        if animated {
            let midAngle = (max(pointerAngle, self.pointerAngle) - min(pointerAngle, self.pointerAngle) ) / 2.0 + min(pointerAngle, self.pointerAngle)
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.duration = 0.25
            
            animation.values = [self.pointerAngle, midAngle, pointerAngle]
            animation.keyTimes = [0.0, 0.5, 1.0]
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pointerLayer.addAnimation(animation, forKey: nil)
        }
        
        CATransaction.commit()
        
        self.backingPointerAngle = pointerAngle
    }
    
    
    func updateTrackLayerPath() {
        let arcCenter = CGPoint(x: trackLayer.bounds.width / 2.0, y: trackLayer.bounds.height / 2.0)
        let offset = max(pointerLength, trackLayer.lineWidth / 2.0)
        let radius = min(trackLayer.bounds.height, trackLayer.bounds.width) / 2.0 - offset;
        trackLayer.path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
    }
    
    
    func updatePointerLayerPath() {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: pointerLayer.bounds.width - pointerLength - pointerLayer.lineWidth / 2.0, y: pointerLayer.bounds.height / 2.0))
        path.addLineToPoint(CGPoint(x: pointerLayer.bounds.width, y: pointerLayer.bounds.height / 2.0))
        pointerLayer.path = path.CGPath
    }
    
    
    func update() {
        trackLayer.lineWidth = lineWidth
        pointerLayer.lineWidth = lineWidth
        
        updateTrackLayerPath()
        updatePointerLayerPath()
    }
    
    
    func update(bounds: CGRect) {
        let position = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        
        trackLayer.bounds = bounds
        trackLayer.position = position
        
        pointerLayer.bounds = bounds
        pointerLayer.position = position
        
        update()
    }
    
    
    // MARK: Properties
    var strokeColor: UIColor {
        get {
            return UIColor(CGColor: trackLayer.strokeColor!)
        }
        
        set(strokeColor) {
            trackLayer.strokeColor = strokeColor.CGColor
            pointerLayer.strokeColor = strokeColor.CGColor
        }
    }
    
    var lineWidth: CGFloat = 1.0 {
        didSet { update() }
    }
    
    var startAngle: CGFloat = 0.0 {
        didSet { update() }
    }
    
    var endAngle: CGFloat = 0.0 {
        didSet { update() }
    }
    
    var pointerLength: CGFloat = 0.0 {
        didSet { update() }
    }
    
    var pointerAngle: CGFloat {
        get { return backingPointerAngle }
        set { setPointerAngle(newValue, animated: false) }
    }
    
    let trackLayer = CAShapeLayer()
    let pointerLayer = CAShapeLayer()
    var backingPointerAngle: CGFloat = 0.0
}



