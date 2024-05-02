//
//  ContentView.swift
//  CineChoice
//
//  Created by Lucky on 24/04/24.
//

import SwiftUI
import FCUUID

struct ContentView: View {
    
    
    @EnvironmentObject var supabaseManager: SupabaseManager
    
    @State var doneLogin = false
    @State var selectedTabs: Tabs = .swipe
    @State var navigateToQR = false
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if supabaseManager.user == nil{
                    if(doneLogin == false){
                        LoginView(doneLogin: $doneLogin)
                    }
                } else {
                    switch selectedTabs {
                    case .swipe:
                        MainView()
                    case .profile:
                        ProfileView()
                            .onAppear() {
                                supabaseManager.updateUserInteractions { error in
                                    if let error = error {
                                        print("Error updating user data: \(error)")
                                    } else {
                                        print("apdated user interaction successfuly")
                                    }
                                }
                            }
                    }
                    
                    CustomTabBarView(selectedTabs: $selectedTabs, navigateToQR: $navigateToQR)
                }
                
            }
            .navigationDestination(isPresented: $navigateToQR) {
                QRView()
            }
            
            
            
//            if navigateToQR {
//                Color.black.opacity(0.5)
//                    .edgesIgnoringSafeArea(.all)
//                
//                QRView()
//                    .transition(.move(edge: .bottom))
//                    .animation(.easeInOut(duration: 0.5))
//            }
        }
    }
}

struct ThemeAnimationStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title2)
            .foregroundColor(Color.white)
            .frame(height: 50, alignment: .center)
            .background(configuration.isPressed ? Color.green.opacity(0.5) : Color.green)
            .cornerRadius(8)
            .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0) //<- change scale value as per need. scaleEffect(configuration.isPressed ? 1.2 : 1.0)
    }
}

#Preview {
    ContentView()
}
