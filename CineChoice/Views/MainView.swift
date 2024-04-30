//
//  MainView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI
import FCUUID

struct MainView: View {
    
    //@StateObject var filmViewModel = FilmViewModel()
    @StateObject var cardViewModel = CardViewModel()
    @StateObject var interactionViewModel = InteractionViewModel()
    @State private var currentIndex: Int = 0
    
    @State var userid: String
    
    var body: some View {
        ZStack {
//            ForEach(filmViewModel.films.indices, id: \.self) { index in
//                BlurBackgroundView(film: filmViewModel.films[index])
//            }
//            
//            ForEach(filmViewModel.films.indices, id: \.self) { index in
//                CardView(
//                    filmViewModel: filmViewModel,
//                    cardCount: filmViewModel.films.count - 1,
//                    film: filmViewModel.films[index],
//                    index: index,
//                    currentIndex: $currentIndex
//                )
//            }
            
            ForEach(interactionViewModel.interactions.indices, id: \.self) { interactionIndex in
                    ForEach(cardViewModel.cards.indices, id: \.self) { cardIndex in
                        if cardViewModel.cards[cardIndex].film.filmID == interactionViewModel.interactions[interactionIndex].filmID {
                            
                        }
                    }
            }
            
            ForEach(cardViewModel.cards.indices, id: \.self) { index in
                BlurBackgroundView(card: cardViewModel.cards[index])
            }
            
            ForEach(cardViewModel.cards.indices, id: \.self) { index in
                CardView(
                    cardViewModel: cardViewModel,
                    cardCount: cardViewModel.cards.count - 1,
                    card: cardViewModel.cards[index],
                    index: index,
                    currentIndex: $currentIndex
                )
            }
            
//            ForEach(cardViewModel.cards.indices, id: \.self) { index in
//                BlurBackgroundView(card: cardViewModel.cards[index])
//            }
//            
//            ForEach(cardViewModel.cards.indices, id: \.self) { index in
//                CardView(
//                    cardViewModel: cardViewModel,
//                    cardCount: cardViewModel.cards.count - 1,
//                    card: cardViewModel.cards[index],
//                    index: index,
//                    currentIndex: $currentIndex
//                )
//            }

        }
        .onAppear {
            Task {
                do {
                    try await cardViewModel.fetchCards()
                    try await interactionViewModel.fetchUserInteractions(for: userid)
                } catch {
                    print("Error fetching film data: \(error)")
                }
            }
        }
        .onChange(of: currentIndex) { oldValue, newValue in
            
            guard oldValue != currentIndex else { return }
            
            if currentIndex == -1 {
                AudioPlayer.stopMusic()
                return
            }

            
            if newValue < cardViewModel.cards.count {
                let cardModel = cardViewModel.cards[newValue]
                if let soundtrackURL = URL(string: cardModel.film.filmSoundtrack) {
                    AudioPlayer.changeMusic(url: soundtrackURL)
                }
            }
        }
    }
}

//#Preview {
//    MainView()
//}
