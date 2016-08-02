//
//  SideBarMenuViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/30/16.
//
//

import UIKit

class SideBarMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,SWRevealViewControllerDelegate {
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()

        let revealController = self.revealViewController()
        revealController.delegate = self
    }
    
    
    // MARK: Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath)
        
        // Configure the cell...
//        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        cell.textLabel!.text = menuItemArray[indexPath.row]
        
        if menuItemArray[indexPath.row] == "Presets" {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let tableViewCellIdentifier = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text {
        
            switch(tableViewCellIdentifier) {
            case ("Presets"):
                self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("PresetsViewController"), animated: true)
//                return
            case ("Save"):
                
                return
            case ("Undo"):
                
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

    // MARK: Properties
    let menuItemArray: Array<String> = ["Presets", "Save", "Undo"]
    @IBOutlet var menuTableView: UITableView!
}
