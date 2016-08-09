//
//  SynthView.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/8/16.
//
//

import UIKit


class SynthView: UIView {
    
    // MARK: UIView
    override required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        initializeRotaryKnobs()
    }
    
    
    // MARK: Rotary Knob Management
    private func initializeRotaryKnobs() {
        print(rotaryKnobArray)
        
        for rotaryKnob in rotaryKnobArray {
            rotaryKnob.interactionStyle = MHRotaryKnobInteractionStyle.SliderVertical
            rotaryKnob.scalingFactor = 2
            rotaryKnob.defaultValue = rotaryKnob.value
            rotaryKnob.resetsToDefault = true
            rotaryKnob.backgroundColor = UIColor.clearColor()
            rotaryKnob.backgroundImage = UIImage(imageLiteral: "Knob Background")
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob"), forState: UIControlState.Normal)
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Highlighted"), forState: UIControlState.Highlighted)
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Disabled"), forState: UIControlState.Disabled)
            if rotaryKnob.accessibilityLabel == "CutoffKnob" {
                print("true")
                rotaryKnob.knobImageCenter = CGPointMake(60.0, 60.0)
            } else {
                rotaryKnob.knobImageCenter = CGPointMake(35.0, 35.0)
            }
            rotaryKnob.addTarget(self, action: #selector(rotaryKnob.didChangeValueForKey(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    
    // MARK: Properties
    @IBOutlet var rotaryKnobArray: [MHRotaryKnob]!
    
    @IBOutlet var volRotaryKnob: MHRotaryKnob!
    @IBOutlet var attackRotaryKnob: MHRotaryKnob!
    @IBOutlet var decayRotaryKnob: MHRotaryKnob!
    @IBOutlet var sustainRotaryKnob: MHRotaryKnob!
    @IBOutlet var releaseRotaryKnob: MHRotaryKnob!
    @IBOutlet var osc1OctRotaryKnob: MHRotaryKnob!
    @IBOutlet var osc1VolRotaryKnob: MHRotaryKnob!
    @IBOutlet var osc1WaveRotaryKnob: MHRotaryKnob!
    @IBOutlet var osc2OctRotaryKnob: MHRotaryKnob!
    @IBOutlet var osc2VolRotaryKnob: MHRotaryKnob!
    @IBOutlet var osc2WaveRotaryKnob: MHRotaryKnob!
    @IBOutlet var noiseRotaryKnob: MHRotaryKnob!
    @IBOutlet var resonanceRotaryKnob: MHRotaryKnob!
    @IBOutlet var cutoffRotaryKnob: MHRotaryKnob!
    @IBOutlet var slopeRotaryKnob: MHRotaryKnob!
    @IBOutlet var feedbackRotaryKnob: MHRotaryKnob!
//    @IBOutlet var rateRotaryKnob: MHRotaryKnob!
//    @IBOutlet var amountRotaryKnob: MHRotaryKnob!
    
    
}