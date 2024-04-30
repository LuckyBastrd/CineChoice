//
//  InteractionViewModel.swift
//  CineChoice
//
//  Created by Lucky on 30/04/24.
//

import Foundation


class InteractionViewModel: ObservableObject {
    
    @Published var interactions = [InteractionModel]()
    
    func fetchUserInteractions(for userid: String) async throws {
        
        let fetchedUserInteraction = try await SupabaseManager.shared.fetchUserInteractions(for: userid)
        
        DispatchQueue.main.async {
            self.interactions = fetchedUserInteraction
        }
    }
}
