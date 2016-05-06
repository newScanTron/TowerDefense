//
//  Conductor.swift
//  SwiftKeyboard
//
//  Created by Aurelius Prochazka on 11/28/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//
import AudioKit
import Foundation
class Conductor {

    var toneGenerator = ToneGenerator()
    let scale = [0,2,4,5,7,9,11,12]

    let frequencies = [[130.813, 138.591, 146.832, 155.563, 164.814,174.614, 184.997, 195.998, 207.652, 220.000, 233.082, 246.942, 261.625], [523.25, 554.37, 587.33, 622.25, 659.26, 698.46, 739.99, 783.99, 830.61, 880, 932.33, 987.77, 1046.5]]
    var currentOctave = 0
    
    var thisKey = [65.41, 73.42, 82.41, 87.31, 98.00,  110.00, 123.47, 130.81, 146.83, 164.81, 174.61, 196.00, 220.00, 246.94, 261.63]
    init() {
        
        AudioKit.output = toneGenerator.toneGenerator
        
        AudioKit.start()
       //toneGenerator.start()
  

    }

    //this method is going to create a melody based on the current state of the game and all the entities inside.
   
    func playWaveMelody()
    {
        let appDelegate =
        UIApplication.sharedApplication().delegate as? AppDelegate
        let enemies = appDelegate!.gameScene!.enemies
   
        
        for _ in enemies
        {
            for _ in 0...16 {

                let num = Int(floor(random(min:0, max: CGFloat(Double(thisKey.count) - 0.01))))
            
                print(Float(thisKey[num])," : ",num)
             
                let note = scale.randomElement()
                let octave = randomInt(3...6)  * 12
                toneGenerator.setFreq((note + octave).midiNoteToFrequency())
                toneGenerator.setAmp(random(0, 0.3))
               
            }

        }
     
    }
    func hitTowerPlaySoundForDuration(duration: Double) {
        

        
        for i in 0...12 {
            
            
            let note = scale.randomElement()
            let octave = i  * 12
            toneGenerator.setFreq((note + octave).midiNoteToFrequency())
            toneGenerator.setAmp(random(0, 0.3))
        }
        
   
    }
    
//function that is called when the enemy is hit.
    func stopEnemySound()
    {
        // self.toneGenerator.setRamp( 0.0)
        toneGenerator.stop()
    }
    func hitEnemyPlaySound(duration: Float,  e: Entity) {
        let times = 4
        recursiveNotesUp(times,lastRepeat:  times, length: 0.64)
        
    }
    //functions to play notes
    func recursiveNotesRandom(repeats: Int, maxLength: Double)
    {
        //base case of repeats being larger than 0
        if repeats > 0
        {
            let note = self.scale.randomElement()
            let octave = randomInt(4...6)  * 12
            self.toneGenerator.toneGenerator.frequency = (note + octave).midiNoteToFrequency()
            self.toneGenerator.setRamp(0.1)
            self.toneGenerator.setAmp( random(0.3, 0.4))
            self.toneGenerator.start()
            let rand = random(0.05, maxLength)
            delay(rand){self.stopEnemySound()
            let rep = repeats - 1
            self.recursiveNotesRandom(rep, maxLength: maxLength)}
        }
        return
    }
    //function to play notes up a scale
    func recursiveNotesUp(repeats: Int, lastRepeat: Int, length: Double)
    {
        //same base case of 0 as prior function
        if repeats > 0
        {
            let note = self.scale.randomElement()
            let octave = (lastRepeat - repeats + 6)  * 12
            //            self.toneGenerator.toneGenerator.frequency = (note + octave).midiNoteToFrequency()
            self.toneGenerator.setFreq((note + octave).midiNoteToFrequency())
            //self.toneGenerator.amplitude = random(0.3, 0.6)
            self.toneGenerator.setRamp(0.6)
            self.toneGenerator.start()
            
            delay(length){
               
                self.stopEnemySound()
                let rep = repeats - 1
                let leng = length - (length/2)
                self.recursiveNotesUp(rep, lastRepeat: repeats, length: leng)}
        }
        return
    }
}

