//
//  FilmGrid.swift
//  TestCineChoice
//
//  Created by Bintang Anandhiya on 30/04/24.
//

import SwiftUI
import Kingfisher

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
    var redirectStuff: String
    
    init(_ posterUrl: String,_ redirectStuff: String) {
        self.posterUrl = posterUrl
        self.redirectStuff = redirectStuff
    }
}



struct FilmGridView: View {
    var gs: CGFloat
    var columns: Array<GridItem>
    var data: [FilmGridModel]
    
    init(_ filmGridModels: Array<FilmGridModel>){
        self.gs = UIScreen.main.bounds.width/17
        self.columns = [
            GridItem(.flexible(minimum: gs*7), spacing: gs),
            GridItem(.flexible(minimum: gs*7), spacing: gs)
        ]
        
        self.data = filmGridModels
    }
    
    // CREATE A GRID CARD STRUCT
    struct filmGridCard: View {
        let gs = UIScreen.main.bounds.width/17
        var imageUrl: String
        var sr = ""
        @State private var op = 1.0
        @State var hasPressed = false
        
        init(imageUrl: String){
    //        sr = "c0" + String(Int.random(in: 1...4))
            self.imageUrl = imageUrl
        }
        
        var body: some View {
            KFImage(URL(string: self.imageUrl)!)
                .resizable()
                .opacity(op)
                .scaledToFill()
                .frame(width: 7*gs,height: 11*gs)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {  }
                .onLongPressGesture(minimumDuration: 1, maximumDistance: 400, pressing: {
                        pressing in
                        self.hasPressed = pressing
                    if pressing {self.op = 0.5}
                    if !pressing {self.op = 1.0}
                    }, perform: {})
        }
    }
    
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyVGrid(columns: columns, spacing: gs) {
                ForEach(self.data, id: \.self) { n in
                    
                    filmGridCard(imageUrl:n.posterUrl)
                    
                }
            }
        }
    }
}

struct FilmGridViewGenerator: View  {
    
    @Binding var filter: Int
    var input: [InteractionModel]
    var filmGridModelList = [
        FilmGridModel("https://shucboqluxegybsrzyfz.supabase.co/storage/v1/object/sign/filmPosters/siksaKubur.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJmaWxtUG9zdGVycy9zaWtzYUt1YnVyLmpwZyIsImlhdCI6MTcxNDQxODMwNSwiZXhwIjoxNzQ1OTU0MzA1fQ.4u7NA9jq479kZPwEkSoIEFmmd_ULNefH7lmuXwoTysA&t=2024-04-29T19%3A18%3A25.323Z", "")
    ]
    
    init(input: [InteractionModel], filterd: Binding<Int>) {
        self.input = input
        self._filter = filterd
        //print("sdfdfsdf: " + String(filter))
        
        if(!self.input.isEmpty){
            filmGridModelList = []
            for interaction in self.input {
                if(interaction.action == "like" && filter == 0){
                    filmGridModelList.append(FilmGridModel(interaction.filmPoster, ""))
                }
                if(interaction.action == "dislike" && filter == 1){
                    filmGridModelList.append(FilmGridModel(interaction.filmPoster, ""))
                }
                if(interaction.action == "unseen" && filter == 2){
                    filmGridModelList.append(FilmGridModel(interaction.filmPoster, ""))
                }
                    
            }
        }
        
    }
    
    var body: some View {
        FilmGridView(filmGridModelList)
    }
}

#Preview {
    FilmGridView([FilmGridModel("https://shucboqluxegybsrzyfz.supabase.co/storage/v1/object/sign/filmPosters/avengers%20endgame.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJmaWxtUG9zdGVycy9hdmVuZ2VycyBlbmRnYW1lLnBuZyIsImlhdCI6MTcxNDQ0OTg5MSwiZXhwIjoxNzQ1OTg1ODkxfQ.RSHkioYcUaAvEtpwSDRcw1saAlXsLNhRo6Q6QT9cz38&t=2024-04-30T04%3A04%3A51.960Z", "")])
}
