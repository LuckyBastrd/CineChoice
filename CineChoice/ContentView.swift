//
//  ContentView.swift
//  CineChoice
//
//  Created by Lucky on 24/04/24.
//

import SwiftUI
import FCUUID

struct ContentView: View {
    
    @StateObject var userViewModel = UserViewModel()
    
    var appData: AppData = .init()
    @State var selectebTabs: Tabs = .swipe
    @State var navigateToQR = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            if !appData.isSplashFinished {
                SplashView()
            }
            
            else {
                
                if userViewModel.user.isEmpty {
                    LoginView()
                } else {
                    switch selectebTabs {
                    case .swipe:
                        MainView(userid: FCUUID.uuidForDevice())
                    case .profile:
                        LoginView()
                    }
                    
                    CustomTabBarView(selectedTabs: $selectebTabs, navigateToQR: $navigateToQR)
                }
            }
        }
        .environment(appData)
        .navigationDestination(isPresented: $navigateToQR) { 
            //InformationView()
        }
        .onAppear {
            Task {
                do {
                    try await userViewModel.fetchUser(for: FCUUID.uuidForDevice())
                } catch {
                    print("Error fetching user data: \(error)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
