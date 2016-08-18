//
//  SequencesListViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/1/16.
//
//

import UIKit
import CoreData
import CoreDataService

class SequencesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {
    
    // MARK: Navigation
    @IBAction func goBackToPreviousMenu() {
        self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("PresetsViewController"), animated: true)
    }

    
    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return resultsController?.sections?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController!.sections![section].numberOfObjects
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let presets = resultsController!.objectAtIndexPath(indexPath) as! SeqSet
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SequenceCell", forIndexPath: indexPath)
        cell.textLabel!.text = presets.name
        cell.textLabel!.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor(white: 0.2, alpha: 1)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
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
            var presetsToReindex: Array<SeqSet>?
            let numberOfRows = sequencesTableView.numberOfRowsInSection(0)
            if indexPath.row + 1 < numberOfRows {
                if let presets = resultsController?.fetchedObjects as? Array<SeqSet> {
                    let reindexRange = NSMakeRange(indexPath.row + 1, numberOfRows - (indexPath.row + 1))
                    presetsToReindex = ((presets as NSArray).subarrayWithRange(reindexRange)) as? Array<SeqSet>
                }
            }
            
            if let preset = resultsController?.objectAtIndexPath(indexPath) as? SeqSet {
                do {
                    try PresetService.sharedPresetService.deleteSeqPreset(preset, withSaveCompletionHandler: {
                        if let somePresets = presetsToReindex {
                            do {
                                try PresetService.sharedPresetService.reindexSeqPresets(somePresets, shiftForward: false)
                            }
                            catch _ {
                                let alertController = UIAlertController(title: "Delete Failed", message: "Failed to re-order remaining categories", preferredStyle: .Alert)
                                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                                self.presentViewController(alertController, animated: true, completion: nil)
                            }
                        }
                    })
                    self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("SequencesViewController"), animated: true)
                }
                catch _ {
                    let alertController = UIAlertController(title: "Delete Failed", message: "Failed to delete category", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    // MARK: NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        if !ignoreUpdates {
            sequencesTableView.beginUpdates()
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if !ignoreUpdates {
            switch type {
            case .Delete:
                sequencesTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Left)
            case .Insert:
                sequencesTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Left)
            case .Move:
                sequencesTableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
            case .Update:
                if let cell = sequencesTableView.cellForRowAtIndexPath(indexPath!), let preset = anObject as? SeqSet {
                    cell.textLabel!.text = preset.name
                }
            }
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        if !ignoreUpdates {
            switch type {
            case .Delete:
                sequencesTableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Left)
            case .Insert:
                sequencesTableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Left)
            default:
                print("Unexpected change type in controller:didChangeSection:atIndex:forChangeType:")
            }
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        if !ignoreUpdates {
            sequencesTableView.endUpdates()
        }
    }
    
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealController = self.revealViewController()
        revealController.delegate = self
        
        sequencesTableView.backgroundColor = UIColor(white: 0.2, alpha: 1)
        sequencesTableView.separatorColor = UIColor.blackColor()
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PresetsListViewController.swipeRight(_:)))
        recognizer.direction = .Right
        self.view .addGestureRecognizer(recognizer)
        
        let resultsController = PresetService.sharedPresetService.fetchedResultsControllerForSeqPreset()
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
    @IBOutlet var sequencesTableView: UITableView!
    
    // MARK: Properties (Private)
    private var resultsController: NSFetchedResultsController?
    private var ignoreUpdates = false
}
