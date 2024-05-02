//
//  SelectManager.swift
//  CineChoice
//
//  Created by Lucky on 02/05/24.
//

import Foundation

class SelectManager: ObservableObject {
    
    static let shared = SelectManager()
    
    let supabaseClient = SupabaseConfiguration.supabaseClient
    
    func fetchUser(for userid: String) async throws -> [UserModel] {

        let response = try await supabaseClient.from("user").select().equals("userID", value: userid).execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let users = try decoder.decode([UserModel].self, from: data)
            
            DispatchQueue.main.async {
                self.user = users.first
            }
            
            return users
        } catch {
            throw error
        }
    }
}
