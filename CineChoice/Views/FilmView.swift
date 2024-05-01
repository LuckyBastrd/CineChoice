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
                    
                    KFImage(URL(string: "https://v5.airtableusercontent.com/v3/u/28/28/1714399200000/pY_6TOtWGxIMgAbZF35Bgg/KFSt03snBSNIEqJOlVnxJx2QoMVjyw3ezA1xdQVtRQ_G3zHn1fkrFI6myoEH6eIMJS9y-wtG1LOBiQX4q58D59UhNAkGHTU8BaPhF8Y0oVOJ5irm7jnrDLgWlJgOkL2hPD6gsc9VyORLpBsIk62kRF1zueL4CMiT_eirNYeb65E/A5P5lQS0F6r3vcZ6b4xJ6ynKSecFieRFNR5LNCwMj98")!)
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

    private var gs = UIScreen.main.bounds.width/17
    
    var body: some View {
        ScrollView {
            VStack(spacing: gs) {
                
                HStack(spacing: gs){
                    
                    Image("c01")
                        .resizable()
                        .scaledToFill()
                        .frame(width: gs*7,height: gs*11)
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))

                    VStack(spacing:gs){
                        HStack{
                            
                            Image(systemName: "hand.thumbsup.circle.fill")
                                .resizable()
                                .foregroundColor(.yellow)
                                .scaledToFill()
                                .frame(width: gs)
                            Spacer()
                            Text("50%")
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
                            Text("33%")
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
                            Text("12%")
                                .font(.system(size: 25))
                                .foregroundStyle(.white)
                        }
                        .padding(20)
                        .frame(width: gs*7, height:gs*3)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("CCGray2")))
                        
                        
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
        .background(Color("CCGray1"))
        
        
        
    }
}

#Preview {
    FilmView()
}
