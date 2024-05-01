////
////  CardViewModel.swift
////  CineChoice
////
////  Created by Lucky on 27/04/24.
//
//import Foundation
//import SwiftUI
//
//class CardViewModel: ObservableObject {
//    
//    @Published var cards = [CardModel]()
//    
//    
//    func fetchCards() async throws {
//        let films = try await SupabaseManager.shared.fetchFilms()
//        
//        // Map each fetched film to a CardModel
//        let mappedCardModels = films.map { film in
//            return CardModel(film: film)
//        }
//        
//        // Update cardModels property on the main thread
//        DispatchQueue.main.async {
//            self.cards = mappedCardModels
//        }
//    }
//    
//    func removeCard(_ card: CardModel) {
//        guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }
//        
//        cards.remove(at: index)
//    }
//}
