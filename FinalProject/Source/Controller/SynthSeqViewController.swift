//
//  SynthSeqViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/30/16.
//
//

import UIKit
import CoreData
import CoreDataService

class SynthSeqViewController: UIViewController, NSFetchedResultsControllerDelegate, SWRevealViewControllerDelegate {
    
    // MARK: UIViewController
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
        
        
        let resultsController = DefaultPresetService.sharedPresetService.fetchedResultsControllerForDefaultPreset()
        try! resultsController.performFetch()
        self.resultsController = resultsController

        loadDefaultPreset()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        saveDefaultPreset()
        
    }
    
    
    // MARK: Default Preset Management
    private func loadDefaultPreset() {
        if let preset = resultsController?.fetchedObjects?.first as? DefaultPreset {
            print("Default Preset Loaded")
            synthView.initializeDefaultRadioButtons(preset.defaultSynthSettings)
            synthView.initializeDefaultRotaryKnobs(preset.defaultSynthSettings)
            seqView.initializeDefaultRadioButtons(preset.defaultSeqSettings)
            seqView.initializeDefaultRotaryKnobs(preset.defaultSeqSettings)
        }
    }
    
    
    private func saveDefaultPreset() {
        let synthRotaryKnobArray = synthView.rotaryKnobArray
        let synthRadioButtonArray = synthView.radioButtonArray
        let seqRotaryKnobArray = seqView.rotaryKnobArray
        let seqRadioButtonArray = seqView.radioButtonArray
        
        if let preset = resultsController?.fetchedObjects?.first as? DefaultPreset {
            do {
                try DefaultPresetService.sharedPresetService.updateDefaultPreset(preset, synthRotaryKnobArray: synthRotaryKnobArray, synthRadioButtonArray: synthRadioButtonArray, seqRotaryKnobArray: seqRotaryKnobArray, seqRadioButtonArray: seqRadioButtonArray)
            } catch _ {
                ("Failed to update")
            }
        } else {
            do {
                try DefaultPresetService.sharedPresetService.addDefaultPreset(synthRotaryKnobArray, synthRadioButtonArray: synthRadioButtonArray, seqRotaryKnobArray: seqRotaryKnobArray, seqRadioButtonArray: seqRadioButtonArray)
                
            } catch _ {
                print("Failed to save")
            }
        }
    }

    
    // MARK: SWRevealViewControllerDelegate
    func revealControllerPanGestureShouldBegin(revealController: SWRevealViewController!) -> Bool {
        return false
    }
    
    
    func setRearViewToMenuController() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"), animated: true)
    }
    
    
    @IBAction func toggleRearViewController() {
        setRearViewToMenuController()
        self.revealViewController().revealToggle(self)
        synthView.userInteractionEnabled = false
        seqView.userInteractionEnabled = false
    }
    
    
    // MARK: Properties (IBOutlet)
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet internal var synthView: SynthView!
    @IBOutlet var seqView: SeqView!
    
    
    // MARK: Properties (Private)
    private var resultsController: NSFetchedResultsController?
    
}
