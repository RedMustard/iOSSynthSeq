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
        
        switch(menuItemArray[indexPath.row]) {
        case("Presets"):
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        case("Undo"):
            if undoManager?.canUndo == false {
                cell.textLabel?.enabled = false
                cell.userInteractionEnabled = false
            }
        case("Redo"):
            if undoManager?.canRedo == false {
                cell.textLabel?.enabled = false
                cell.userInteractionEnabled = false
            }
        case(_):
            break
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let tableViewCellIdentifier = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text {
            switch(tableViewCellIdentifier) {
            case("Presets"):
                self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("PresetsViewController"), animated: true)
            case("Save"):
                saveAlert(self)

            case("Undo"):
                undoManager?.undo()
            self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"), animated: true)
        
            case("Redo"):
                undoManager?.redo()
            self.revealViewController().setRearViewController(storyboard?.instantiateViewControllerWithIdentifier("MenuViewController"), animated: true)
            
            case (_):
                return
            }
        }
    }
    
    
    // MARK: Data Management
    private func saveAlert(sender: AnyObject) {
        let alertController = UIAlertController(title: "Save Preset", message: "Enter the name of the preset:", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action) in
            if let presetName = alertController.textFields![0].text {
                self.saveCurrentSettings(presetName)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) in

        }))
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Preset Name"
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    private func saveCurrentSettings(presetName: String) {
        if let synthViewController = self.revealViewController().frontViewController.childViewControllers.first as? SynthSeqViewController {
            let synthRotaryKnobArray = synthViewController.synthView.rotaryKnobArray
            let synthRadioButtonArray = synthViewController.synthView.radioButtonArray
            let seqRotaryKnobArray = synthViewController.seqView.rotaryKnobArray
            let seqRadioButtonArray = synthViewController.seqView.radioButtonArray
            
            do {
                try PresetService.sharedPresetService.addPresetWithName(presetName, synthRotaryKnobArray: synthRotaryKnobArray, synthRadioButtonArray: synthRadioButtonArray, seqRotaryKnobArray: seqRotaryKnobArray, seqRadioButtonArray: seqRadioButtonArray)
                
            } catch _ {
                print("Failed to save")
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
    
    
    override func viewWillDisappear(animated: Bool) {
        if let synthSeqViewController = self.revealViewController().frontViewController.childViewControllers.first as? SynthSeqViewController {
            synthSeqViewController.synthView.userInteractionEnabled = true
            synthSeqViewController.seqView.userInteractionEnabled = true
        }
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
    let menuItemArray: Array<String> = ["Presets", "Save", "Undo", "Redo"]
    
    // MARK: Properties (IBOutlet)
    @IBOutlet var menuTableView: UITableView!
}
