//
//  PresetService.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/17/16.
//
//

import CoreData
import CoreDataService
import Foundation

class PresetService {
    // MARK: Initialization
    private init() {
        let presetDataPath = NSBundle.mainBundle().pathForResource("PresetData", ofType: "plist")!
        let presetData = NSArray(contentsOfFile: presetDataPath) as! Array<Dictionary<String, AnyObject>>
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        context.performBlockAndWait {
            let fetchRequest = NSFetchRequest(namedEntity: Presets.self)
            if context.countForFetchRequest(fetchRequest, error: nil) == 0 {
                for element in presetData {
                    let presetName = element["PresetName"] as! String
                    
                    let preset = NSEntityDescription.insertNewObjectForNamedEntity(Presets.self, inManagedObjectContext: context)
                    preset.name = presetName
                }
                
                try! context.save()
                CoreDataService.sharedCoreDataService.saveRootContext {
                    print("Successfully saved preset data")
                }
            }
        }
    }
    
    
    // MARK: Service
    func fetchedResultsControllerForPresets() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: Presets.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    func addPresetWithName(name: String) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let preset = NSEntityDescription.insertNewObjectForNamedEntity(Presets.self, inManagedObjectContext: context)
        preset.name = name
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Add preset save finished")
        }
    }
    
    func deletePreset(preset: Presets, withSaveCompletionHandler saveCompletionHandler: SaveCompletionHandler) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        context.deleteObject(preset)
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Delete full preset save finished")
            
            saveCompletionHandler()
        }
    }
    
    
    func reindexPresets(presets: Array<Presets>, shiftForward: Bool, withSaveCompletionHandler saveCompletionHandler: SaveCompletionHandler? = nil) throws {
    
        for preset in presets {
            let currentOrderIndex = preset.orderIndex.integerValue
            if shiftForward {
                preset.orderIndex = currentOrderIndex + 1
            }
            else {
                preset.orderIndex = currentOrderIndex - 1
            }
        }
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Reindex full preset save finished")
            
            saveCompletionHandler?()
        }
    }
    
    
    func fetchedResultsControllerForSynthPreset() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: SynSet.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }

    
    func addSynthPresetWithName(name: String, rotaryKnobArray: Array<MHRotaryKnob>, radioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        let synthPreset = NSEntityDescription.insertNewObjectForNamedEntity(SynSet.self, inManagedObjectContext: context)
        
        synthPreset.name = name + " Synth"
        
        for rotaryKnob in rotaryKnobArray {
            switch(rotaryKnob.accessibilityLabel!) {
            case("Osc1OctKnob"):
                synthPreset.osc1Oct = rotaryKnob.value
            case("Osc1WaveKnob"):
                synthPreset.osc1Wave = rotaryKnob.value
            case("Osc1VolKnob"):
                synthPreset.osc1Vol = rotaryKnob.value
            case("Osc2OctKnob"):
                synthPreset.osc2Oct = rotaryKnob.value
            case("Osc2WaveKnob"):
                synthPreset.osc2Wave = rotaryKnob.value
            case("Osc2VolKnob"):
                synthPreset.osc2Vol = rotaryKnob.value
            case("AttackKnob"):
                synthPreset.attack = rotaryKnob.value
            case("DecayKnob"):
                synthPreset.decay = rotaryKnob.value
            case("SustainKnob"):
                synthPreset.sustain = rotaryKnob.value
            case("ReleaseKnob"):
                synthPreset.releaseVal = rotaryKnob.value
            case("FilterNoiseKnob"):
                synthPreset.noise = rotaryKnob.value
            case("FilterResonanceKnob"):
                synthPreset.resonance = rotaryKnob.value
            case("FilterSlopeKnob"):
                synthPreset.slope = rotaryKnob.value
            case("FilterFeedbackKnob"):
                synthPreset.feedback = rotaryKnob.value
            case("FilterCutoffKnob"):
                synthPreset.cutoff = rotaryKnob.value
            case("LFORateKnob"):
                synthPreset.rate = rotaryKnob.value
            case("LFOAmountKnob"):
                synthPreset.amount = rotaryKnob.value
            case("OutputVolumeKnob"):
                synthPreset.volume = rotaryKnob.value
            case(_):
                continue
            }
        }
        
        for radioButton in radioButtonArray {
            switch(radioButton.accessibilityLabel!) {
            case("LFOSyncButton"):
                synthPreset.sync = radioButton.isTriggered
            case("LFOOsc1Button"):
                synthPreset.osc1 = radioButton.isTriggered
            case("LFOOsc2Button"):
                synthPreset.osc2 = radioButton.isTriggered
            case(_):
                continue
            }
        }
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Add synth preset save finished")
        }
    }
    
    func deleteSynthPreset(preset: SynSet, withSaveCompletionHandler saveCompletionHandler: SaveCompletionHandler) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        context.deleteObject(preset)
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Delete synth preset save finished")
            
            saveCompletionHandler()
        }
    }
    
    
    func reindexSynthPresets(presets: Array<SynSet>, shiftForward: Bool, withSaveCompletionHandler saveCompletionHandler: SaveCompletionHandler? = nil) throws {
        
        for preset in presets {
            let currentOrderIndex = preset.orderIndex.integerValue
            if shiftForward {
                preset.orderIndex = currentOrderIndex + 1
            }
            else {
                preset.orderIndex = currentOrderIndex - 1
            }
        }
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Reindex synth preset save finished")
            
            saveCompletionHandler?()
        }
    }
    
    
    func fetchedResultsControllerForSeqPreset() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: SeqSet.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    func addSeqPresetWithName(name: String, rotaryKnobArray: Array<MHRotaryKnob>, radioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let seqPreset = NSEntityDescription.insertNewObjectForNamedEntity(SeqSet.self, inManagedObjectContext: context)
        seqPreset.name = name + " Sequence"
        
        for rotaryKnob in rotaryKnobArray {
            switch(rotaryKnob.accessibilityLabel!) {
            case("SequenceStep1FreqKnob"):
                seqPreset.frequency1 = rotaryKnob.value
            case("SequenceStep2FreqKnob"):
                seqPreset.frequency2 = rotaryKnob.value
            case("SequenceStep3FreqKnob"):
                seqPreset.frequency3 = rotaryKnob.value
            case("SequenceStep4FreqKnob"):
                seqPreset.frequency4 = rotaryKnob.value
            case("SequenceStep5FreqKnob"):
                seqPreset.frequency5 = rotaryKnob.value
            case("SequenceStep6FreqKnob"):
                seqPreset.frequency6 = rotaryKnob.value
            case("SequenceStep7FreqKnob"):
                seqPreset.frequency7 = rotaryKnob.value
            case("SequenceStep8FreqKnob"):
                seqPreset.frequency8 = rotaryKnob.value
            case("SequenceStep9FreqKnob"):
                seqPreset.frequency9 = rotaryKnob.value
            case("SequenceStep10FreqKnob"):
                seqPreset.frequency10 = rotaryKnob.value
            case("SequenceStep11FreqKnob"):
                seqPreset.frequency11 = rotaryKnob.value
            case("SequenceStep12FreqKnob"):
                seqPreset.frequency12 = rotaryKnob.value
            case("SequenceStep13FreqKnob"):
                seqPreset.frequency13 = rotaryKnob.value
            case("SequenceStep14FreqKnob"):
                seqPreset.frequency14 = rotaryKnob.value
            case("SequenceStep15FreqKnob"):
                seqPreset.frequency15 = rotaryKnob.value
            case("SequenceStep16FreqKnob"):
                seqPreset.frequency16 = rotaryKnob.value
            case("SequenceRateKnob"):
                seqPreset.rate = rotaryKnob.value
            case(_):
                continue
            }
        }
        
        for radioButton in radioButtonArray {
            switch(radioButton.accessibilityLabel!) {
            case("SequenceStep1OnButton"):
                seqPreset.step1 = radioButton.isTriggered
            case("SequenceStep2OnButton"):
                seqPreset.step2 = radioButton.isTriggered
            case("SequenceStep3OnButton"):
                seqPreset.step3 = radioButton.isTriggered
            case("SequenceStep4OnButton"):
                seqPreset.step4 = radioButton.isTriggered
            case("SequenceStep5OnButton"):
                seqPreset.step5 = radioButton.isTriggered
            case("SequenceStep6OnButton"):
                seqPreset.step6 = radioButton.isTriggered
            case("SequenceStep7OnButton"):
                seqPreset.step7 = radioButton.isTriggered
            case("SequenceStep8OnButton"):
                seqPreset.step8 = radioButton.isTriggered
            case("SequenceStep9OnButton"):
                seqPreset.step9 = radioButton.isTriggered
            case("SequenceStep10OnButton"):
                seqPreset.step10 = radioButton.isTriggered
            case("SequenceStep11OnButton"):
                seqPreset.step11 = radioButton.isTriggered
            case("SequenceStep12OnButton"):
                seqPreset.step12 = radioButton.isTriggered
            case("SequenceStep13OnButton"):
                seqPreset.step13 = radioButton.isTriggered
            case("SequenceStep14OnButton"):
                seqPreset.step14 = radioButton.isTriggered
            case("SequenceStep15OnButton"):
                seqPreset.step15 = radioButton.isTriggered
            case("SequenceStep16OnButton"):
                seqPreset.step16 = radioButton.isTriggered

            case("SequenceSteps1To8OnButton"):
                seqPreset.step1To8 = radioButton.isTriggered
            case("SequenceSteps9To16OnButton"):
                seqPreset.step9To16 = radioButton.isTriggered
            case(_):
                continue
            }
        }
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Add sequence preset save finished")
        }
    }
    
    func deleteSeqPreset(preset: SeqSet, withSaveCompletionHandler saveCompletionHandler: SaveCompletionHandler) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        context.deleteObject(preset)
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Delete synth preset save finished")
            
            saveCompletionHandler()
        }
    }
    
    
    func reindexSeqPresets(presets: Array<SeqSet>, shiftForward: Bool, withSaveCompletionHandler saveCompletionHandler: SaveCompletionHandler? = nil) throws {
        
        for preset in presets {
            let currentOrderIndex = preset.orderIndex.integerValue
            if shiftForward {
                preset.orderIndex = currentOrderIndex + 1
            }
            else {
                preset.orderIndex = currentOrderIndex - 1
            }
        }
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Reindex synth preset save finished")
            
            saveCompletionHandler?()
        }
    }
    

    
    // MARK: Properties (Static)
    static let sharedPresetService = PresetService()
}