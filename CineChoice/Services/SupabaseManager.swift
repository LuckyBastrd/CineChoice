//
//  SupabaseManager.swift
//  CineChoice
//
//  Created by Lucky on 30/04/24.
//

//import Foundation
//import Supabase
//
//class SupabaseManager {
//    
//    static let shared = SupabaseManager()
//    let supabase = SupabaseClient(supabaseURL: URL(string: "https://shucboqluxegybsrzyfz.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNodWNib3FsdXhlZ3lic3J6eWZ6Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxNDM4MjEwOCwiZXhwIjoyMDI5OTU4MTA4fQ.PE-zDVm6PhmWvhmXdNa0PGCy9V-I7p9Dv70aJCIuqQM")
//    
//    
//    func fetchUser(for userid: String) async throws -> [UserModel] {
//        let response = try await supabase.from("user").select().equals("userID", value: userid).execute()
//        
//        let data = response.data
//        
//        let decoder = JSONDecoder()
//        
//        do {
//            let user = try decoder.decode([UserModel].self, from: data)
//            
//            return user
//        } catch {
//            throw error
//        }
//    }
//    
//    func fetchFilms() async throws -> [FilmModel] {
//        let response = try await supabase.from("film").select().execute()
//        
//        let data = response.data
//        
//        let decoder = JSONDecoder()
//        
//        do {
//            let films = try decoder.decode([FilmModel].self, from: data)
//            
//            return films
//        } catch {
//            throw error
//        }
//    }
//    
//    func fetchUserInteractions(for userid: String) async throws -> [InteractionModel] {
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
//        let response = try await supabase.from("interaction").select(query).equals("userID", value: userid).execute()
//        
//        let data = response.data
//        
//        let decoder = JSONDecoder()
//        
//        do {
//            let userInteractions = try decoder.decode([InteractionModel].self, from: data)
//            
//            print(userInteractions)
//            
//            return userInteractions
//        } catch {
//            throw error
//        }
//    }
//    
////    func isFilmIDAlreadyPresent(for userid: String, filmid: Int) async throws -> Bool {
////        let query = """
////                    *,
////                    film:filmID (
////                        filmID,
////                        filmTitle,
////                        filmPoster,
////                        filmSoundtrack,
////                        like,
////                        dislike,
////                        unseen
////                    )
////                    """
////        
////        let response = try await supabase.database.from("interaction").select(query).equals("userID", value: userid).equals("filmID", value: String(filmid)).execute()
////        
////        let data = response.data
////        
////        let decoder = JSONDecoder()
////        
////        do {
////            let userInteractions = try decoder.decode([InteractionModel].self, from: data)
////            
////            guard let data = response.data, let count = data.first?["count"] as? Int else {
////                throw SupabaseError.dataError("No data returned")
////            }
////            
////            return count > 0
////        } catch {
////            throw error
////        }
////    }
//}


import Foundation
import Supabase

class SupabaseManager: ObservableObject {
    
    static let shared = SupabaseManager()
    
    let supabase = SupabaseConfiguration.supabase
    
    @Published var user: UserModel?
    @Published var films: [FilmModel] = []
    @Published var cards: [CardModel] = []
    @Published var userInteractions: [InteractionModel] = []
    
    // Function to check if data has been fetched previously
    func shouldFetchData() -> Bool {
        return UserDefaults.standard.bool(forKey: "dataFetched")
    }
    
    // Function to mark data as fetched
    func markDataAsFetched() {
        UserDefaults.standard.set(true, forKey: "dataFetched")
    }
    
    // Function to fetch initial data asynchronously
    func fetchInitialData(completion: @escaping (Error?) -> Void) {
        print("should ? = \(shouldFetchData())")
        if shouldFetchData() {
            Task {
                do {
                    // Fetch user data
                    let users = try await fetchUser(for: "1a4aa126000048f89c0e6d249f3249c2")

                    // Fetch film data
                    let films = try await fetchFilms(for: "1a4aa126000048f89c0e6d249f3249c2")
                    
                    // Fetch film data
                    let userInteractions = try await fetchUserInteractions(for: "1a4aa126000048f89c0e6d249f3249c2")
                    
                    _ = try await fetchCards()
                    
                    DispatchQueue.main.async {
                        self.user = users.first
                        self.films = films
                        self.userInteractions = userInteractions
                    }
                    
                    // Data fetched successfully, mark as fetched
                    markDataAsFetched()
                    
                    completion(nil)
                } catch {
                    // Handle error
                    completion(error)
                }
            }
        } else {
            // Data already fetched, call completion with no error
            completion(nil)
        }
    }
    
    func fetchUser(for userid: String) async throws -> [UserModel] {
        let response = try await supabase.from("user").select().equals("userID", value: "1a4aa126000048f89c0e6d249f3249c2").execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let users = try decoder.decode([UserModel].self, from: data)
            
            return users
        } catch {
            throw error
        }
    }
    
    func fetchFilms(for userid: String) async throws -> [FilmModel] {
        
        let response = try await supabase.rpc("getfilmsforuser", params: ["userid": userid]).order("filmID", ascending: false).execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let films = try decoder.decode([FilmModel].self, from: data)
            
            return films
        } catch {
            throw error
        }
    }
    
    func fetchCards() async throws -> [CardModel] {
        let filmData = try await SupabaseManager.shared.fetchFilms(for: "1a4aa126000048f89c0e6d249f3249c2")
        
        let mappedCardModels = filmData.map { film in
            return CardModel(film: film)
        }
        
        DispatchQueue.main.async {
            self.cards = mappedCardModels
        }

        return cards
    }
    
    func fetchUserInteractions(for userid: String) async throws -> [InteractionModel] {
        let query = """
                    *,
                    film:filmID (
                        filmID,
                        filmTitle,
                        filmPoster,
                        filmSoundtrack
                    )
                    """
        
        let response = try await supabase
            .from("interaction").select(query).equals("userID", value: /*userid*/ "1a4aa126000048f89c0e6d249f3249c2").execute()
        
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
}



