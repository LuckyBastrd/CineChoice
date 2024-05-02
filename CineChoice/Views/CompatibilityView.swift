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
                        NavigationLink (destination: ScanView()){
                            HStack{
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .navigationBarBackButtonHidden(true)
                        
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
                        fetchUserInformation(userID: scannedCode)
                    }
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
                        
                        // Fetch user interactions based on the user's ID
                        do {
                            let interactions = try await supabaseManager.fetchUserInteractions(for: userID)
                            // Update the userInteractions state variable
                            self.userInteractions = interactions
                        } catch {
                            print("Error fetching user interactions: \(error)")
                        }
                    } else {
                        print("User not found for ID: \(userID)")
                    }
                }
            }
        }
    
    func calculateCompatibility() -> some View {
        var sameCount = 0.00
        var diffCount = 0.00
        
        let userInteractionSet: Set<String> = Set(userInteractions.map { "\($0.filmID)-\($0.action)" })
        let supabaseInteractionSet: Set<String> = Set(supabaseManager.userInteractions.map { "\($0.filmID)-\($0.action)" })
            
            // Determine the smaller set and iterate over it to check for matches
        let smallerSet = userInteractionSet.count < supabaseInteractionSet.count ? userInteractionSet : supabaseInteractionSet
        let largerSet = userInteractionSet.count < supabaseInteractionSet.count ? supabaseInteractionSet : userInteractionSet
            
        for interaction in smallerSet {
            // If the interaction exists in the larger set, it's a match
            if largerSet.contains(interaction) {
                sameCount += 1
            } else {
                diffCount += 1
            }
        }
        
//        if supabaseManager.userInteractions.count < userInteractions.count {
//            for interaction1 in userInteractions {
//                for interaction2 in supabaseManager.userInteractions {
//                    if interaction1.filmID == interaction2.filmID {
//                        if interaction1.action == interaction2.action {
//                            sameCount += 1
//                        } else {
//                            diffCount += 1
//                        }
//                        break
//                    }
//                }
//            }
//        } else {
//            for interaction1 in supabaseManager.userInteractions {
//                for interaction2 in userInteractions {
//                    print(interaction1.filmTitle + " DAN " + interaction2.filmTitle)
//                    if interaction1.filmID == interaction2.filmID {
//                        if interaction1.action == interaction2.action {
//                            sameCount += 1
//                        } else {
//                            diffCount += 1
//                        }
//                        break
//                    }
//                }
//            }
//        }
                
        let percentage = (sameCount / (sameCount + diffCount)) * 100
        
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
