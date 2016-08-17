//
//  RadioButtonController.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/15/16.
//
//

import UIKit

class RadioButtonController: UIButton {
    required init?(coder aDecoder: NSCoder) {
        self.isTriggered = false
        super.init(coder: aDecoder)
        
        self.setImage(UIImage(named: "Radio Button Off"), forState: UIControlState.Normal)
    }
    
    
    // MARK: Properties
    var isTriggered: Bool
}