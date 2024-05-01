//
//  EmptyCardView.swift
//  CineChoice
//
//  Created by Lucky on 01/05/24.
//

import SwiftUI

struct EmptyCardView: View {
    var body: some View {
        ZStack {
            ZStack {
                GeometryReader { geo in
//                    Rectangle()
//                        .fill(Color.gray)
//                        .scaledToFill()
//                        .frame(width: geo.size.width, height: geo.size.height)
                    
                    Image(systemName: "film.circle")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .foregroundColor(.red)
                    
                    Image(systemName: "line.diagonal")
                        .resizable()
                        .frame(width: 95, height: 95)
                        .foregroundColor(.red)
                }
                
//                GeometryReader { proxy in
//                    BlurView(style: .systemThinMaterialDark)
//                }
            }
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

#Preview {
    EmptyCardView()
}
