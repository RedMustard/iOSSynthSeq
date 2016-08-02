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
    @IBOutlet var menuButton: UIBarButtonItem?
}
