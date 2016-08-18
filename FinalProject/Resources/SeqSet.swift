//
//  SeqSet.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/17/16.
//
//

import Foundation
import CoreData
import CoreDataService


class SeqSet: NSManagedObject, NamedEntity {
    // MARK: Properties (NamedEntity)
    static var entityName: String {
        return "SeqSet"
    }

    // MARK: Properties (Core Data Attributes)
    @NSManaged var rate: NSNumber
    @NSManaged var step1To8: NSNumber
    @NSManaged var step9To16: NSNumber
    @NSManaged var frequency1: NSNumber
    @NSManaged var frequency2: NSNumber
    @NSManaged var frequency3: NSNumber
    @NSManaged var frequency4: NSNumber
    @NSManaged var frequency5: NSNumber
    @NSManaged var frequency6: NSNumber
    @NSManaged var frequency7: NSNumber
    @NSManaged var frequency8: NSNumber
    @NSManaged var frequency9: NSNumber
    @NSManaged var frequency10: NSNumber
    @NSManaged var frequency11: NSNumber
    @NSManaged var frequency12: NSNumber
    @NSManaged var frequency13: NSNumber
    @NSManaged var frequency14: NSNumber
    @NSManaged var frequency15: NSNumber
    @NSManaged var frequency16: NSNumber
    @NSManaged var step1: NSNumber
    @NSManaged var step2: NSNumber
    @NSManaged var step3: NSNumber
    @NSManaged var step4: NSNumber
    @NSManaged var step5: NSNumber
    @NSManaged var step6: NSNumber
    @NSManaged var step7: NSNumber
    @NSManaged var step8: NSNumber
    @NSManaged var step9: NSNumber
    @NSManaged var step10: NSNumber
    @NSManaged var step11: NSNumber
    @NSManaged var step12: NSNumber
    @NSManaged var step13: NSNumber
    @NSManaged var step14: NSNumber
    @NSManaged var step15: NSNumber
    @NSManaged var step16: NSNumber
    @NSManaged var orderIndex: NSNumber
    @NSManaged var name: String
}

