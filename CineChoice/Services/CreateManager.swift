//
//  CreateManager.swift
//  CineChoice
//
//  Created by Lucky on 01/05/24.
//

import Foundation
import Supabase

class CreateManager {
    
    static let shared = CreateManager()
    
    let supabaseClient = SupabaseConfiguration.supabaseClient
    
    func createInteraction(userid: String, filmid: Int, action: String) async {
        do { 
            
            let filmidString = String(filmid)
            
            try await supabaseClient.rpc("createinteraction", params: ["userid": userid, 
                                                                "filmid": filmidString,
                                                                "action": action]).execute()
        } catch {
            print("Error: \(error)")
        }
    }
    
}
