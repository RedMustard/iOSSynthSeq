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
    
    func reloadCurrentView() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("SynthPresetsViewController"), animated: true)
    }

    
    // MARK: UITableViewDelegate
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
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let preset = resultsController?.objectAtIndexPath(indexPath) as? SynSet {
            if let synthViewController = self.revealViewController().frontViewController.childViewControllers.first as? SynthSeqViewController {
                synthViewController.synthView.initializeRadioButtons(preset)
                synthViewController.synthView.initializeRotaryKnobs(preset)
            }
        }
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let preset = resultsController?.objectAtIndexPath(indexPath) as? SynSet {
                let alertController = UIAlertController(title: "Delete the preset?", message: "If you delete this preset, it will remove the corresponding Full Preset.\n\n Are you sure you wish to delete this preset?", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) in
                    do {
                        try PresetService.sharedPresetService.deleteSynthPreset(preset, withSaveCompletionHandler: {})
                        self.reloadCurrentView()
                    }
                    catch _ {
                        let alertController = UIAlertController(title: "Delete Failed", message: "Failed to delete category", preferredStyle: .Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }))
                
                alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
                presentViewController(alertController, animated: true, completion: nil)

            }
        }
    }

    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
        
        synthPresetTableView.backgroundColor = UIColor(white: 0.2, alpha: 1)
        synthPresetTableView.separatorColor = UIColor.blackColor()
        synthPresetTableView.alwaysBounceVertical = false

        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PresetsListViewController.swipeRight(_:)))
        recognizer.direction = .Right
        self.view .addGestureRecognizer(recognizer)
        
        let resultsController = PresetService.sharedPresetService.fetchedResultsControllerForSynthPreset()
        try! resultsController.performFetch()
        self.resultsController = resultsController
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
    
    
    // MARK: Properties (IBOutlet)
    @IBOutlet var synthPresetTableView: UITableView!
    
    // MARK: Properties (Private)
    private var resultsController: NSFetchedResultsController?
}
