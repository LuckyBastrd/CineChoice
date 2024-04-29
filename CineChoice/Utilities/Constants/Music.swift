//
//  Music.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import AVFoundation

 class Music {

   static var audioPlayer:AVAudioPlayer?

     static func playSounds(soundfile: String, volume: Float) {
         if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
             do{
                 audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                 audioPlayer?.prepareToPlay()
                 audioPlayer?.volume = volume // Set the volume here
                 audioPlayer?.play()
             } catch {
                 print("Error")
             }
         }
     }
 }
