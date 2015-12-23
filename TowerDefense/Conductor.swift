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
    
    var thisKey = [65.41, 73.42, 82.41, 87.31, 98.00,  110.00, 123.47, 130.81, 146.83, 164.81, 174.61, 196.00, 220.00, 246.94, 261.63]
    init() {
        AKOrchestra.addInstrument(toneGenerator)
        fx = EffectsProcessor(audioSource: toneGenerator.auxilliaryOutput)
        AKOrchestra.addInstrument(fx)
        AKOrchestra.start()
        setAmplidute(0.2)
        //setReverbFeedbackLevel(0.6)
        fx.play()

    }

    func playKey(key: Int) {
        let note = ToneGeneratorNote()
        let frequency = Float(frequencies[currentOctave][key])
        note.frequency.value = frequency
        toneGenerator.playNote(note)
        currentNotes[key]=note;
    }
    //this method is going to create a melody based on the current state of the game and all the entities inside.
   
    func playWaveMelody()
    {
        let enemies = GameScene.enemies
        let phrase = AKPhrase()
        
        
        for _ in enemies
        {
            for i in 0...16 {
                let duration:Float = 0.125 * Float(floor(random(min:0, max:4.9)))
                let octave = Int(floor(random(min:0, max:1.9)))
                let num = Int(floor(random(min:0, max: CGFloat(Double(thisKey.count) - 0.01))))
            
                print(Float(thisKey[num])," : ",num)
                let note = ToneGeneratorNote()
               // note.frequency.floatValue = Float(frequencies[octave][num])
                note.frequency.floatValue = Float(thisKey[num])
                note.duration.value = duration
                
                let time = duration * Float(i)*2
                phrase.addNote(note, atTime: time)
            }

        }
        toneGenerator.playPhrase(phrase)
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
    
//function that is called when the enemy is hit.
    
    func hitEnemyPlaySound(duration: Float,  e: Entity) {

        let phrase = AKPhrase()
        let reverbAmount = abs(Float(e.health / 1000))
        for i in 0...12 {
            let note = ToneGeneratorNote()
            note.frequency.floatValue = 220*(pow(2.0,Float(i)/12))
            note.duration.value = duration
            setReverbFeedbackLevel(reverbAmount)
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
