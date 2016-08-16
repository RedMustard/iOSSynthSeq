//
//  SideBarMenuViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/30/16.
//
//

import UIKit

class SideBarMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,SWRevealViewControllerDelegate {
    
    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = menuItemArray[indexPath.row]
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor(white: 0.2, alpha: 1)
        
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
            case ("Save"):
                return
            case ("Undo"):
                return
            case (_):
                return
            }
        }
    }
    
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
        
        menuTableView.backgroundColor = UIColor(white: 0.2, alpha: 1)
        menuTableView.separatorColor = UIColor.blackColor()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    // MARK: SWRevealViewControllerDelegate
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
