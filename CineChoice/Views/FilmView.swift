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
    var selectedFilm: Int
    
    @EnvironmentObject var supabaseManager: SupabaseManager
    
    let typeColors = [Color.yellow,Color.red,Color.gray]
    let typeIcon = ["hand.thumbsup.fill","hand.thumbsdown.fill", "eye.slash.fill"]
    let typeString = ["like", "dislike", "unseen"]
    
    init(actionType: Int, selectedFilm: Int){
        self.actionType = actionType
        let n = gs/3
        self.columns = [
            GridItem(.flexible(minimum: gs*3), spacing: n, alignment: .bottom),
            GridItem(.flexible(minimum: gs*3), spacing: n, alignment: .bottom),
            GridItem(.flexible(minimum: gs*3), spacing: n, alignment: .bottom),
            GridItem(.flexible(minimum: gs*3), spacing: n, alignment: .bottom)
        ]
        self.selectedFilm = selectedFilm
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
                    
                ForEach(supabaseManager.allInteractions.indices, id: \.self) { x in
                    if supabaseManager.allInteractions[x].filmID == selectedFilm{
                        if supabaseManager.allInteractions[x].action == typeString[actionType]{
                            KFImage(URL(string: supabaseManager.allInteractions[x].userPicture)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 3*gs,height: 3*gs)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                        }
                    }
                    
                    
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
                    ForEach(supabaseManager.allFilms.indices, id: \.self){ index in
                        if (supabaseManager.allFilms[index].filmID == selectedFilm){
                            KFImage(URL(string: supabaseManager.allFilms[index].filmPoster)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: gs*7,height: gs*11)
                                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                            
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
                        GridItemDemo2(actionType: 0, selectedFilm: selectedFilm)
                }
                HStack{
                        GridItemDemo2(actionType: 1, selectedFilm: selectedFilm)
                }
                HStack{
                        GridItemDemo2(actionType: 2, selectedFilm: selectedFilm)
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
