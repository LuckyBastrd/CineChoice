////
////  AirtableManager.swift
////  CineChoice
////
////  Created by Lucky on 29/04/24.
////
//
//import Foundation
//
//enum AirtableError: Error {
//    case invalidURL
//    case invalidResponse
//    case invalidData
//}
//
//class AirtableManager {
//    
//    static private let apiKey = "patvU5w2rnqH3xcvB.0ed1b1c062d8f5612ab7a53b9e3aa1ff50e3364b9e16e2ef4277f9427d202ca5"
//    
//    static func fetchData(from endpoint: String) async throws -> Data {
//        guard let url = URL(string: endpoint) else {
//            throw AirtableError.invalidURL
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//              httpResponse.statusCode == 200 else {
//            throw AirtableError.invalidResponse
//        }
//        
//        return data
//    }
//    
//    static func getUser(userID: String) async throws -> UserModel {
//        let endpoint = "https://api.airtable.com/v0/appKKHdh4otJLRhRI/tbl0ji1OLrL9NGGod?filterByFormula=({userID}='\(userID)')"
//        
//        let data = try await fetchData(from: endpoint)
//        
//        let decoder = JSONDecoder()
//        let userModel = try decoder.decode(UserModel.self, from: data)
//        
//        return userModel
//    }
//    
//    static func getFilms() async throws -> FilmModel {
//        let endpoint = "https://api.airtable.com/v0/appKKHdh4otJLRhRI/tblMFL0I9ApWJiAl2"
//        
//        let data = try await fetchData(from: endpoint)
//        
//        let decoder = JSONDecoder()
//        let filmModel = try decoder.decode(FilmModel.self, from: data)
//        
//        return filmModel
//    }
//}


//
//  AirtableManager.swift
//  CineChoice
//
//  Created by Lucky on 29/04/24.
//

import Foundation

enum AirtableError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class AirtableManager {
    
    static private let apiKey = "patvU5w2rnqH3xcvB.0ed1b1c062d8f5612ab7a53b9e3aa1ff50e3364b9e16e2ef4277f9427d202ca5"
    
    static private func fetchData(from endpoint: String) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            throw AirtableError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw AirtableError.invalidResponse
        }
        
        return data
    }
    
//    static func getUser(userID: String) async throws -> CommonModel {
//        let endpoint = "https://api.airtable.com/v0/appKKHdh4otJLRhRI/tbl0ji1OLrL9NGGod?filterByFormula=({userID}='\(userID)')"
//        
//        let data = try await fetchData(from: endpoint)
//        
//        let decoder = JSONDecoder()
//        let userModel = try decoder.decode(CommonModel.self, from: data)
//        
//        return userModel
//    }
    
    static func getFilms() async throws -> FilmModel {
        let endpoint = "https://api.airtable.com/v0/appKKHdh4otJLRhRI/tblMFL0I9ApWJiAl2"
        
        let data = try await fetchData(from: endpoint)
        
        let decoder = JSONDecoder()
        let filmModel = try decoder.decode(FilmModel.self, from: data)
        
        print(String(data: data, encoding: .utf8) ?? "Invalid data")
        
        return filmModel
    }
}


