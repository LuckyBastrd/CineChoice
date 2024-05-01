////
////  UserViewModel.swift
////  CineChoice
////
////  Created by Lucky on 30/04/24.
//
//import SwiftUI
//
//class UserViewModel: ObservableObject {
//    
//    @Published var user = [UserModel]()
//    
//    func fetchUser(for userid: String) async throws {
//        let fetchedUser = try await SupabaseManager.shared.fetchUser(for: userid)
//        
//        DispatchQueue.main.async {
//            self.user = fetchedUser
//        }
//    }
//    
//}
