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
            Text("LIKE: \(supabaseManager.filmRatings[0].filmLike)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
            
            Text("DISLIKE: \(supabaseManager.filmRatings[0].filmDislike)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
            
            Text("UNSEEN: \(supabaseManager.filmRatings[0].filmUnseen)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
            
            Text("TOTALRATING: \(supabaseManager.filmRatings[0].totalRating)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
        }
        .frame(width: 300, height: 300)
//        .onAppear{
//            AudioPlayer.stopMusic()
//        }
    }
}

#Preview {
    TestView()
}
