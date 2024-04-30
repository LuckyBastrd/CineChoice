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
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .global)
                    
                    KFImage(URL(string: card.film.filmPoster))
                        .resizable()
                        .scaledToFill()
                
                }
                
                GeometryReader { proxy in
                    BlurView(style: .systemThinMaterialDark)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
        }
    }  
}
