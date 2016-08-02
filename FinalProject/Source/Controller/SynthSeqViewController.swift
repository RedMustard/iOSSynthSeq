//
//  SynthSeqViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/30/16.
//
//

import UIKit

class SynthSeqViewController: UIViewController, SWRevealViewControllerDelegate {
    
    // MARK: Reveal View Controller
    func revealControllerPanGestureShouldBegin(revealController: SWRevealViewController!) -> Bool {
        return false
    }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
        
        if revealController != nil {
            // Menu Button and Gestures
            menuButton!.target = revealController
            menuButton!.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(revealController.panGestureRecognizer())
            self.view.addGestureRecognizer(revealController.tapGestureRecognizer())
            
            // Reveal View Controller Init Properties
            revealController.rearViewRevealWidth = 325
            revealController.rearViewRevealOverdraw = 0
            
        }
        
    }
    
    // MARK: Properties
    @IBOutlet var menuButton: UIBarButtonItem?
}
