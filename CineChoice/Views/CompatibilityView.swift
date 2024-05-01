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
                                Text("80%")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.system(size: 45))
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
                       print("User found: \(user)")
                   } else {
                       print("User not found for ID: \(userID)")
                   }
               }
           }
       }
}
//
//#Preview {
//    CompatibilityView()
//}
