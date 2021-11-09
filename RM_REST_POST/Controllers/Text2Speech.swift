//
//  Text2Speech.swift
//  RM_REST_POST
//
//  Created by Tatsuya Moriguchi on 10/31/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import Foundation
import AVFoundation

//extension SportsNewsViewController {
class Text2Speech {
    
    // Play audio reading text string
    func text2Speech(text: String) {
        
        // text to speech
        let speechText = AVSpeechUtterance(string: text)
        speechText.rate = 0.5
        
        let voice = "com.apple.ttsbundle.Samantha-compact"

        speechText.voice = AVSpeechSynthesisVoice(identifier: voice)
        let synth = AVSpeechSynthesizer()
        
        synth.speak(speechText)
    }
    
}
