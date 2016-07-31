//
//  SynthSeqViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/30/16.
//
//

import UIKit

class SynthSeqViewController: UIViewController {
    
//    @IBAction func 
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton!.target = self.revealViewController()
            menuButton!.action = #selector(SWRevealViewController.revealToggle(_:))
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    @IBOutlet var menuButton: UIBarButtonItem?
}
