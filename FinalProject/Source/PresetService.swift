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
    func fetchedResultsControllerForPresets() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: Presets.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    func addPresetWithName(name: String, synthRotaryKnobArray: Array<MHRotaryKnob>, synthRadioButtonArray: Array<RadioButton>, seqRotaryKnobArray: Array<MHRotaryKnob>, seqRadioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        let preset = NSEntityDescription.insertNewObjectForNamedEntity(Presets.self, inManagedObjectContext: context)
        let synthPreset = NSEntityDescription.insertNewObjectForNamedEntity(SynSet.self, inManagedObjectContext: context)
        let seqPreset = NSEntityDescription.insertNewObjectForNamedEntity(SeqSet.self, inManagedObjectContext: context)
        
        preset.name = name
        preset.synthesizerSettings = synthPreset
        preset.sequencerSettings = seqPreset
        
        try addSynthPresetWithName(name, fullPreset: preset, preset: synthPreset, rotaryKnobArray: synthRotaryKnobArray, radioButtonArray: synthRadioButtonArray)
        try addSeqPresetWithName(name, fullPreset: preset, preset: seqPreset, rotaryKnobArray: seqRotaryKnobArray, radioButtonArray: seqRadioButtonArray)
        
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
    
    
    func fetchedResultsControllerForSynthPreset() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: SynSet.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }

    
    func addSynthPresetWithName(name: String, fullPreset: Presets, preset: SynSet, rotaryKnobArray: Array<MHRotaryKnob>, radioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext

        preset.name = name + " Synth"
        preset.fullPreset = fullPreset
        
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
    
    
    func deleteSynthPreset(preset: SynSet, withSaveCompletionHandler saveCompletionHandler: SaveCompletionHandler) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        context.deleteObject(preset)
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Delete synth preset save finished")
            
            saveCompletionHandler()
        }
    }
    
    
    func fetchedResultsControllerForSeqPreset() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(namedEntity: SeqSet.self)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    
    func addSeqPresetWithName(name: String, fullPreset: Presets, preset: SeqSet, rotaryKnobArray: Array<MHRotaryKnob>, radioButtonArray: Array<RadioButton>) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        preset.name = name + " Sequence"
        preset.fullPreset = fullPreset
        
        for rotaryKnob in rotaryKnobArray {
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
    
    
    func deleteSeqPreset(preset: SeqSet, withSaveCompletionHandler saveCompletionHandler: SaveCompletionHandler) throws {
        let context = CoreDataService.sharedCoreDataService.mainQueueContext
        
        context.deleteObject(preset)
        
        try context.save()
        
        CoreDataService.sharedCoreDataService.saveRootContext {
            print("Delete sequence preset save finished")
            
            saveCompletionHandler()
        }
    }
    
    
    // MARK: Properties (Static)
    static let sharedPresetService = PresetService()
}