//
//  ContentView.swift
//  CineChoice
//
//  Created by Lucky on 24/04/24.
//

import SwiftUI
import FCUUID

struct ContentView: View {
    
    var appData: AppData = .init()
    @State var selectebTabs: Tabs = .swipe
    @State var navigateToQR = false
    
    @State private var userID = FCUUID.uuidForDevice()
    
    @State private var userModel: UserModel?
    
    var body: some View {
        VStack(spacing: 0) {
            
            if !appData.isSplashFinished {
                SplashView()
            }
            
            else {
                if let records = userModel?.records, !records.isEmpty {
                    switch selectebTabs {
                    case .swipe:
                        MainView()
                    case .profile:
                        LoginView()
                    }
                    
                    CustomTabBarView(selectedTabs: $selectebTabs, navigateToQR: $navigateToQR)
                    
                } else {
                    LoginView()
                }
            }
        }
        .environment(appData)
        .navigationDestination(isPresented: $navigateToQR) { 
            InformationView()
        }
        .onAppear {
            Task {
                do {
                    self.userModel = try await AirtableManager.getUser(userID: userID ?? "default")
                    
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
