//
//  AudioPlayer.swift
//  CineChoice
//
//  Created by Lucky on 27/04/24.
//

//import AVFoundation
//
//class AudioPlayer {
//    static var audioPlayer: AVAudioPlayer?
//    static var peakVolume: Float = 5.0
//
//    static func preloadAudioPlayer(url: URL) {
//        guard audioPlayer == nil else { return }
//        
//        do {
//            let audioData = try Data(contentsOf: url)
//            audioPlayer = try AVAudioPlayer(data: audioData)
//            audioPlayer?.prepareToPlay()
//            //audioPlayer?.volume = 0.1
//            normalizeVolume()
//            audioPlayer?.numberOfLoops = -1
//        } catch {
//            print("Error initializing audio player:", error)
//        }
//    }
//    
//    static func normalizeVolume() {
//        guard let audioPlayer = audioPlayer else { return }
//        let currentPeakVolume = audioPlayer.peakPower(forChannel: 0)
//        let volumeMultiplier = peakVolume / currentPeakVolume
//        audioPlayer.setVolume(volumeMultiplier, fadeDuration: 0)
//    }
//
//
//    static func playMusic(url: URL) {
//        preloadAudioPlayer(url: url)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            audioPlayer?.play()
//        }
//    }
//    
//    static func changeMusic(url: URL) {
//        stopMusic()
//        playMusic(url: url)
//    }
//    
//    static func stopMusic() {
//        audioPlayer?.stop()
//        audioPlayer = nil
//    }
//}
//
//


import AVFoundation

class AudioPlayer {
    static var audioPlayer: AVAudioPlayer?
    static var peakVolume: Float = 5.0

    static func preloadAudioPlayer(url: URL) {
        guard audioPlayer == nil else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error downloading audio data:", error ?? "Unknown error")
                return
            }

            do {
                audioPlayer = try AVAudioPlayer(data: data)
                audioPlayer?.prepareToPlay()
                normalizeVolume()
                audioPlayer?.numberOfLoops = -1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    audioPlayer?.play()
                }
            } catch {
                print("Error initializing audio player:", error)
            }
        }
        task.resume()
    }

    static func normalizeVolume() {
        guard let audioPlayer = audioPlayer else { return }
        let currentPeakVolume = audioPlayer.peakPower(forChannel: 0)
        let volumeMultiplier = peakVolume / currentPeakVolume
        audioPlayer.setVolume(volumeMultiplier, fadeDuration: 0)
    }

    static func playMusic(url: URL) {
        preloadAudioPlayer(url: url)
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
