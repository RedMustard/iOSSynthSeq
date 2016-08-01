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
    
    
    func revealControllerPanGestureShouldBegin(revealController: SWRevealViewController!) -> Bool {
        if revealController.frontViewPosition == FrontViewPosition.Right {
            return true
        } else {
            revealController.setRearViewController(SideBarMenuViewController(), animated: true)
            return false
        }
    }

//    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
//        <#code#>
//    }
    
    @IBOutlet var presetTableView: UITableView!
}