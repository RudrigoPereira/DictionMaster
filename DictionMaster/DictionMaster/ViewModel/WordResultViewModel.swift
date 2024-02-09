//
//  WordResultViewModel.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 08/02/24.
//

//import AVFoundation
//import SwiftUI
//
//class WordResultViewModel: ObservableObject {
//    private var audioPlayer: AVPlayer?
//
//    func playAudio(from url: String) {
//        guard let audioURL = URL(string: url) else {
//            return
//        }
//
//        audioPlayer = AVPlayer(url: audioURL)
//        audioPlayer?.play()
//    }
//}

import AVFoundation

class WordResultViewModel: ObservableObject {
    private var audioPlayer: AVPlayer?
    private var wordInfo: WordInfo?

    init(wordInfo: WordInfo) {
        self.wordInfo = wordInfo
    }

    func playAudio() {
        guard wordInfo != nil else {
            return
        }

        guard let audioURLString = firstNonEmptyPhoneticAudio() else {
            return
        }

        guard let audioURL = URL(string: audioURLString) else {
            return
        }

        audioPlayer = AVPlayer(url: audioURL)
        audioPlayer?.play()
    }
    
    func firstNonEmptyPhoneticText() -> String? {
        guard let wordInfo = wordInfo else {
            return nil
        }
        
        for phonetic in wordInfo.phonetics {
            if let text = phonetic.text, !text.isEmpty {
                return phonetic.text
            }
        }
        return nil
    }

    private func firstNonEmptyPhoneticAudio() -> String? {
        guard let wordInfo = wordInfo else {
            return nil
        }

        for phonetic in wordInfo.phonetics {
            if !phonetic.audio.isEmpty {
                return phonetic.audio
            }
        }
        return nil
    }
}
