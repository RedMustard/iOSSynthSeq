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
        initializeRotaryKnobs(rotaryKnobArray)
    }
    
    
    // MARK: Rotary Knob Management
    private func initializeRotaryKnobs(knobArray: Array<MHRotaryKnob>) {
        for rotaryKnob in knobArray {
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
    
    
    func initializeRotaryKnobs(settings: SeqSet) {
        for knob in rotaryKnobArray {
            switch(knob.accessibilityLabel!) {
            case("SequenceRateKnob"):
                knob.value = CGFloat(settings.rate)
            case("SequenceStep1FreqKnob"):
                knob.value = CGFloat(settings.frequency1)
            case("SequenceStep2FreqKnob"):
                knob.value = CGFloat(settings.frequency2)
            case("SequenceStep3FreqKnob"):
                knob.value = CGFloat(settings.frequency3)
            case("SequenceStep4FreqKnob"):
                knob.value = CGFloat(settings.frequency4)
            case("SequenceStep5FreqKnob"):
                knob.value = CGFloat(settings.frequency5)
            case("SequenceStep6FreqKnob"):
                knob.value = CGFloat(settings.frequency6)
            case("SequenceStep7FreqKnob"):
                knob.value = CGFloat(settings.frequency7)
            case("SequenceStep8FreqKnob"):
                knob.value = CGFloat(settings.frequency8)
            case("SequenceStep9FreqKnob"):
                knob.value = CGFloat(settings.frequency9)
            case("SequenceStep10FreqKnob"):
                knob.value = CGFloat(settings.frequency10)
            case("SequenceStep11FreqKnob"):
                knob.value = CGFloat(settings.frequency11)
            case("SequenceStep12FreqKnob"):
                knob.value = CGFloat(settings.frequency12)
            case("SequenceStep13FreqKnob"):
                knob.value = CGFloat(settings.frequency13)
            case("SequenceStep14FreqKnob"):
                knob.value = CGFloat(settings.frequency14)
            case("SequenceStep15FreqKnob"):
                knob.value = CGFloat(settings.frequency15)
            case("SequenceStep16FreqKnob"):
                knob.value = CGFloat(settings.frequency16)
            case(_):
                continue
            }
        }
    }
    
    
    func initializeDefaultRotaryKnobs(settings: DefaultSeqSet) {
        for knob in rotaryKnobArray {
            switch(knob.accessibilityLabel!) {
            case("SequenceRateKnob"):
                knob.value = CGFloat(settings.rate)
            case("SequenceStep1FreqKnob"):
                knob.value = CGFloat(settings.frequency1)
            case("SequenceStep2FreqKnob"):
                knob.value = CGFloat(settings.frequency2)
            case("SequenceStep3FreqKnob"):
                knob.value = CGFloat(settings.frequency3)
            case("SequenceStep4FreqKnob"):
                knob.value = CGFloat(settings.frequency4)
            case("SequenceStep5FreqKnob"):
                knob.value = CGFloat(settings.frequency5)
            case("SequenceStep6FreqKnob"):
                knob.value = CGFloat(settings.frequency6)
            case("SequenceStep7FreqKnob"):
                knob.value = CGFloat(settings.frequency7)
            case("SequenceStep8FreqKnob"):
                knob.value = CGFloat(settings.frequency8)
            case("SequenceStep9FreqKnob"):
                knob.value = CGFloat(settings.frequency9)
            case("SequenceStep10FreqKnob"):
                knob.value = CGFloat(settings.frequency10)
            case("SequenceStep11FreqKnob"):
                knob.value = CGFloat(settings.frequency11)
            case("SequenceStep12FreqKnob"):
                knob.value = CGFloat(settings.frequency12)
            case("SequenceStep13FreqKnob"):
                knob.value = CGFloat(settings.frequency13)
            case("SequenceStep14FreqKnob"):
                knob.value = CGFloat(settings.frequency14)
            case("SequenceStep15FreqKnob"):
                knob.value = CGFloat(settings.frequency15)
            case("SequenceStep16FreqKnob"):
                knob.value = CGFloat(settings.frequency16)
            case(_):
                continue
            }
        }
    }

    
    // MARK: Radio Button Management
    func initializeRadioButtons(settings: SeqSet) {
        for button in radioButtonArray {
            switch(button.accessibilityLabel!) {
            case("SequenceSteps1To8OnButton"):
                button.isTriggered = Bool(settings.step1To8)
            case("SequenceSteps9To16OnButton"):
                button.isTriggered = Bool(settings.step9To16)
            case("SequenceStep1OnButton"):
                button.isTriggered = Bool(settings.step1)
            case("SequenceStep2OnButton"):
                button.isTriggered = Bool(settings.step2)
            case("SequenceStep3OnButton"):
                button.isTriggered = Bool(settings.step3)
            case("SequenceStep4OnButton"):
                button.isTriggered = Bool(settings.step4)
            case("SequenceStep5OnButton"):
                button.isTriggered = Bool(settings.step5)
            case("SequenceStep6OnButton"):
                button.isTriggered = Bool(settings.step6)
            case("SequenceStep7OnButton"):
                button.isTriggered = Bool(settings.step7)
            case("SequenceStep8OnButton"):
                button.isTriggered = Bool(settings.step8)
            case("SequenceStep9OnButton"):
                button.isTriggered = Bool(settings.step9)
            case("SequenceStep10OnButton"):
                button.isTriggered = Bool(settings.step10)
            case("SequenceStep11OnButton"):
                button.isTriggered = Bool(settings.step11)
            case("SequenceStep12OnButton"):
                button.isTriggered = Bool(settings.step12)
            case("SequenceStep13OnButton"):
                button.isTriggered = Bool(settings.step13)
            case("SequenceStep14OnButton"):
                button.isTriggered = Bool(settings.step14)
            case("SequenceStep15OnButton"):
                button.isTriggered = Bool(settings.step15)
            case("SequenceStep16OnButton"):
                button.isTriggered = Bool(settings.step16)
            case(_):
                continue
            }
        }
        
        updateRadioButtons()
    }
    
    
    func initializeDefaultRadioButtons(settings: DefaultSeqSet) {
        for button in radioButtonArray {
            switch(button.accessibilityLabel!) {
            case("SequenceSteps1To8OnButton"):
                button.isTriggered = Bool(settings.step1To8)
            case("SequenceSteps9To16OnButton"):
                button.isTriggered = Bool(settings.step9To16)
            case("SequenceStep1OnButton"):
                button.isTriggered = Bool(settings.step1)
            case("SequenceStep2OnButton"):
                button.isTriggered = Bool(settings.step2)
            case("SequenceStep3OnButton"):
                button.isTriggered = Bool(settings.step3)
            case("SequenceStep4OnButton"):
                button.isTriggered = Bool(settings.step4)
            case("SequenceStep5OnButton"):
                button.isTriggered = Bool(settings.step5)
            case("SequenceStep6OnButton"):
                button.isTriggered = Bool(settings.step6)
            case("SequenceStep7OnButton"):
                button.isTriggered = Bool(settings.step7)
            case("SequenceStep8OnButton"):
                button.isTriggered = Bool(settings.step8)
            case("SequenceStep9OnButton"):
                button.isTriggered = Bool(settings.step9)
            case("SequenceStep10OnButton"):
                button.isTriggered = Bool(settings.step10)
            case("SequenceStep11OnButton"):
                button.isTriggered = Bool(settings.step11)
            case("SequenceStep12OnButton"):
                button.isTriggered = Bool(settings.step12)
            case("SequenceStep13OnButton"):
                button.isTriggered = Bool(settings.step13)
            case("SequenceStep14OnButton"):
                button.isTriggered = Bool(settings.step14)
            case("SequenceStep15OnButton"):
                button.isTriggered = Bool(settings.step15)
            case("SequenceStep16OnButton"):
                button.isTriggered = Bool(settings.step16)
            case(_):
                continue
            }
        }
        
        updateRadioButtons()
    }
    
    
    private func updateRadioButtons() {
        for button in radioButtonArray {
            switch(button.isTriggered) {
            case(false):
                button.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
            case(true):
                button.setImage(UIImage(named: "Radio Button On"), forState: UIControlState.Normal)
            }
        }
        
        switch(step1To8RadioButton.isTriggered) {
        case(false):
            step1To8RadioButton.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
            
            for button in step1To8RadioButtonArray {
                button.enabled = false
            }
        case(true):
            step1To8RadioButton.setImage(UIImage(named: "Radio Button On"), forState: UIControlState.Normal)
            
            for button in step1To8RadioButtonArray {
                button.enabled = true
            }
        }
        
        switch(step9To16RadioButton.isTriggered) {
        case(false):
            step9To16RadioButton.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
            
            for button in step9To16RadioButtonArray {
                button.enabled = false
            }
        case(true):
            step9To16RadioButton.setImage(UIImage(named: "Radio Button On"), forState: UIControlState.Normal)
            
            for button in step9To16RadioButtonArray {
                button.enabled = true
            }
        }
    }
    
    
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
    @IBOutlet var radioButtonArray: [RadioButton]!
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
