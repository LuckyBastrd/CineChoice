//
//  UpSertManager.swift
//  CineChoice
//
//  Created by Lucky on 01/05/24.
//

import Foundation
import Supabase

class UpdateManager: ObservableObject {
    
    static let shared = UpdateManager()
    
    let supabaseClient = SupabaseConfiguration.supabaseClient
    
    func updateCard(_ card: CardModel, from supaBaseManager: SupabaseManager, action: String, like: Int, dislike: Int, unseen: Int) {
        DeleteManager.shared.removeCard(card, from: supaBaseManager)
        
        Task {
            // Update user action
            await UpdateManager.shared.updateUserAction(userid: supaBaseManager.user?.userID ?? "nil")
            
            // Upsert film rating
            await UpdateManager.shared.upSertFilmRating(filmid: card.id, filmlike: like, filmdislike: dislike, filmunseen: unseen)
            
            // Create interaction
            await CreateManager.shared.createInteraction(userid: supaBaseManager.user?.userID ?? "nil", filmid: card.id, action: action)
        }
    }
    
    func updateUserAction(userid: String) async {
        do {            
            try await supabaseClient.rpc("updateuseraction", params: ["userid": userid]).execute()
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    func upSertFilmRating(filmid: Int, filmlike: Int, filmdislike: Int, filmunseen: Int) async {
        do { 
            try await supabaseClient.rpc("upsertfilmrating", params: ["filmid": filmid, 
                                                                "filmlike": filmlike,
                                                                "filmdislike": filmdislike,
                                                                "filmunseen": filmunseen]).execute()
        } catch {
            print("Error: \(error)")
        }
    }
}
