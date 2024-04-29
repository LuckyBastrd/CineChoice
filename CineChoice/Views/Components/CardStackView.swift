//
//  CardStackView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI
import CloudKit

struct CardStackView: View {
    
    @StateObject var cardViewModel = CardViewModel()
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            ForEach(cardViewModel.cardModels.indices, id: \.self) { index in
                BlurBackgroundView(card: cardViewModel.cardModels[index])
            }
            
            ForEach(cardViewModel.cardModels.indices, id: \.self) { index in
                CardView(
                    cardViewModel: cardViewModel,
                    cardCount: cardViewModel.cardModels.count - 1,
                    card: cardViewModel.cardModels[index],
                    index: index,
                    currentIndex: $currentIndex
                )
            }
            
        }
        .onAppear {
            cardViewModel.fetchCardModels()
        }
        .onChange(of: currentIndex) { oldValue, newValue in
            guard oldValue != currentIndex else { return }
            
            if newValue == -1 {
                AudioPlayer.stopMusic()
                return
            }
            
            if newValue < cardViewModel.cardModels.count {
                let cardModel = cardViewModel.cardModels[newValue]
                if let fileURL = cardModel.film.filmSoundtrack.fileURL {
                    AudioPlayer.changeMusic(url: fileURL)
                }
            }
        }
    }
}

#Preview {
    CardStackView()
}
