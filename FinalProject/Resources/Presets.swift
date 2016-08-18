//
//  Presets.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/17/16.
//
//

import Foundation
import CoreData
import CoreDataService

class Presets: NSManagedObject, NamedEntity {
    // MARK: Properties (NamedEntity)
    static var entityName: String {
        return "Presets"
    }
    
    // MARK: Properties (Core Data Attributes)
    @NSManaged var name: String
    
    // MARK: Properties (Core Data Relationships)
    @NSManaged var sequencerSettings: SeqSet
    @NSManaged var synthesizerSettings: SynSet
}
