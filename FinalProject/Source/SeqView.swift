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
    
    
    // MARK: Radio Button Management
    @IBAction func triggerRadioButton(button: RadioButtonController) {
        switch(button.isTriggered) {
        case(true):
            button.isTriggered = false
            button.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
        case(false):
            button.isTriggered = true
            button.setImage(UIImage(named: "Radio Button On"), forState: UIControlState.Normal)
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
 
    @IBOutlet var step1To8RadioButton: RadioButtonController!
    @IBOutlet var step9To16RadioButton: RadioButtonController!
    @IBOutlet var step1RadioButton: RadioButtonController!
    @IBOutlet var step2RadioButton: RadioButtonController!
    @IBOutlet var step3RadioButton: RadioButtonController!
    @IBOutlet var step4RadioButton: RadioButtonController!
    @IBOutlet var step5RadioButton: RadioButtonController!
    @IBOutlet var step6RadioButton: RadioButtonController!
    @IBOutlet var step7RadioButton: RadioButtonController!
    @IBOutlet var step8RadioButton: RadioButtonController!
    @IBOutlet var step9RadioButton: RadioButtonController!
    @IBOutlet var step10RadioButton: RadioButtonController!
    @IBOutlet var step11RadioButton: RadioButtonController!
    @IBOutlet var step12RadioButton: RadioButtonController!
    @IBOutlet var step13RadioButton: RadioButtonController!
    @IBOutlet var step14RadioButton: RadioButtonController!
    @IBOutlet var step15RadioButton: RadioButtonController!
    @IBOutlet var step16RadioButton: RadioButtonController!
    
    

    
}
