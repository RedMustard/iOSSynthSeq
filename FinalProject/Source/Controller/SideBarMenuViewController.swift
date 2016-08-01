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
        
        let tableViewCellIdentifier = tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier
        
        switch(tableViewCellIdentifier) {
        case ("PresetsCell"?):
            return
        case ("SaveCell"?):
            return
        case ("UndoCell"?):
            return
        case (_):
            return
        }
        
    }
    

    
    
    @IBOutlet var menuTableView: UITableView!
    

}
