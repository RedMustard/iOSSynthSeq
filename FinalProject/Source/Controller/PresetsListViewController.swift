//
//  PresetsViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/31/16.
//
//

import UIKit

class PresetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {
    
    // MARK: Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PresetsCell", forIndexPath: indexPath)
        
        // Configure the cell...
        //        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        cell.textLabel!.text = presetsItemArray[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
    }
    
    
    // MARK: Reveal View Controller
    func revealControllerPanGestureShouldBegin(revealController: SWRevealViewController!) -> Bool {
        if revealController.frontViewPosition == FrontViewPosition.Right {
            return true
        } else {
            revealController.setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"), animated: true)
            return false
        }
    }

    
    // MARK: Properties
    let presetsItemArray: Array<String> = ["Full Presets", "Synth Presets", "Sequences"]
    @IBOutlet var presetTableView: UITableView!
}