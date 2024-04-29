//
//  NotWatchYetMovieIndicatorView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct NotWatchYetMovieIndicatorView: View {
    
    @Binding var yOffset: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Image(systemName: "film.circle")
                    .resizable()
                    .frame(width: 130, height: 130)
                
                Image(systemName: "line.diagonal")
                    .resizable()
                    .frame(width: 95, height: 95)
            }
            .foregroundColor(.ccOtherGray)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .opacity(Double(yOffset / SizeConstant.screenYCutOff) * -1)
            
            Spacer()
        }
    }
}

#Preview {
    NotWatchYetMovieIndicatorView(yOffset: .constant(500))
}
