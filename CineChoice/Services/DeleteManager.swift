//
//  DeleteManager.swift
//  CineChoice
//
//  Created by Lucky on 01/05/24.
//

import Foundation

class DeleteManager {
    
    static let shared = DeleteManager()

    func removeCard(_ card: CardModel, from supaBaseManager: SupabaseManager) {
        guard let index = supaBaseManager.cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        supaBaseManager.cards.remove(at: index)
    }
    
}
