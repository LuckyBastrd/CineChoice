//
//  AirtableManager.swift
//  CineChoice
//
//  Created by Lucky on 29/04/24.
//

import Foundation

enum getUserError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class AirtableManager {
    
    static func getUser(userID: String) async throws -> UserModel {
        let apiKey = "patvU5w2rnqH3xcvB.0ed1b1c062d8f5612ab7a53b9e3aa1ff50e3364b9e16e2ef4277f9427d202ca5"
        let baseURL = "https://api.airtable.com/v0/appKKHdh4otJLRhRI/tbl0ji1OLrL9NGGod"
        //let baseURL = "https://api.airtable.com/v0/appKKHdh4otJLRhRI/tbl0ji1OLrL9NGGod?filterByFormula=FIND(%22'\(userID)'%22%2CuserID)"
        
        guard let url = URL(string: "\(baseURL)?filterByFormula=({userID}='\(userID)')") else {
            throw getUserError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw getUserError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            let userModel = try decoder.decode(UserModel.self, from: data)
            
            return userModel
        } catch {
            throw getUserError.invalidData
        }
    }
    
//    static func getFilm() async throws -> UserModel {
//        let apiKey = "patvU5w2rnqH3xcvB.0ed1b1c062d8f5612ab7a53b9e3aa1ff50e3364b9e16e2ef4277f9427d202ca5"
//        let baseURL = "https://api.airtable.com/v0/appKKHdh4otJLRhRI/tbl0ji1OLrL9NGGod"
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  httpResponse.statusCode == 200 else {
//                throw getUserError.invalidResponse
//            }
//            
//            let decoder = JSONDecoder()
//            let userModel = try decoder.decode(UserModel.self, from: data)
//            
//            return userModel
//        } catch {
//            throw getUserError.invalidData
//        }
//    }
    
}
