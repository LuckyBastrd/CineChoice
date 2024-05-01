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
    
    let supabase = SupabaseConfiguration.supabase
    
    func createInteraction(userid: String, filmid: Int, action: String) async {
        do { 
            
            let filmidString = String(filmid)
            
            try await supabase.rpc("createinteraction", params: ["userid": userid, 
                                                                "filmid": filmidString,
                                                                "action": action]).execute()
        } catch {
            print("Error: \(error)")
        }
    }
    
}
