//
//  SideBarMenuViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/30/16.
//
//

import UIKit

class SideBarMenuViewController: UITableViewController, SWRevealViewControllerDelegate {
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()

        let revealController = self.revealViewController()
        revealController.delegate = self
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let tableViewCellIdentifier = tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier {
        
            switch(tableViewCellIdentifier) {
            case ("PresetsCell"):
//                self.revealViewController().setRearViewController(PresetsListViewController(), animated: true)
                return
            case ("SaveCell"):
                return
            case ("UndoCell"):
                return
            case (_):
                return
            }
        }
        
    }
    
    
    // MARK: Reveal View Controller
    func revealControllerPanGestureShouldBegin(revealController: SWRevealViewController!) -> Bool {
        if revealController.frontViewPosition == FrontViewPosition.Right {
            return true
        } else {
            
            return false
        }
    }
    
//    func revealController(revealController: SWRevealViewController!, willAddViewController viewController: UIViewController!, forOperation operation: SWRevealControllerOperation, animated: Bool) {
//
//    }
    

    @IBOutlet var menuTableView: UITableView!
    

}
