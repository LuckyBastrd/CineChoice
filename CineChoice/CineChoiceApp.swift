//
//  CineChoiceApp.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

@main
struct CineChoiceApp: App {
    
    @StateObject var supabaseManager = SupabaseManager()
    @StateObject var updateManager = UpdateManager()
    @StateObject var createManager = CreateManager()
    
    var appData: AppData = .init()
    
    init() {
        if UserDefaults.standard.object(forKey: "dataFetched") == nil {
            UserDefaults.standard.set(true, forKey: "dataFetched")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !appData.isSplashFinished {
                    SplashView()
                } else {
                    ContentView()
                }
            }
            .onAppear {
                supabaseManager.fetchInitialDataAndSubscribe() { error in
                    if let error = error {
                        print("Error fetching initial data: \(error)")
                    } else {
                        print("Initial data fetched successfully by windowgroup")
                    }
                }
            }
        }
        .environmentObject(supabaseManager)
        .environmentObject(updateManager)
        .environmentObject(createManager)
        .environment(appData)
    }
}
