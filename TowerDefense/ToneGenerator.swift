//
//  ToneGenerator.swift
//  TowerDefense
//
//  Created by Chris Murphy on 2/20/16.
//  Copyright © 2016 Chris Murphy. All rights reserved.
//
import AudioKit
import Foundation
class ToneGenerator {
    var toneGenerator = AKTriangleOscillator()

    init() {
        //otherGen.volume = 100
  
    }
    func setFreq(freq: Double)
    {
        toneGenerator.frequency = freq
    }
    func setRamp(ramp: Double)
    {
        toneGenerator.ramp(amplitude: ramp)
    }
    func setAmp(amp: Double)
    {
        toneGenerator.amplitude = amp
    }
    func start()
    {
        toneGenerator.start()
        //otherGen.playNote(45, velocity: 127)
    }
    func stop()
    {
        toneGenerator.stop()
        //otherGen.stopNote(45)
    }
}