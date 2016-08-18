//
//  SynSet.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/17/16.
//
//

import Foundation
import CoreData
import CoreDataService


class SynSet: NSManagedObject, NamedEntity {
    // MARK: Properties (NamedEntity)
    static var entityName: String {
        return "SynSet"
    }
    
    // MARK: Properties (Core Data Attributes)
    @NSManaged var osc1Oct: NSNumber
    @NSManaged var osc1Wave: NSNumber
    @NSManaged var osc1Vol: NSNumber
    @NSManaged var osc2Oct: NSNumber
    @NSManaged var osc2Wave: NSNumber
    @NSManaged var osc2Vol: NSNumber
    @NSManaged var attack: NSNumber
    @NSManaged var decay: NSNumber
    @NSManaged var sustain: NSNumber
    @NSManaged var releaseVal: NSNumber
    @NSManaged var latch: NSNumber
    @NSManaged var volume: NSNumber
    @NSManaged var noise: NSNumber
    @NSManaged var resonance: NSNumber
    @NSManaged var cutoff: NSNumber
    @NSManaged var slope: NSNumber
    @NSManaged var feedback: NSNumber
    @NSManaged var rate: NSNumber
    @NSManaged var amount: NSNumber
    @NSManaged var sync: NSNumber
    @NSManaged var osc1: NSNumber
    @NSManaged var osc2: NSNumber
    @NSManaged var name: String
}
