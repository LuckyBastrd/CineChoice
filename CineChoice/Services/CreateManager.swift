//
//  CreateManager.swift
//  CineChoice
//
//  Created by Lucky on 01/05/24.
//

import Foundation
import Supabase

class CreateManager: ObservableObject {
    
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
    
    func createNewUser(completion: @escaping (Error?) -> Void, userId: String, imageData: Data){
        Task{
            do{
                let fileName = "pp_"+userId+".png"
                try await supabaseClient.storage
                    .from("userPictures")
                    .upload(path: fileName, file: imageData, options: FileOptions(
                        cacheControl: "3600",
                        contentType: "image/png",
                        upsert: true
                      ))
                
                let signedURL = try await supabaseClient.storage
                  .from("userPictures")
                  .createSignedURL(path: fileName, expiresIn: 360)
                
                let temp = UserModel(userID: userId, userPicture: signedURL.absoluteString, userAction: 0)
                try await supabaseClient
                  .from("user")
                  .insert(temp)
                  .execute()
                
                completion(nil)
                
            }catch{
                completion(error)
            }
        }
    }
    
    func fetchUser(for userid: String, from supaBaseManager: SupabaseManager) async throws -> [UserModel] {

        let response = try await supabaseClient.from("user").select().equals("userID", value: userid).execute()
        
        let data = response.data
        
        let decoder = JSONDecoder()
        
        do {
            let users = try decoder.decode([UserModel].self, from: data)
            
            DispatchQueue.main.async {
                supaBaseManager.user = users.first
            }
            
            return users
        } catch {
            throw error
        }
    }
    
}
