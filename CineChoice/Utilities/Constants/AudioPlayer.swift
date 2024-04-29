//
//  AudioPlayer.swift
//  CineChoice
//
//  Created by Lucky on 27/04/24.
//

import AVFoundation
import CloudKit

class AudioPlayer {
    static var audioPlayer: AVAudioPlayer?
    static var peakVolume: Float = 5.0

    static func preloadAudioPlayer(url: URL) {
        guard audioPlayer == nil else { return }
        
        do {
            let audioData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: audioData)
            audioPlayer?.prepareToPlay()
            //audioPlayer?.volume = 0.1
            normalizeVolume()
            audioPlayer?.numberOfLoops = -1
        } catch {
            print("Error initializing audio player:", error)
        }
    }
    
    static func normalizeVolume() {
        guard let audioPlayer = audioPlayer else { return }
        let currentPeakVolume = audioPlayer.peakPower(forChannel: 0)
        let volumeMultiplier = peakVolume / currentPeakVolume
        audioPlayer.setVolume(volumeMultiplier, fadeDuration: 0)
    }


    static func playMusic(url: URL) {
        preloadAudioPlayer(url: url)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            audioPlayer?.play()
        }
    }
    
    static func changeMusic(url: URL) {
        stopMusic()
        playMusic(url: url)
    }
    
    static func stopMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}


