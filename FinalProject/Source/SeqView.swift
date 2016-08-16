//
//  SeqView.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/8/16.
//
//

import UIKit


class SeqView: UIView {
    
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
        for rotaryKnob in rotaryKnobArray {
            rotaryKnob.interactionStyle = MHRotaryKnobInteractionStyle.SliderVertical
            rotaryKnob.defaultValue = rotaryKnob.value
            rotaryKnob.resetsToDefault = true
            rotaryKnob.backgroundColor = UIColor.clearColor()
            rotaryKnob.backgroundImage = UIImage(imageLiteral: "Knob Background")
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob"), forState: UIControlState.Normal)
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Highlighted"), forState: UIControlState.Highlighted)
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Disabled"), forState: UIControlState.Disabled)
            
            if rotaryKnob.accessibilityLabel == "SequenceRateKnob" {
                rotaryKnob.knobImageCenter = CGPointMake(60.0, 60.0)
            } else {
                rotaryKnob.knobImageCenter = CGPointMake(30.0, 29.0)
            }
            
            rotaryKnob.addTarget(self, action: #selector(rotaryKnob.didChangeValueForKey(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    
    // MARK: Properties
    @IBOutlet var rotaryKnobArray: [MHRotaryKnob]!

    @IBOutlet var freq1RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq2RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq3RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq4RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq5RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq6RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq7RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq8RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq9RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq10RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq11RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq12RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq13RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq14RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq15RotaryKnob: MHRotaryKnob!
    @IBOutlet var freq16RotaryKnob: MHRotaryKnob!
    @IBOutlet var rateRotaryKnob: MHRotaryKnob!
 
//    @IBOutlet var latchRadioButton: SSRadioButton!
//    @IBOutlet var syncRadioButton: SSRadioButton!
//    @IBOutlet var osc1RadioButton: SSRadioButton!
//    @IBOutlet var osc2RadioButton: SSRadioButton!
//    

    
}
