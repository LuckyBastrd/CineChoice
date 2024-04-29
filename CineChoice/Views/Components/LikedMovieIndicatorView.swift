//
//  LikedMovieIndicatorView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct LikedMovieIndicatorView: View {
    
    @Binding var xOffset: CGFloat
    //var isLikedCallback: (Bool) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "hand.thumbsup.circle")
                .resizable()
                .frame(width: 130, height: 130)
                .foregroundColor(.ccYellow)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .opacity(Double(xOffset / SizeConstant.screenXCutOff))
            
            Spacer()
        }
    }
}

//#Preview {
//    LikedMovieIndicatorView(xOffset: .constant(200))
//}
