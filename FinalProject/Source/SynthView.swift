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
        for rotaryKnob in rotaryKnobArray {
            rotaryKnob.interactionStyle = MHRotaryKnobInteractionStyle.SliderVertical
            rotaryKnob.defaultValue = rotaryKnob.value
            rotaryKnob.resetsToDefault = true
            rotaryKnob.backgroundColor = UIColor.clearColor()
            rotaryKnob.backgroundImage = UIImage(imageLiteral: "Knob Background")
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob"), forState: UIControlState.Normal)
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Highlighted"), forState: UIControlState.Highlighted)
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Disabled"), forState: UIControlState.Disabled)
            
            if rotaryKnob.accessibilityLabel == "FilterCutoffKnob" {
                rotaryKnob.knobImageCenter = CGPointMake(60.0, 60.0)
            } else {
                rotaryKnob.knobImageCenter = CGPointMake(35.0, 35.0)
            }
            
            rotaryKnob.addTarget(self, action: #selector(rotaryKnob.didChangeValueForKey(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    
    func initializeRotaryKnobs(settings: SynSet) {
        for knob in rotaryKnobArray {
            switch(knob.accessibilityLabel!) {
            case("Osc1OctKnob"):
                knob.value = CGFloat(settings.osc1Oct)
            case("Osc1WaveKnob"):
                knob.value = CGFloat(settings.osc1Wave)
            case("Osc1VolKnob"):
                knob.value = CGFloat(settings.osc1Vol)
            case("Osc2OctKnob"):
                knob.value = CGFloat(settings.osc2Oct)
            case("Osc2WaveKnob"):
                knob.value = CGFloat(settings.osc2Wave)
            case("Osc2VolKnob"):
                knob.value = CGFloat(settings.osc2Vol)
            case("AttackKnob"):
                knob.value = CGFloat(settings.attack)
            case("DecayKnob"):
                knob.value = CGFloat(settings.decay)
            case("SustainKnob"):
                knob.value = CGFloat(settings.sustain)
            case("ReleaseKnob"):
                knob.value = CGFloat(settings.releaseVal)
            case("FilterNoiseKnob"):
                knob.value = CGFloat(settings.noise)
            case("FilterResonanceKnob"):
                knob.value = CGFloat(settings.resonance)
            case("FilterSlopeKnob"):
                knob.value = CGFloat(settings.slope)
            case("FilterFeedbackKnob"):
                knob.value = CGFloat(settings.feedback)
            case("FilterCutoffKnob"):
                knob.value = CGFloat(settings.cutoff)
            case("OutputVolumeKnob"):
                knob.value = CGFloat(settings.volume)
            case("LFORateKnob"):
                knob.value = CGFloat(settings.rate)
            case("LFOAmountKnob"):
                knob.value = CGFloat(settings.amount)
            case(_):
                continue
            }
        }
    }
    
    
    // MARK: Radio Button Management
    @IBAction func triggerRadioButton(button: RadioButton) {
        switch(button.isTriggered) {
        case(true):
            button.isTriggered = false
            button.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
        case(false):
            button.isTriggered = true
            button.setImage(UIImage(named: "Radio Button On"), forState: UIControlState.Normal)
        }
    }
    
    
    func initializeRadioButtons(settings: SynSet) {
        for button in radioButtonArray {
            switch(button.accessibilityLabel!) {
            case("LFOSyncButton"):
                button.isTriggered = Bool(settings.sync)
            case("LFOOsc1Button"):
                button.isTriggered = Bool(settings.osc1)
            case("LFOOsc2Button"):
                button.isTriggered = Bool(settings.osc2)
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
    }
    
    
    // MARK: Properties (IBOutlet)
    @IBOutlet internal var rotaryKnobArray: [MHRotaryKnob]!
    @IBOutlet internal var radioButtonArray: [RadioButton]!
    
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
    @IBOutlet var rateRotaryKnob: MHRotaryKnob!
    @IBOutlet var amountRotaryKnob: MHRotaryKnob!
    
    @IBOutlet var latchRadioButton: RadioButton!
    @IBOutlet var syncRadioButton: RadioButton!
    @IBOutlet var osc1RadioButton: RadioButton!
    @IBOutlet var osc2RadioButton: RadioButton!
}
