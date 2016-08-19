//
//  FullPresetsListViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/1/16.
//
//

import UIKit
import CoreData
import CoreDataService

class FullPresetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, SWRevealViewControllerDelegate {
    
    // MARK: Navigation
    @IBAction func goBackToPreviousMenu() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("PresetsViewController"), animated: true)
    }
    
    
    func reloadCurrentView() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("FullPresetsViewController"), animated: true)
    }
    
    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return resultsController?.sections?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController!.sections![section].numberOfObjects
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let presets = resultsController!.objectAtIndexPath(indexPath) as! Presets
       
        let cell = tableView.dequeueReusableCellWithIdentifier("FullPresetCell", forIndexPath: indexPath)
        cell.textLabel!.text = presets.name
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor(white: 0.2, alpha: 1)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /////////
    //
    //  Compare table bounds and content size in order to enable scrolling dynamically
    //
    //
    
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        ignoreUpdates = true
        
        if let preset = resultsController?.objectAtIndexPath(sourceIndexPath) as? Presets {
            preset.orderIndex = destinationIndexPath.row
            
            if let presets = resultsController?.fetchedObjects as? Array<Presets> {
                let reindexRange: NSRange
                let shiftForward: Bool
                if sourceIndexPath.row > destinationIndexPath.row {
                    reindexRange = NSMakeRange(destinationIndexPath.row, sourceIndexPath.row - destinationIndexPath.row)
                    shiftForward = true
                }
                else {
                    reindexRange = NSMakeRange(sourceIndexPath.row + 1, destinationIndexPath.row - sourceIndexPath.row)
                    shiftForward = false
                }
                
                let subPresets = ((presets as NSArray).subarrayWithRange(reindexRange)) as! Array<Presets>
                do {
                    try PresetService.sharedPresetService.reindexPresets(subPresets, shiftForward: shiftForward, withSaveCompletionHandler: {
                        self.ignoreUpdates = false
                    })
                }
                catch {
                    let alertController = UIAlertController(title: "Move Failed", message: "Failed to move category", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var presetsToReindex: Array<Presets>?
            let numberOfRows = fullPresetTableView.numberOfRowsInSection(0)
            if indexPath.row + 1 < numberOfRows {
                if let presets = resultsController?.fetchedObjects as? Array<Presets> {
                    let reindexRange = NSMakeRange(indexPath.row + 1, numberOfRows - (indexPath.row + 1))
                    presetsToReindex = ((presets as NSArray).subarrayWithRange(reindexRange)) as? Array<Presets>
                }
            }
            
            if let preset = resultsController?.objectAtIndexPath(indexPath) as? Presets {
                let alertController = UIAlertController(title: "Are You Sure?", message: "Are you sure you want to delete this preset?", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) in
                    do {
                        try PresetService.sharedPresetService.deletePreset(preset, withSaveCompletionHandler: {
                            if let somePresets = presetsToReindex {
                                do {
                                    try PresetService.sharedPresetService.reindexPresets(somePresets, shiftForward: false)
                                }
                                catch _ {
                                    let alertController = UIAlertController(title: "Delete Failed", message: "Failed to re-order remaining categories", preferredStyle: .Alert)
                                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                                    self.presentViewController(alertController, animated: true, completion: nil)
                                }
                            }
                        })
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
    
    
    // MARK: NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        if !ignoreUpdates {
            fullPresetTableView.beginUpdates()
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if !ignoreUpdates {
            switch type {
            case .Delete:
                fullPresetTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Left)
            case .Insert:
                fullPresetTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Left)
            case .Move:
                fullPresetTableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
            case .Update:
                if let cell = fullPresetTableView.cellForRowAtIndexPath(indexPath!), let preset = anObject as? Presets {
                    cell.textLabel!.text = preset.name
                }
            }
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        if !ignoreUpdates {
            switch type {
            case .Delete:
                fullPresetTableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Left)
            case .Insert:
                fullPresetTableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Left)
            default:
                print("Unexpected change type in controller:didChangeSection:atIndex:forChangeType:")
            }
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        if !ignoreUpdates {
            fullPresetTableView.endUpdates()
        }
    }
    
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
        
        fullPresetTableView.backgroundColor = UIColor(white: 0.2, alpha: 1)
        fullPresetTableView.separatorColor = UIColor.blackColor()

        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PresetsListViewController.swipeRight(_:)))
        recognizer.direction = .Right
        self.view .addGestureRecognizer(recognizer)
        
        let resultsController = PresetService.sharedPresetService.fetchedResultsControllerForPresets()
        try! resultsController.performFetch()
        self.resultsController = resultsController
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
    
    
    // MARK: Properties (IBOutlet)
    @IBOutlet var fullPresetTableView: UITableView!
    
    // MARK: Properties (Private)
    private var resultsController: NSFetchedResultsController?
    private var ignoreUpdates = false

}
