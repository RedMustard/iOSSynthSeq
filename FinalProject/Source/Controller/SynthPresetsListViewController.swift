//
//  SynthPresetsListViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/1/16.
//
//

import UIKit

class SynthPresetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {
    
    // MARK: Navigation
    @IBAction func goBackToPreviousMenu() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("PresetsViewController"), animated: true)
    }

    
    // TODO: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return synthPresetItemArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SynthPresetCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = synthPresetItemArray[indexPath.row] // PLACEHOLDER
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor(white: 0.2, alpha: 1)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
        
        synthPresetTableView.backgroundColor = UIColor(white: 0.2, alpha: 1)
        synthPresetTableView.separatorColor = UIColor.blackColor()

        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PresetsListViewController.swipeRight(_:)))
        
        recognizer.direction = .Right
        self.view .addGestureRecognizer(recognizer)
    }
    
    
    func swipeRight(recognizer : UISwipeGestureRecognizer) {
        goBackToPreviousMenu()
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
    let synthPresetItemArray: Array<String> = ["Synth Preset 1", "Synth Preset 2", "Synth Preset 3"] // PLACEHOLDER
    @IBOutlet var synthPresetTableView: UITableView!
}
