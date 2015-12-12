//
//  Conductor.swift
//  SwiftKeyboard
//
//  Created by Aurelius Prochazka on 11/28/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

class Conductor {

    var toneGenerator = ToneGenerator()
    
    var fx: EffectsProcessor
    var currentNotes = [ToneGeneratorNote](count: 13, repeatedValue: ToneGeneratorNote())
    let frequencies = [[130.813, 138.591, 146.832, 155.563, 164.814,174.614, 184.997, 195.998, 207.652, 220.000, 233.082, 246.942, 261.625], [523.25, 554.37, 587.33, 622.25, 659.26, 698.46, 739.99, 783.99, 830.61, 880, 932.33, 987.77, 1046.5]]
    var currentOctave = 0
    init() {
        AKOrchestra.addInstrument(toneGenerator)
        fx = EffectsProcessor(audioSource: toneGenerator.auxilliaryOutput)
        AKOrchestra.addInstrument(fx)
        AKOrchestra.start()
        setAmplidute(0.2)
        fx.play()
    }

    func play(key: Int) {
        let note = ToneGeneratorNote()
        let frequency = Float(frequencies[currentOctave][key])
        note.frequency.value = frequency
        toneGenerator.playNote(note)
        currentNotes[key]=note;
    }

    func hitTowerPlaySoundForDuration(duration: Float) {
        
        let phrase = AKPhrase()
        
        for i in 0...12 {
            let note = ToneGeneratorNote()
            note.frequency.floatValue = 220/(pow(2.0,Float(i)/12))
            note.duration.value = duration
            
            let time = duration * Float(i)
            phrase.addNote(note, atTime: time)
        }
        
        toneGenerator.playPhrase(phrase)
    }
    
    func hitEnemyPlaySoundForDuration(duration: Float) {
        
        let phrase = AKPhrase()
        
        for i in 0...12 {
            let note = ToneGeneratorNote()
            note.frequency.floatValue = 440*(pow(2.0,Float(i)/12))
            note.duration.value = duration
            
            let time = duration * Float(i)
            phrase.addNote(note, atTime: time)
        }
        
        toneGenerator.playPhrase(phrase)
    }
    func release(key: Int) {
        let noteToRelease = currentNotes[key]
        noteToRelease.stop()
    }

    func setReverbFeedbackLevel(feedbackLevel: Float) {
        fx.feedbackLevel.value = feedbackLevel
    }
    func setToneColor(toneColor: Float) {
        toneGenerator.toneColor.value = toneColor
    }
    func setAmplidute(amp: Float)
    {
        toneGenerator.oscillatorMix.value = amp
    }
}
