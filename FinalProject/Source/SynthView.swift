//
//  SynthView.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/8/16.
//
//

import UIKit


class SynthView: UIView {
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
//        addRotaryKnobsToArray()
        initializeRotaryKnobs()
    }
//        rotaryKnobArray = [volRotaryKnob, attackRotaryKnob, decayRotaryKnob, sustainRotaryKnob, releaseRotaryKnob, osc1OctRotaryKnob, osc1VolRotaryKnob, osc1WaveRotaryKnob, osc2OctRotaryKnob, osc2VolRotaryKnob, osc2WaveRotaryKnob]
//        noiseRotaryKnob, resonanceRotaryKnob, cutoffRotaryKnob, slopeRotaryKnob, feedbackRotaryKnob, rateRotaryKnob, amountRotaryKnob
    
    private func addRotaryKnobsToArray() {
        rotaryKnobArray = [volRotaryKnob, attackRotaryKnob, decayRotaryKnob, sustainRotaryKnob, releaseRotaryKnob, osc1OctRotaryKnob, osc1VolRotaryKnob, osc1WaveRotaryKnob, osc2OctRotaryKnob, osc2VolRotaryKnob, osc2WaveRotaryKnob]
//        rotaryKnobArray.append(volRotaryKnob)
//        rotaryKnobArray.append(attackRotaryKnob)
//        rotaryKnobArray.append(decayRotaryKnob)
//        rotaryKnobArray.append(sustainRotaryKnob)
//        rotaryKnobArray.append(releaseRotaryKnob)
//        rotaryKnobArray.append(osc1OctRotaryKnob)
//        rotaryKnobArray.append(osc1VolRotaryKnob)
//        rotaryKnobArray.append(osc1WaveRotaryKnob)
//        rotaryKnobArray.append(osc2OctRotaryKnob)
//        rotaryKnobArray.append(osc2VolRotaryKnob)
//        rotaryKnobArray.append(osc2WaveRotaryKnob)
//        rotaryKnobArray.append(noiseRotaryKnob)
//        rotaryKnobArray.append(resonanceRotaryKnob)
//        rotaryKnobArray.append(cutoffRotaryKnob)
//        rotaryKnobArray.append(slopeRotaryKnob)
//        rotaryKnobArray.append(feedbackRotaryKnob)
//        rotaryKnobArray.append(rateRotaryKnob)
//        rotaryKnobArray.append(amountRotaryKnob)
    }
    
    private func initializeRotaryKnobs() {
        for rotaryKnob in rotaryKnobArray {
            rotaryKnob.interactionStyle = MHRotaryKnobInteractionStyle.SliderVertical
            rotaryKnob.scalingFactor = 1.5
            rotaryKnob.defaultValue = rotaryKnob.value
            rotaryKnob.resetsToDefault = true
            rotaryKnob.backgroundColor = UIColor.clearColor()
            rotaryKnob.backgroundImage = UIImage(imageLiteral: "Knob Background")
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob"), forState: UIControlState.Normal)
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Highlighted"), forState: UIControlState.Highlighted)
            rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Disabled"), forState: UIControlState.Disabled)
            rotaryKnob.knobImageCenter = CGPointMake(80.0, 76.0)
            rotaryKnob.addTarget(self, action: #selector(rotaryKnob.didChangeValueForKey(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    // MARK: Properties
    @IBOutlet var rotaryKnobArray: Array<MHRotaryKnob> = []
    
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
//    @IBOutlet var noiseRotaryKnob: MHRotaryKnob!
//    @IBOutlet var resonanceRotaryKnob: MHRotaryKnob!
//    @IBOutlet var cutoffRotaryKnob: MHRotaryKnob!
//    @IBOutlet var slopeRotaryKnob: MHRotaryKnob!
//    @IBOutlet var feedbackRotaryKnob: MHRotaryKnob!
//    @IBOutlet var rateRotaryKnob: MHRotaryKnob!
//    @IBOutlet var amountRotaryKnob: MHRotaryKnob!
    
    
}
