//
//  SideBarMenuViewController.swift
//  FinalProject
//
//  Created by Travis Barnes on 7/30/16.
//
//

import UIKit

class SideBarMenuViewController: UITableViewController {
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        if let menuTableViewIndex = menuTableView.indexPathForSelectedRow {
//            print(menuTableViewIndex)
////            print(indexPath)
//            tableView.deselectRowAtIndexPath(menuTableViewIndex, animated: true)
//        }
//
//    }
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let menuTableViewIndex = menuTableView.indexPathForSelectedRow {
//            print(menuTableViewIndex)
//            menuTableView.deselectRowAtIndexPath(menuTableViewIndex, animated: true)
//        }
//    }
    
    
    
    @IBOutlet var menuTableView: UITableView!

}
