//
//  SwiftUIView.swift
//  StarNote
//
//  Created by Bintang Anandhiya on 25/04/24.
//

import SwiftUI
import Kingfisher

struct GridItemDemo2: View {
    
    var actionType: Int
    var gs = UIScreen.main.bounds.width/17
    var columns: Array<GridItem>
    
    let typeColors = [Color.yellow,Color.red,Color.gray]
    let typeIcon = ["hand.thumbsup.fill","hand.thumbsdown.fill", "eye.slash.fill"]
    
    init(actionType: Int){
        self.actionType = actionType
        let n = gs/3
        self.columns = [
            GridItem(.flexible(minimum: gs*3), spacing: n, alignment: .bottom),
            GridItem(.flexible(minimum: gs*3), spacing: n, alignment: .bottom),
            GridItem(.flexible(minimum: gs*3), spacing: n, alignment: .bottom),
            GridItem(.flexible(minimum: gs*3), spacing: n, alignment: .bottom)
        ]
    }

    var body: some View {
        VStack{
            LazyVGrid(columns: columns, spacing: gs/3) {
                
                Rectangle()
                    .fill(self.typeColors[self.actionType])
                    .frame(width: 3*gs,height: 4*gs)
                    .overlay{
                        Image(systemName: self.typeIcon[self.actionType])
                            .resizable()
                            .scaledToFill()
                            .frame(width: gs, height: gs)
                            .foregroundColor(Color("CCGray1"))
                    }
                    .clipShape(
                        .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 8,
                            bottomTrailingRadius: 8,
                            topTrailingRadius: 0
                        )
                    )
                    
                ForEach(0...22, id: \.self) { x in
                    
                    KFImage(URL(string: "https://shucboqluxegybsrzyfz.supabase.co/storage/v1/object/sign/filmPosters/avengers%20endgame.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJmaWxtUG9zdGVycy9hdmVuZ2VycyBlbmRnYW1lLnBuZyIsImlhdCI6MTcxNDQ0OTg5MSwiZXhwIjoxNzQ1OTg1ODkxfQ.RSHkioYcUaAvEtpwSDRcw1saAlXsLNhRo6Q6QT9cz38&t=2024-04-30T04%3A04%3A51.960Z")!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 3*gs,height: 3*gs)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
            }
                .padding([.horizontal,.bottom],gs)
        }
        .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(self.typeColors[self.actionType], lineWidth: 2)
                )
        .frame(width: 15*gs)
        
        
        
    }
}

struct FilmView: View {
    
    var selectedFilm: Int
    
    @EnvironmentObject var supabaseManager: SupabaseManager
    @Environment(\.presentationMode) var presentationMode
    
    private let gs = UIScreen.main.bounds.width/17
    
    init(selectedFilm: Int) {
        self.selectedFilm = selectedFilm
        print("WOIII: " + String(self.selectedFilm))
    }
    
    var body: some View {
        
        ScrollView {
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            
            VStack(spacing: gs) {
                
                HStack(spacing: gs){
                    VStack{
                        ForEach(supabaseManager.films.indices, id: \.self){ index in
                            Text(String(supabaseManager.films[index].filmID)).font(.system(size: 5)).foregroundStyle(.red)
                            Text(String(selectedFilm)).font(.system(size: 5)).foregroundStyle(.red)
                            if (supabaseManager.films[index].filmID == 12){
                                KFImage(URL(string: supabaseManager.films[index].filmPoster)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: gs*7,height: gs*11)
                                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                
                            }
                        }
                    }
                    

                    VStack(spacing:gs){
                        ForEach(supabaseManager.filmRatings.indices, id: \.self){ index in
                            if (supabaseManager.filmRatings[index].filmID == selectedFilm){
                                
                                
                                HStack{
                                    
                                    Image(systemName: "hand.thumbsup.circle.fill")
                                        .resizable()
                                        .foregroundColor(.yellow)
                                        .scaledToFill()
                                        .frame(width: gs)
                                    Spacer()
                                    
                                    Text(String(supabaseManager.filmRatings[index].averageLike)+"%")
                                        .font(.system(size: 25))
                                        .foregroundStyle(.white)
                                    
                                    
                                    
                                }
                                .padding(20)
                                .frame(width: gs*7, height:gs*3)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("CCGray2")))
                                
                                HStack{
                                    Image(systemName: "hand.thumbsdown.circle.fill")
                                        .resizable()
                                        .foregroundColor(.red)
                                        .scaledToFill()
                                        .frame(width: gs)
                                    Spacer()
                                    Text(String(supabaseManager.filmRatings[index].averageDislike)+"%")
                                        .font(.system(size: 25))
                                        .foregroundStyle(.white)
                                }
                                .padding(20)
                                .frame(width: gs*7, height:gs*3)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("CCGray2")))
                                
                                HStack{
                                    Image(systemName: "eye.slash.circle.fill")
                                        .resizable()
                                        .foregroundColor(Color(.lightGray))
                                        .scaledToFill()
                                        .frame(width: gs)
                                    Spacer()
                                    Text(String(supabaseManager.filmRatings[index].averageUnseen)+"%")
                                        .font(.system(size: 25))
                                        .foregroundStyle(.white)
                                }
                                .padding(20)
                                .frame(width: gs*7, height:gs*3)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("CCGray2")))
                            }
                        }
                        
                        
                        
                    }
                }
                
                
                
                
                HStack{
                        GridItemDemo2(actionType: 0)
                }
                HStack{
                        GridItemDemo2(actionType: 1)
                }
                HStack{
                        GridItemDemo2(actionType: 2)
                }
            }
            .frame(minWidth:17*gs,minHeight: 700)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("CCGray1"))
        
        
        
    }
}

//#Preview {
//    FilmView()
//}
