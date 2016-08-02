//
//  FullPresetsListViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/1/16.
//
//

import UIKit

class FullPresetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {
    
    // MARK: Navigation
    @IBAction func goBackToPreviousMenu() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("PresetsViewController"), animated: true)
    }
    
    
    // TODO: Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullPresetItemArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FullPresetCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = fullPresetItemArray[indexPath.row] // PLACEHOLDER 
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
            return false
        }
    }
    
    
    // MARK: Properties
    let fullPresetItemArray: Array<String> = ["Full Preset 1", "Full Preset 2", "Full Preset 3"] // PLACEHOLDER
    @IBOutlet var fullPresetTableView: UITableView!
}
