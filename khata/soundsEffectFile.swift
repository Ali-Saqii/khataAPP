//
//  soundsEffectFile.swift
//  khata
//
//  Created by Mac mini on 06/01/2026.
//

import SwiftUI
import AudioToolbox


import AVFoundation
import AVKit

final class SoundManager {

    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    private init() {}

    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing sound:", error.localizedDescription)
        }
    }
}

