//
//  AudioGenerator.swift
//  TowerDefense
//
//  Created by Chris Murphy on 12/11/15.
//  Copyright © 2015 Chris Murphy. All rights reserved.
//

import Foundation

class AudioGenerator {
   init ()
   {
    let instrument = AKInstrument()
    instrument.setAudioOutput(AKOscillator())
    AKOrchestra.addInstrument(instrument)
    instrument.play()
    }
}