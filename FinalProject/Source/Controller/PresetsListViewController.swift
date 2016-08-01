//
//  PresetsViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/31/16.
//
//

import UIKit

class PresetsListViewController: UITableViewController, SWRevealViewControllerDelegate {
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
    }
    
    
    @IBOutlet var presetTableView: UITableView!
}