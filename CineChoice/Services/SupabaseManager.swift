//
//  SupabaseManager.swift
//  CineChoice
//
//  Created by Lucky on 30/04/24.
//

import Foundation
import Supabase

class SupabaseManager {
    
    static let shared = SupabaseManager()
    let supabase = SupabaseClient(supabaseURL: URL(string: "https://shucboqluxegybsrzyfz.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNodWNib3FsdXhlZ3lic3J6eWZ6Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxNDM4MjEwOCwiZXhwIjoyMDI5OTU4MTA4fQ.PE-zDVm6PhmWvhmXdNa0PGCy9V-I7p9Dv70aJCIuqQM")
    
    
    func fetchUser(for userid: String) async throws -> [UserModel] {
        let response = try await supabase.from("user").select().equals("userID", value: userid).execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let user = try decoder.decode([UserModel].self, from: data)
            
            return user
        } catch {
            throw error
        }
    }
    
    func fetchFilms() async throws -> [FilmModel] {
        let response = try await supabase.from("film").select().execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let films = try decoder.decode([FilmModel].self, from: data)
            
            return films
        } catch {
            throw error
        }
    }
    
    func fetchUserInteractions(for userid: String) async throws -> [InteractionModel] {
        let query = """
                    *,
                    film:filmID (
                        filmID,
                        filmTitle,
                        filmPoster,
                        filmSoundtrack,
                        like,
                        dislike,
                        unseen
                    )
                    """
        
        let response = try await supabase.from("interaction").select(query).equals("userID", value: userid).execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let userInteractions = try decoder.decode([InteractionModel].self, from: data)
            
            print(userInteractions)
            
            return userInteractions
        } catch {
            throw error
        }
    }
    
//    func isFilmIDAlreadyPresent(for userid: String, filmid: Int) async throws -> Bool {
//        let query = """
//                    *,
//                    film:filmID (
//                        filmID,
//                        filmTitle,
//                        filmPoster,
//                        filmSoundtrack,
//                        like,
//                        dislike,
//                        unseen
//                    )
//                    """
//        
//        let response = try await supabase.database.from("interaction").select(query).equals("userID", value: userid).equals("filmID", value: String(filmid)).execute()
//        
//        let data = response.data
//        
//        let decoder = JSONDecoder()
//        
//        do {
//            let userInteractions = try decoder.decode([InteractionModel].self, from: data)
//            
//            guard let data = response.data, let count = data.first?["count"] as? Int else {
//                throw SupabaseError.dataError("No data returned")
//            }
//            
//            return count > 0
//        } catch {
//            throw error
//        }
//    }
}


