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
    //@StateObject var userViewModel = UserViewModel()
    
    //var appData: AppData = .init()
    @State var selectebTabs: Tabs = .swipe
    @State var navigateToQR = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if supabaseManager.user == nil {
                    LoginView()
                } else {
                    
                    switch selectebTabs {
                    case .swipe:
                        MainView()
                    case .profile:
                        TestView()
                    }
                    
                    CustomTabBarView(selectedTabs: $selectebTabs, navigateToQR: $navigateToQR)
                }
            }
//            .navigationDestination(isPresented: $navigateToQR) { 
//                QRView()
//            }
            
            if navigateToQR {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                QRView()
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5))
//                withAnimation(.easeInOut(duration: 20.0)) {
//                    QRView()
//                        .transition(.move(edge: .bottom))
//                }
            }
        }
    }
}

#Preview {
    ContentView()
}
