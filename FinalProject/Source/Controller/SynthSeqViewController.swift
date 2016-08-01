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
            // Gestures
            menuButton!.target = revealController
            menuButton!.action = #selector(SWRevealViewController.revealToggle(_:))

            self.view.addGestureRecognizer(revealController.panGestureRecognizer())
            self.view.addGestureRecognizer(revealController.tapGestureRecognizer())
            
            // Reveal View Controller Init Properties
            revealController.rearViewRevealWidth = 325
            revealController.rearViewRevealOverdraw = 0
            
        }
        
    }
    
    func revealControllerPanGestureShouldBegin(revealController: SWRevealViewController!) -> Bool {
        return false
    }
    
    
    @IBOutlet var menuButton: UIBarButtonItem?
}
