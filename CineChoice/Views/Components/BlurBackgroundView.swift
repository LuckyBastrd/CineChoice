//
//  BlurBackgroundView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI
import Kingfisher

struct BlurBackgroundView: View {
    
    let card: CardModel
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in
                    KFImage(URL(string: card.film.filmPoster))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                GeometryReader { proxy in
                    BlurView(style: .systemThinMaterialDark)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
        }
    }  
}
