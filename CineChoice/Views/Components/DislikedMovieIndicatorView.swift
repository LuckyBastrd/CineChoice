//
//  DislikedMovieIndicatorView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct DislikedMovieIndicatorView: View {
    
    @Binding var xOffset: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "hand.thumbsdown.circle")
                .resizable()
                .frame(width: 130, height: 130)
                .foregroundColor(.ccRed)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .opacity(Double(xOffset / SizeConstant.screenXCutOff) * -1)
            
            Spacer()
        }
    }
}

#Preview {
    DislikedMovieIndicatorView(xOffset: .constant(-200))
}
