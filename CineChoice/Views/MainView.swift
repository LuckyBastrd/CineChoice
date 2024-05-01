//
//  MainView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI
import FCUUID

struct MainView: View {
    
    @EnvironmentObject var supabaseManager: SupabaseManager
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            
            ForEach(supabaseManager.cards.indices, id: \.self) { index in
                if supabaseManager.cards.isEmpty {
                    EmptyCardView()
                } else {
                    BlurBackgroundView(card: supabaseManager.cards[index])
                }
            }
            
            ForEach(supabaseManager.cards.indices, id: \.self) { index in
                CardView(
                    cardCount: supabaseManager.cards.count - 1,
                    card: supabaseManager.cards[index],
                    index: index,
                    currentIndex: $currentIndex
                )
            }

        }
//        .onChange(of: currentIndex) { oldValue, newValue in
//            
//            guard oldValue != currentIndex else { return }
//            
//            if currentIndex == -1 {
//                AudioPlayer.stopMusic()
//                return
//            }
//
//            
//            if newValue < supabaseManager.cards.count {
//                let cardModel = supabaseManager.cards[newValue]
//                if let soundtrackURL = URL(string: cardModel.film.filmSoundtrack) {
//                    AudioPlayer.changeMusic(url: soundtrackURL)
//                }
//            }
//        }
    }
}

#Preview {
    MainView()
}
