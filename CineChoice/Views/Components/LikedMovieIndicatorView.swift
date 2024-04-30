//
//  LikedMovieIndicatorView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct LikedMovieIndicatorView: View {
    
    @Binding var xOffset: CGFloat
    
    var body: some View {
        ZStack {
            Spacer()
            
            Image(systemName: "hand.thumbsup.circle")
                .resizable()
                .frame(width: 130, height: 130)
                .foregroundColor(.ccYellow)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .opacity(Double(xOffset / SizeConstant.screenXCutOff))
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(.ccYellow, lineWidth: 10)
                //.frame(width: 374, height: 588)
                .frame(width: SizeConstant.cardWidth + 1, height: SizeConstant.cardHeight + 1)
                .opacity(Double(xOffset / SizeConstant.screenXCutOff))
            
            
            Spacer()
        }
    }
}

#Preview {
    LikedMovieIndicatorView(xOffset: .constant(200))
}
