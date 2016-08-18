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
                rotaryKnob.knobImageCenter = CGPointMake(30.0, 30.0)
            }
            
            rotaryKnob.addTarget(self, action: #selector(rotaryKnob.didChangeValueForKey(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    
    // MARK: Radio Button Management
    @IBAction func triggerRadioButton(button: RadioButton) {
        switch(button.accessibilityLabel!, button.isTriggered) {
        case("SequenceSteps1To8OnButton", true):
            button.isTriggered = false
            button.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
            
            for button in step1To8RadioButtonArray {
                button.enabled = false
            }
        case("SequenceSteps1To8OnButton", false):
            button.isTriggered = true
            button.setImage(UIImage(named: "Radio Button On"), forState: UIControlState.Normal)
            for button in step1To8RadioButtonArray {
                button.enabled = true
            }
        case("SequenceSteps9To16OnButton", true):
            button.isTriggered = false
            button.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
            
            for button in step9To16RadioButtonArray {
                button.enabled = false
            }
        case("SequenceSteps9To16OnButton", false):
            button.isTriggered = true
            button.setImage(UIImage(named: "Radio Button On"), forState: UIControlState.Normal)
            for button in step9To16RadioButtonArray {
                button.enabled = true
            }
        case(_, true):
            button.isTriggered = false
            button.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
        case(_, false):
            button.isTriggered = true
            button.setImage(UIImage(named: "Radio Button On"), forState: UIControlState.Normal)
        }
    }
    
    // MARK: Properties (IBOutlet)
    @IBOutlet var rotaryKnobArray: [MHRotaryKnob]!
    @IBOutlet var step1To8RadioButtonArray: [RadioButton]!
    @IBOutlet var step9To16RadioButtonArray: [RadioButton]!

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
 
    @IBOutlet var step1To8RadioButton: RadioButton!
    @IBOutlet var step9To16RadioButton: RadioButton!
    @IBOutlet var step1RadioButton: RadioButton!
    @IBOutlet var step2RadioButton: RadioButton!
    @IBOutlet var step3RadioButton: RadioButton!
    @IBOutlet var step4RadioButton: RadioButton!
    @IBOutlet var step5RadioButton: RadioButton!
    @IBOutlet var step6RadioButton: RadioButton!
    @IBOutlet var step7RadioButton: RadioButton!
    @IBOutlet var step8RadioButton: RadioButton!
    @IBOutlet var step9RadioButton: RadioButton!
    @IBOutlet var step10RadioButton: RadioButton!
    @IBOutlet var step11RadioButton: RadioButton!
    @IBOutlet var step12RadioButton: RadioButton!
    @IBOutlet var step13RadioButton: RadioButton!
    @IBOutlet var step14RadioButton: RadioButton!
    @IBOutlet var step15RadioButton: RadioButton!
    @IBOutlet var step16RadioButton: RadioButton!
}
