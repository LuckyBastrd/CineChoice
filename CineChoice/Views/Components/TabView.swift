//
//  TabView.swift
//  CineChoice
//
//  Created by Lucky on 29/04/24.
//

import SwiftUI

struct TestTabView: View {
    var body: some View {
        TabView {
            
            LoginView()
                .tabItem {
                    Image("CCIconLogo")
                }
            LoginView()
                .tabItem {
                    Image(systemName: "person.fill") 
                }
        }
        .onAppear() {
        UITabBar.appearance().barTintColor = .ccYellow
           }
    }
}

#Preview {
    TestTabView()
}
