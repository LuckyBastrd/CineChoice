//
//  TestView.swift
//  CineChoice
//
//  Created by Lucky on 30/04/24.
//

import SwiftUI
import Kingfisher

struct TestView: View {
    
    @EnvironmentObject var supabaseManager: SupabaseManager
    
    var body: some View {
        VStack {
            if let user = supabaseManager.user {
                KFImage(URL(string: user.userPicture))
                    .resizable()
                    .scaledToFill()
            }
            // Additional UI components using data from SupabaseManager
        }
        .frame(width: 300, height: 300)
        .onAppear{
            AudioPlayer.stopMusic()
        }
    }
}

#Preview {
    TestView()
}
