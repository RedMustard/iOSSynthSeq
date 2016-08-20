//
//  DefaultPresetService.swift
//  FinalProject
//
//  Created by Travis Barnes on 8/20/16.
//
//

import CoreData
import CoreDataService
import Foundation

class DefaultPresetService {
    // MARK: Service
    func fetchedResultsControllerForDefaultPreset() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: DefaultPreset.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    func addDefaultPreset(synthRotaryKnobArray: Array<MHRotaryKnob>, synthRadioButtonArray: Array<RadioButton>, seqRotaryKnobArray: Array<MHRotaryKnob>, seqRadioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext

        let preset = NSEntityDescription.insertNewObjectForNamedEntity(DefaultPreset.self, inManagedObjectContext: context)
        let synthPreset = NSEntityDescription.insertNewObjectForNamedEntity(DefaultSynSet.self, inManagedObjectContext: context)
        let seqPreset = NSEntityDescription.insertNewObjectForNamedEntity(DefaultSeqSet.self, inManagedObjectContext: context)
    
        preset.name = "Default Preset"
        preset.defaultSynthSettings = synthPreset
        preset.defaultSeqSettings = seqPreset
    
        try addDefaultSynthPreset(preset, preset: synthPreset, rotaryKnobArray: synthRotaryKnobArray, radioButtonArray: synthRadioButtonArray)
        try addDefaultSeqPreset(preset, preset: seqPreset, rotaryKnobArray: seqRotaryKnobArray, radioButtonArray: seqRadioButtonArray)
    
        try context.save()
    
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Add preset save finished")
        }
    }
    
    
    func updateDefaultPreset(preset: DefaultPreset, synthRotaryKnobArray: Array<MHRotaryKnob>, synthRadioButtonArray: Array<RadioButton>, seqRotaryKnobArray: Array<MHRotaryKnob>, seqRadioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        try addDefaultSynthPreset(preset, preset: preset.defaultSynthSettings, rotaryKnobArray: synthRotaryKnobArray, radioButtonArray: synthRadioButtonArray)
        
        try addDefaultSeqPreset(preset, preset: preset.defaultSeqSettings, rotaryKnobArray: seqRotaryKnobArray, radioButtonArray: seqRadioButtonArray)
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Update preset save finished")
        }
    }
    
    
    func fetchedResultsControllerForDefaultSynthPreset() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: DefaultSynSet.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
    
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    func addDefaultSynthPreset(defaultPreset: DefaultPreset, preset: DefaultSynSet, rotaryKnobArray: Array<MHRotaryKnob>, radioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
    
        preset.name = "Default Synth"
        preset.defaultPreset = defaultPreset
    
        for rotaryKnob in rotaryKnobArray {
            switch(rotaryKnob.accessibilityLabel!) {
            case("Osc1OctKnob"):
                preset.osc1Oct = rotaryKnob.value
            case("Osc1WaveKnob"):
                preset.osc1Wave = rotaryKnob.value
            case("Osc1VolKnob"):
                preset.osc1Vol = rotaryKnob.value
            case("Osc2OctKnob"):
                preset.osc2Oct = rotaryKnob.value
            case("Osc2WaveKnob"):
                preset.osc2Wave = rotaryKnob.value
            case("Osc2VolKnob"):
                preset.osc2Vol = rotaryKnob.value
            case("AttackKnob"):
                preset.attack = rotaryKnob.value
            case("DecayKnob"):
                preset.decay = rotaryKnob.value
            case("SustainKnob"):
                preset.sustain = rotaryKnob.value
            case("ReleaseKnob"):
                preset.releaseVal = rotaryKnob.value
            case("FilterNoiseKnob"):
                preset.noise = rotaryKnob.value
            case("FilterResonanceKnob"):
                preset.resonance = rotaryKnob.value
            case("FilterSlopeKnob"):
                preset.slope = rotaryKnob.value
            case("FilterFeedbackKnob"):
                preset.feedback = rotaryKnob.value
            case("FilterCutoffKnob"):
                preset.cutoff = rotaryKnob.value
            case("LFORateKnob"):
                preset.rate = rotaryKnob.value
            case("LFOAmountKnob"):
                preset.amount = rotaryKnob.value
            case("OutputVolumeKnob"):
                preset.volume = rotaryKnob.value
            case(_):
                continue
            }
        }
    
        for radioButton in radioButtonArray {
            switch(radioButton.accessibilityLabel!) {
            case("LFOSyncButton"):
                preset.sync = radioButton.isTriggered
            case("LFOOsc1Button"):
                preset.osc1 = radioButton.isTriggered
            case("LFOOsc2Button"):
                preset.osc2 = radioButton.isTriggered
            case(_):
                continue
            }
        }
    
        try context.save()
    
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Add synth preset save finished")
        }
    }
    
    func fetchedResultsControllerForDefaultSeqPreset() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: DefaultSeqSet.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
    
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    func addDefaultSeqPreset(defaultPreset: DefaultPreset, preset: DefaultSeqSet, rotaryKnobArray: Array<MHRotaryKnob>, radioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
    
        preset.name = "Default Sequence"
        preset.defaultPreset = defaultPreset
    
        for rotaryKnob in rotaryKnobArray {
            print(rotaryKnob.value)
            switch(rotaryKnob.accessibilityLabel!) {
            case("SequenceStep1FreqKnob"):
                preset.frequency1 = rotaryKnob.value
            case("SequenceStep2FreqKnob"):
                preset.frequency2 = rotaryKnob.value
            case("SequenceStep3FreqKnob"):
                preset.frequency3 = rotaryKnob.value
            case("SequenceStep4FreqKnob"):
                preset.frequency4 = rotaryKnob.value
            case("SequenceStep5FreqKnob"):
                preset.frequency5 = rotaryKnob.value
            case("SequenceStep6FreqKnob"):
                preset.frequency6 = rotaryKnob.value
            case("SequenceStep7FreqKnob"):
                preset.frequency7 = rotaryKnob.value
            case("SequenceStep8FreqKnob"):
                preset.frequency8 = rotaryKnob.value
            case("SequenceStep9FreqKnob"):
                preset.frequency9 = rotaryKnob.value
            case("SequenceStep10FreqKnob"):
                preset.frequency10 = rotaryKnob.value
            case("SequenceStep11FreqKnob"):
                preset.frequency11 = rotaryKnob.value
            case("SequenceStep12FreqKnob"):
                preset.frequency12 = rotaryKnob.value
            case("SequenceStep13FreqKnob"):
                preset.frequency13 = rotaryKnob.value
            case("SequenceStep14FreqKnob"):
                preset.frequency14 = rotaryKnob.value
            case("SequenceStep15FreqKnob"):
                preset.frequency15 = rotaryKnob.value
            case("SequenceStep16FreqKnob"):
                preset.frequency16 = rotaryKnob.value
            case("SequenceRateKnob"):
                preset.rate = rotaryKnob.value
            case(_):
                continue
            }
        }
    
        for radioButton in radioButtonArray {
            switch(radioButton.accessibilityLabel!) {
            case("SequenceStep1OnButton"):
                preset.step1 = radioButton.isTriggered
            case("SequenceStep2OnButton"):
                preset.step2 = radioButton.isTriggered
            case("SequenceStep3OnButton"):
                preset.step3 = radioButton.isTriggered
            case("SequenceStep4OnButton"):
                preset.step4 = radioButton.isTriggered
            case("SequenceStep5OnButton"):
                preset.step5 = radioButton.isTriggered
            case("SequenceStep6OnButton"):
                preset.step6 = radioButton.isTriggered
            case("SequenceStep7OnButton"):
                preset.step7 = radioButton.isTriggered
            case("SequenceStep8OnButton"):
                preset.step8 = radioButton.isTriggered
            case("SequenceStep9OnButton"):
                preset.step9 = radioButton.isTriggered
            case("SequenceStep10OnButton"):
                preset.step10 = radioButton.isTriggered
            case("SequenceStep11OnButton"):
                preset.step11 = radioButton.isTriggered
            case("SequenceStep12OnButton"):
                preset.step12 = radioButton.isTriggered
            case("SequenceStep13OnButton"):
                preset.step13 = radioButton.isTriggered
            case("SequenceStep14OnButton"):
                preset.step14 = radioButton.isTriggered
            case("SequenceStep15OnButton"):
                preset.step15 = radioButton.isTriggered
            case("SequenceStep16OnButton"):
                preset.step16 = radioButton.isTriggered
            case("SequenceSteps1To8OnButton"):
                preset.step1To8 = radioButton.isTriggered
            case("SequenceSteps9To16OnButton"):
                preset.step9To16 = radioButton.isTriggered
            case(_):
                continue
            }
        }
            
        try context.save()
            
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Add sequence preset save finished")
        }
    }
    
    
    // MARK: Properties (Static)
    static let sharedPresetService = DefaultPresetService()
}