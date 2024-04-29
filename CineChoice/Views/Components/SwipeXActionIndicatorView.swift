//
//  SwipeActionIndicatorView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct SwipeXActionIndicatorView: View {
    
    @Binding var xOffset: CGFloat
    
    var body: some View {
        HStack {
            Image(systemName: "hand.thumbsup.circle")
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(.ccYellow)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .opacity(Double(xOffset / SizeConstant.screenXCutOff))
            
            Spacer()
            
            Image(systemName: "hand.thumbsdown.circle")
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(.ccRed)
                .shadow(radius: 10)
                .opacity(Double(xOffset / SizeConstant.screenXCutOff) * -1)
        }
        .padding(40)
    }
}

#Preview {
    MainView()
}
