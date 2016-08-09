//
//  rotaryUIControl.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/7/16.
//
//
//  Implementation credit:
//      https://www.raywenderlich.com/82058/custom-control-tutorial-ios-swift-reusable-knob

import UIKit

class RotaryUIControl: UIControl {
    // MARK: UIControl
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSublayers()
        
        let gr = RotationGestureRecognizer(target: self, action: #selector(RotaryUIControl.handleRotation(_:)))
        self.addGestureRecognizer(gr)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Rotary
    var currentRotaryValue: Float {
        get { return backingValue }
        set { setRotaryValue(newValue, animated: false) }
    }
    
    
    func setRotaryValue(value: Float, animated: Bool) {
        if value != self.rotaryValue {
            // Save the value to the backing value
            // Make sure we limit it to the requested bounds
            self.backingValue = min(self.maximumRotaryValue, max(self.minimumRotaryValue, value))
            
            // Now let's update the knob with the correct angle
            let angleRange = endAngle - startAngle
            let valueRange = CGFloat(maximumRotaryValue - minimumRotaryValue)
            let angle = CGFloat(value - minimumRotaryValue) / valueRange * angleRange + startAngle
            rotaryRenderer.setPointerAngle(angle, animated: animated)
        }
    }
    
    
    func createSublayers() {
        rotaryRenderer.update(bounds)
        rotaryRenderer.strokeColor = tintColor
        rotaryRenderer.startAngle = -CGFloat(M_PI * 11.0 / 8.0)
        rotaryRenderer.endAngle = CGFloat(M_PI * 3.0 / 8.0)
        rotaryRenderer.pointerAngle = rotaryRenderer.startAngle
        rotaryRenderer.lineWidth = 2.0
        rotaryRenderer.pointerLength = 6.0
        
        layer.addSublayer(rotaryRenderer.trackLayer)
        layer.addSublayer(rotaryRenderer.pointerLayer)
    }
    
    
    func handleRotation(sender: AnyObject) {
        let gr = sender as! RotationGestureRecognizer
        
        // 1. Mid-point angle
        let midPointAngle = (2.0 * CGFloat(M_PI) + self.startAngle - self.endAngle) / 2.0 + self.endAngle
        
        // 2. Ensure the angle is within a suitable range
        var boundedAngle = gr.rotation
        if boundedAngle > midPointAngle {
            boundedAngle -= 2.0 * CGFloat(M_PI)
        } else if boundedAngle < (midPointAngle - 2.0 * CGFloat(M_PI)) {
            boundedAngle += 2 * CGFloat(M_PI)
        }
        
        // 3. Bound the angle to within the suitable range
        boundedAngle = min(self.endAngle, max(self.startAngle, boundedAngle))
        
        // 4. Convert the angle to a value
        let angleRange = endAngle - startAngle
        let valueRange = maximumRotaryValue - minimumRotaryValue
        let valueForAngle = Float(boundedAngle - startAngle) / Float(angleRange) * valueRange + minimumRotaryValue
        
        // 5. Set the control to this value
        self.backingValue = valueForAngle
        
        // Notify of value change
        if continuous {
            sendActionsForControlEvents(.ValueChanged)
        } else {
            // Only send an update if the gesture has completed
            if (gr.state == UIGestureRecognizerState.Ended) || (gr.state == UIGestureRecognizerState.Cancelled) {
                sendActionsForControlEvents(.ValueChanged)
            }
        }
    }
    
    
    //MARK: Renderer Properties
    /** Specifies the angle of the start of the knob control track. Defaults to -11π/8 */
    var startAngle: CGFloat {
        get { return rotaryRenderer.startAngle }
        set { rotaryRenderer.startAngle = newValue }
    }
    
    /** Specifies the end angle of the knob control track. Defaults to 3π/8 */
    var endAngle: CGFloat {
        get { return rotaryRenderer.endAngle }
        set { rotaryRenderer.endAngle = newValue }
    }
    
    /** Specifies the width in points of the knob control track. Defaults to 2.0 */
    var lineWidth: CGFloat {
        get { return rotaryRenderer.lineWidth }
        set { rotaryRenderer.lineWidth = newValue }
    }
    
    /** Specifies the length in points of the pointer on the knob. Defaults to 6.0 */
    var pointerLength: CGFloat {
        get { return rotaryRenderer.pointerLength }
        set { rotaryRenderer.pointerLength = newValue }
    }
    
    var strokeColor: UIColor {
        get { return rotaryRenderer.strokeColor}
        set { rotaryRenderer.strokeColor = newValue }
    }
    
    
    // MARK: Properties
    private var backingValue: Float = 0.0
    var minimumRotaryValue: Float = 0.0
    var maximumRotaryValue: Float = 1.0
    
    var rotaryValue: Float {
        get { return backingValue }
        set { setRotaryValue(newValue, animated: false) }
    }
    
    /** Contains a Boolean value indicating whether changes
     in the sliders value generate continuous update events. */
    var continuous = true
    
    private let rotaryRenderer = RotaryUIControlRenderer()
}


private class RotationGestureRecognizer: UIPanGestureRecognizer {
    var rotation: CGFloat = 0.0

    override init(target: AnyObject?, action: Selector) {
        super.init(target: target, action: action)
        minimumNumberOfTouches = 1
        maximumNumberOfTouches = 1
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        updateRotationWithTouches(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        updateRotationWithTouches(touches)
    }
    
    func updateRotationWithTouches(touches: Set<UITouch>) {
        let touch = touches[touches.startIndex]
            self.rotation = rotationForLocation(touch.locationInView(self.view))
        
    }
    
    func rotationForLocation(location: CGPoint) -> CGFloat {
        let offset = CGPoint(x: location.x - view!.bounds.midX, y: location.y - view!.bounds.midY)
        return atan2(offset.y, offset.x)
    }
}