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
    // MARK: Service
    func presetNames() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: Presets.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
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
    
    
    func addPresetWithName(name: String) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let preset = NSEntityDescription.insertNewObjectForNamedEntity(Presets.self, inManagedObjectContext: context)
        preset.name = name
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Add preset save finished")
        }
    }
    
    
    func addSynthPresetWithName(name: String, rotaryKnobArray: Array<MHRotaryKnob>, radioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        let synthPreset = NSEntityDescription.insertNewObjectForNamedEntity(SynSet.self, inManagedObjectContext: context)
        
        synthPreset.name = name + "Synth"
        
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
                return
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
                return
            }
        }
        
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Add lent item save finished")
        }

    }
    


    
    // MARK: Properties (Static)
    static let sharedPresetService = PresetService()
}