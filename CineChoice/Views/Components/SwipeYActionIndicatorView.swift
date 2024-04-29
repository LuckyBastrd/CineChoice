//
//  SwipeYActionIndicatorVIew.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct SwipeYActionIndicatorView: View {
    
    @Binding var yOffset: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "film.circle")
                    .resizable()
                    .frame(width: 70, height: 70)
                
                Image(systemName: "line.diagonal")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .foregroundColor(.ccOtherGray)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .opacity(Double(yOffset / SizeConstant.screenYCutOff))
            
            Spacer()
            
            ZStack {
                Image(systemName: "film.circle")
                    .resizable()
                    .frame(width: 70, height: 70)
                
                Image(systemName: "line.diagonal")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .foregroundColor(.ccOtherGray)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .opacity(Double(yOffset / SizeConstant.screenYCutOff) * -1)
        }
        .padding(40)
    }
}

#Preview {
    MainView()
}
