//
//  CompatibilityView.swift
//  CineChoiceUI
//
//  Created by Leonardo Marhan on 26/04/24.
//

import SwiftUI
import FCUUID
import Kingfisher
import Supabase

struct CompatibilityView: View {
    @EnvironmentObject var supabaseManager: SupabaseManager
    @State private var userImage: UIImage?
    @State private var user: UserModel?
    @State private var userInteractions: [InteractionModel] = []
    
    let scannedCode: String
    
    var body: some View {
        
        ZStack{
            NavigationStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.ccGray)
                        .ignoresSafeArea()
                    VStack{
                        HStack{
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title2)
                            Spacer()
                        }
                        .padding(.horizontal)
                        Spacer()
                        ZStack{
                            Circle()
                                .foregroundColor(Color.ccOtherGray)
                                .frame(width: 250, height: 250)
                                .overlay{
                                    Circle()
                                        .stroke(Color.yellow, lineWidth: 8)
                                }
                            HStack{
                                KFImage(URL(string: (supabaseManager.user?.userPicture)!))
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 100,height: 100)
                                                        .clipShape(RoundedRectangle(cornerRadius: 17))
                                                        .padding(.leading, 20)
                                Spacer()
                                if !userInteractions.isEmpty && !supabaseManager.userInteractions.isEmpty{
                                    calculateCompatibility()
                                }
//                                Text("80%")
//                                    .foregroundColor(.white)
//                                    .bold()
//                                    .font(.system(size: 45))
                                Spacer()
                                KFImage(URL(string: user?.userPicture ?? ""))
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 100,height: 100)
                                                        .clipShape(RoundedRectangle(cornerRadius: 17))
                                                        .padding(.trailing, 20)
                            }
                        }
                        Spacer()
                        QRCodeView(deviceId: FCUUID.uuidForDevice())
                        Spacer()
                        
                    }
                    .onAppear{
                        fetchUserImage(userID: scannedCode)
                        fetchUserInformation(userID: scannedCode)
                    }
                }
            }
        }
        
    }
    
    func fetchUserImage(userID: String) {
           do {
               Task {
                   if let user = try await supabaseManager.fetchUser(for: userID).first {
                       // Update the user state variable
                       self.user = user
                       print("User found: \(user)")
                   } else {
                       print("User not found for ID: \(userID)")
                   }
               }
           }
       }
    
    func fetchUserInformation(userID: String) {
            do {
                Task {
                    if let user = try await supabaseManager.fetchUser(for: userID).first {
                        // Update the user state variable
                        self.user = user
                        print("User found: \(user)")
                        
                        // Fetch user interactions based on the user's ID
                        do {
                            let interactions = try await supabaseManager.fetchUserInteractions(for: userID)
                            // Update the userInteractions state variable
                            self.userInteractions = interactions
                            print("User interactions found: \(interactions)")
                        } catch {
                            print("Error fetching user interactions: \(error)")
                        }
                    } else {
                        print("User not found for ID: \(userID)")
                    }
                }
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    
    func calculateCompatibility() -> some View {
        var sameCount = 0.00
        var diffCount = 0.00

        for interaction1 in userInteractions {
            for interaction2 in supabaseManager.userInteractions {
                if interaction1.filmID == interaction2.filmID {
                    if interaction1.action == interaction2.action {
                        sameCount += 1
                        break
                    } else {
                        diffCount += 1
                    }
                }
            }
        }
        
        var percentage = (sameCount / (sameCount + diffCount)) * 100
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        let formattedPercentage = formatter.string(from: NSNumber(value: percentage))
        
        return Text("\(formattedPercentage ?? "")%")
            .foregroundColor(.white)
            .bold()
            .font(.system(size: 45))
    }
}
//
//#Preview {
//    CompatibilityView()
//}
