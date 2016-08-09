//
//  SynthSeqViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/30/16.
//
//

import UIKit

class SynthSeqViewController: UIViewController, SWRevealViewControllerDelegate {
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
        
        if revealController != nil {
            self.view.addGestureRecognizer(revealController.panGestureRecognizer())
            self.view.addGestureRecognizer(revealController.tapGestureRecognizer())
            
            // Reveal View Controller Init Properties
            revealController.rearViewRevealWidth = 325
            revealController.rearViewRevealOverdraw = 0
            
        }
        
//        rotaryKnob.interactionStyle = MHRotaryKnobInteractionStyle.SliderVertical
//        rotaryKnob.scalingFactor = 1.5
//        rotaryKnob.defaultValue = rotaryKnob.value
//        rotaryKnob.resetsToDefault = true
//        rotaryKnob.backgroundColor = UIColor.clearColor()
//        rotaryKnob.backgroundImage = UIImage(imageLiteral: "Knob Background")
//        rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob"), forState: UIControlState.Normal)
//        rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Highlighted"), forState: UIControlState.Highlighted)
//        rotaryKnob.setKnobImage(UIImage(imageLiteral: "Knob Disabled"), forState: UIControlState.Disabled)
//        rotaryKnob.knobImageCenter = CGPointMake(80.0, 76.0)
//        rotaryKnob.addTarget(self, action: #selector(rotaryKnob.didChangeValueForKey(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    // MARK: Reveal View Controller
    func revealControllerPanGestureShouldBegin(revealController: SWRevealViewController!) -> Bool {
        return false
    }
    
    
    func setRearViewToMenuController() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"), animated: true)
    }
    
    
    @IBAction func toggleRearViewController() {
        setRearViewToMenuController()
        self.revealViewController().revealToggle(self)
    }
    
    
    // MARK: Properties
    @IBOutlet var menuButton: UIBarButtonItem!
    
//    @IBOutlet var knobPlaceholder: UIView!
    @IBOutlet var synthView: SynthView!
    
//    var rotaryKnob: RotaryUIControl!
}
