//
//  Default.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/20/16.
//
//

import Foundation
import CoreData
import CoreDataService

class DefaultPreset: NSManagedObject, NamedEntity {
    // MARK: Properties (NamedEntity)
    static var entityName: String {
        return "DefaultPreset"
    }
    
    // MARK: Properties (Core Data Attributes)
    @NSManaged var name: String
    
    // MARK: Properties (Core Data Relationships)
    @NSManaged var defaultSeqSettings: DefaultSeqSet
    @NSManaged var defaultSynthSettings: DefaultSynSet
}
