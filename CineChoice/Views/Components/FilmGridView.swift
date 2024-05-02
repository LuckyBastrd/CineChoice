//
//  FilmGrid.swift
//  TestCineChoice
//
//  Created by Bintang Anandhiya on 30/04/24.
//

import SwiftUI
import Kingfisher
import FCUUID

extension Hashable where Self: AnyObject {

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
    
extension Equatable where Self: AnyObject {

    static func == (lhs:Self, rhs:Self) -> Bool {
        return lhs === rhs
    }
}


class FilmGridModel: Hashable {
    var posterUrl: String
    var filmId: Int
    
    init(_ posterUrl: String,_ filmId: Int) {
        self.posterUrl = posterUrl
        self.filmId = filmId
    }
}

// CREATE A GRID CARD STRUCT
struct filmGridCard: View {
    let gs = UIScreen.main.bounds.width/17
    var imageUrl: String
    var filmId: Int
    
    @Binding var navigateToFilm: Bool
    @Binding var selectedFilmId: Int
    
    @State private var op = 1.0
    @State var hasPressed = false
    
    init(imageUrl: String, filmId: Int, navigateToFilm: Binding<Bool>,
         selectedFilmId: Binding<Int>){
//        sr = "c0" + String(Int.random(in: 1...4))
        self._navigateToFilm = navigateToFilm
        self._selectedFilmId = selectedFilmId
        
        self.imageUrl = imageUrl
        self.filmId = filmId
    }
    
    var body: some View {
        KFImage(URL(string: self.imageUrl)!)
            .resizable()
            .opacity(op)
            .scaledToFill()
            .frame(width: 7*gs,height: 11*gs)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                navigateToFilm = true
                selectedFilmId = filmId
                print(filmId)
            }
            .onLongPressGesture(minimumDuration: 1, maximumDistance: 400, pressing: {
                    pressing in
                    self.hasPressed = pressing
                if pressing {self.op = 0.5}
                if !pressing {self.op = 1.0}
                }, perform: {})
    }
}

struct FilmGridViewGenerator: View  {
    @EnvironmentObject var supabaseManager: SupabaseManager
    @Binding var filter: Int
    
    @Binding var navigateToFilm: Bool
    @Binding var selectedFilmId: Int
    
    var gs = UIScreen.main.bounds.width/17
    var columns = [
        GridItem(.flexible(minimum: (UIScreen.main.bounds.width/17)*7), spacing: (UIScreen.main.bounds.width/17)),
        GridItem(.flexible(minimum: (UIScreen.main.bounds.width/17)*7), spacing: (UIScreen.main.bounds.width/17))
    ]
    
    var input: [InteractionModel]
    
    var filmGridModelList: [FilmGridModel] = []
    
    init(input: [InteractionModel], filterd: Binding<Int>, navigateToFilm: Binding<Bool>, selectedFilmId: Binding <Int>) {
        self.input = input
        self._filter = filterd

        self._navigateToFilm = navigateToFilm
        self._selectedFilmId = selectedFilmId
    }
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyVGrid(columns: columns, spacing: gs) {
                ForEach(supabaseManager.userInteractions.indices, id: \.self) { n in
                    if supabaseManager.userInteractions[n].userID == FCUUID.uuidForDevice(){
                        
                        if(supabaseManager.userInteractions[n].action == "like" && filter == 0){
                            filmGridCard(imageUrl:supabaseManager.userInteractions[n].filmPoster, filmId: supabaseManager.userInteractions[n].filmID, navigateToFilm: $navigateToFilm, selectedFilmId: $selectedFilmId)
                        }
                        if(supabaseManager.userInteractions[n].action == "dislike" && filter == 1){
                            filmGridCard(imageUrl:supabaseManager.userInteractions[n].filmPoster, filmId: supabaseManager.userInteractions[n].filmID, navigateToFilm: $navigateToFilm, selectedFilmId: $selectedFilmId)
                        }
                        if(supabaseManager.userInteractions[n].action == "unseen" && filter == 2){
                            filmGridCard(imageUrl:supabaseManager.userInteractions[n].filmPoster, filmId: supabaseManager.userInteractions[n].filmID, navigateToFilm: $navigateToFilm, selectedFilmId: $selectedFilmId)
                        }
                    }
                    
                    
                }
            }
        }
    }
}

//#Preview {
//    FilmGridView([FilmGridModel("https://shucboqluxegybsrzyfz.supabase.co/storage/v1/object/sign/filmPosters/avengers%20endgame.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJmaWxtUG9zdGVycy9hdmVuZ2VycyBlbmRnYW1lLnBuZyIsImlhdCI6MTcxNDQ0OTg5MSwiZXhwIjoxNzQ1OTg1ODkxfQ.RSHkioYcUaAvEtpwSDRcw1saAlXsLNhRo6Q6QT9cz38&t=2024-04-30T04%3A04%3A51.960Z", "")])
//}
