//
//  PresetsViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/31/16.
//
//

import UIKit

class PresetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {
    
    // MARK: Navigation
    @IBAction func goBackToPreviousMenu() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"), animated: true)
    }

    
    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presetsItemArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PresetsCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = presetsItemArray[indexPath.row]
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.backgroundColor = UIColor(white: 0.2, alpha: 1)

        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let tableViewCellIdentifier = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text {
            
            switch(tableViewCellIdentifier) {
            case ("Full Presets"):
                self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("FullPresetsViewController"), animated: true)
            
            case ("Synth Presets"):
                self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("SynthPresetsViewController"), animated: true)

            case ("Sequences"):
                self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("SequencesViewController"), animated: true)

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
        
        presetTableView.backgroundColor = UIColor(white: 0.2, alpha: 1)
        presetTableView.separatorColor = UIColor.blackColor()
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PresetsListViewController.swipeRight(_:)))
        recognizer.direction = .Right
        self.view .addGestureRecognizer(recognizer)
    }
    
    
    func swipeRight(recognizer : UISwipeGestureRecognizer) {
        goBackToPreviousMenu()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
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
    let presetsItemArray: Array<String> = ["Full Presets", "Synth Presets", "Sequences"]
    @IBOutlet var presetTableView: UITableView!
}