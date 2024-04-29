//
//  BlurBackgroundView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct BlurBackgroundView: View {
    
    @State private var isLoadingImage = true
    
    let card: CardModel
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .global)
//                    if let url = card.film.filmPoster.fileURL {
//                        URLImageView(url: url.absoluteString)
//                            .frame(width: frame.size.width, height: frame.size.height)
//                    }
                    
                    if isLoadingImage {
                        Rectangle()
                            .foregroundColor(.ccGray)
                    } else {
                        URLImageView(url: card.film.filmPoster.fileURL?.absoluteString ?? "")
                            .frame(width: frame.size.width, height: frame.size.height)
                    }
                }
                
                GeometryReader { proxy in
                    BlurView(style: .systemThinMaterialDark)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
        }
        .onAppear {  
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                isLoadingImage = false
            }
        }
    }  
}
