//
//  SupabaseManager.swift
//  CineChoice
//
//  Created by Lucky on 30/04/24.
//

import Foundation
import Supabase

class SupabaseManager: ObservableObject {
    
    static let shared = SupabaseManager()
    
    let supabaseClient = SupabaseConfiguration.supabaseClient
    
    @Published var user: UserModel?
    @Published var films: [FilmModel] = []
    @Published var cards: [CardModel] = []
    @Published var userInteractions: [InteractionModel] = []
    @Published var filmRatings: [FilmRatingModel] = []
    
    // Function to check if data has been fetched previously
    func shouldFetchData() -> Bool {
        return UserDefaults.standard.bool(forKey: "dataFetched")
    }
    
    // Function to mark data as fetched
    func markDataAsFetched() {
        UserDefaults.standard.set(true, forKey: "dataFetched")
    }
    
    func fetchInitialDataAndSubscribe(completion: @escaping (Error?) -> Void) {
        print("should ? = \(shouldFetchData())")
        if shouldFetchData() {
            Task {
                do {
                    // Fetch initial data
                    fetchInitialData(completion: { error in
                        if let error = error {
                            print("Error fetching initial data: \(error)")
                        } else {
                            print("Initial data fetched successfully.")
                        }
                    })

                    // Subscribe to realtime changes
                    try await subscribeToRealtimeTable(tableName: "interaction")
                    
                    try await subscribeToRealtimeTable(tableName: "filmrating")
                } catch {
                    print("Error fetching initial data and subscribing to realtime changes: \(error)")
                }
            }
        } else {
            // Data already fetched, call completion with no error
            completion(nil)
        }

    }
    
    // Function to fetch initial data asynchronously
    func fetchInitialData(completion: @escaping (Error?) -> Void) {
        Task {
            do {
                // Fetch user data
                let users = try await fetchUser(for: "1a4aa126000048f89c0e6d249f3249c2")

                // Fetch film data
                let films = try await fetchFilms(for: "1a4aa126000048f89c0e6d249f3249c2")
                
                // Fetch film data
                let userInteractions = try await fetchUserInteractions(for: "1a4aa126000048f89c0e6d249f3249c2")
                
                _ = try await fetchCards()
                
                let filmRatings = try await fetchFilmRatings()
                
                DispatchQueue.main.async {
                    self.user = users.first
                    self.films = films
                    self.userInteractions = userInteractions
                    self.filmRatings = filmRatings
                }
                
                // Data fetched successfully, mark as fetched
                markDataAsFetched()
                
                completion(nil)
            } catch {
                // Handle error
                completion(error)
            }
        }
    }
    
    
    
//    func fetchInitialData(completion: @escaping (Error?) -> Void) {
//        print("should ? = \(shouldFetchData())")
//        if shouldFetchData() {
//            Task {
//                do {
//                    // Fetch user data
//                    let users = try await fetchUser(for: "1a4aa126000048f89c0e6d249f3249c2")
//
//                    // Fetch film data
//                    let films = try await fetchFilms(for: "1a4aa126000048f89c0e6d249f3249c2")
//                    
//                    // Fetch film data
//                    let userInteractions = try await fetchUserInteractions(for: "1a4aa126000048f89c0e6d249f3249c2")
//                    
//                    _ = try await fetchCards()
//                    
////                    do {
////                        // Call the function to subscribe to realtime changes in the filmrating table
////                        try await subscribeToRealtimeTable()
////                        print("Subscribed to realtime changes successfully.")
////                    } catch {
////                        print("Error subscribing to realtime changes: \(error)")
////                    }
//
//                    
//                    DispatchQueue.main.async {
//                        self.user = users.first
//                        self.films = films
//                        self.userInteractions = userInteractions
//                    }
//                    
//                    // Data fetched successfully, mark as fetched
//                    markDataAsFetched()
//                    
//                    completion(nil)
//                } catch {
//                    // Handle error
//                    completion(error)
//                }
//            }
//        } else {
//            // Data already fetched, call completion with no error
//            completion(nil)
//        }
//    }
    
    func fetchUser(for userid: String) async throws -> [UserModel] {
        let response = try await supabaseClient.from("user").select().equals("userID", value: "1a4aa126000048f89c0e6d249f3249c2").execute()
        
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
        
        let response = try await supabaseClient.rpc("getfilmsforuser", params: ["userid": userid]).order("filmID", ascending: false).execute()
        
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
        
        let response = try await supabaseClient.rpc("getinteractionwithfilm", params: ["interactionuserid": userid]).execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let interactions = try decoder.decode([InteractionModel].self, from: data)
            
            return interactions
        } catch {
            throw error
        }
    }
    
    func subscribeToRealtimeTable(tableName: String) async throws {
        let myChannel = await supabaseClient.channel("\(tableName)RT")

        let changes = await myChannel.postgresChange(AnyAction.self, schema: "public", table: tableName)

        await myChannel.subscribe()

        for await change in changes {
            switch change {
            case .insert:
                if case .insert(_) = change {
                    // Handle insert action
                    try await updateTableData(tableName: tableName)
                }
            case .update:
                if case .update(_) = change {
                    // Handle update action
                    try await updateTableData(tableName: tableName)
                }
            case .delete:
                if case .delete(_) = change {
                    // Handle delete action
                    try await updateTableData(tableName: tableName)
                }
            case .select:
                if case .select(_) = change {
                    // Handle select action
                    try await updateTableData(tableName: tableName)
                }
            }
        }
    }

    func updateTableData(tableName: String) async throws {
        switch tableName {
        case "filmrating":
            try await updateFilmRatings()
        case "interaction":
            try await updateUserInteractions()
        default:
            print("Unknown table name: \(tableName)")
        }
    }


    func fetchFilmRatings() async throws -> [FilmRatingModel] { 
        let response = try await supabaseClient.from("filmrating").select().execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let filmRatings = try decoder.decode([FilmRatingModel].self, from: data)
            
            
            return filmRatings
        } catch {
            throw error
        }
    }
    
    func updateFilmRatings() async throws {
        // Fetch the updated film ratings from the database
        let updatedFilmRatings = try await fetchFilmRatings()
        // Update the @Published var
        DispatchQueue.main.async {
            self.filmRatings = updatedFilmRatings
        }
    }
    
    func updateUserInteractions() async throws {
        // Fetch the updated film ratings from the database
        let updatedUserInteractions = try await fetchUserInteractions(for: "1a4aa126000048f89c0e6d249f3249c2")
        // Update the @Published var
        DispatchQueue.main.async {
            self.userInteractions = updatedUserInteractions
        }
    }
    
}



