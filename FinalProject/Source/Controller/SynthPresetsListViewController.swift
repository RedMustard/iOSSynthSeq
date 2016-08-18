//
//  SynthPresetsListViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/1/16.
//
//

import UIKit
import CoreData
import CoreDataService

class SynthPresetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {
    
    // MARK: Navigation
    @IBAction func goBackToPreviousMenu() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("PresetsViewController"), animated: true)
    }

    
    // TODO: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return resultsController?.sections?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController!.sections![section].numberOfObjects
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let presets = resultsController!.objectAtIndexPath(indexPath) as! SynSet
        let cell = tableView.dequeueReusableCellWithIdentifier("SynthPresetCell", forIndexPath: indexPath)
        cell.textLabel!.text = presets.name
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor(white: 0.2, alpha: 1)
        
        return cell
        //        let cell = tableView.dequeueReusableCellWithIdentifier("SynthPresetCell", forIndexPath: indexPath)
//        
//        cell.textLabel!.text = synthPresetItemArray[indexPath.row] // PLACEHOLDER
//        cell.textLabel!.textColor = UIColor.whiteColor()
//        cell.backgroundColor = UIColor(white: 0.2, alpha: 1)
//        
//        return cell
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
        
        // These need to be init before table view will populate
//        let resultsController = PresetService.sharedPresetService.fetchedResultsControllerForSynthPreset()
//        try! resultsController.performFetch()
//        self.resultsController = resultsController
    }
    
    
    func swipeRight(recognizer : UISwipeGestureRecognizer) {
        goBackToPreviousMenu()
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
    let synthPresetItemArray: Array<String> = ["Synth Preset 1", "Synth Preset 2", "Synth Preset 3"] // PLACEHOLDER
    @IBOutlet var synthPresetTableView: UITableView!
    
    private var resultsController: NSFetchedResultsController?
}
