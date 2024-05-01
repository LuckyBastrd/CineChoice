//
//  EmptyCardView.swift
//  CineChoice
//
//  Created by Lucky on 01/05/24.
//

import SwiftUI
import Kingfisher

struct EmptyCardView: View {
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in
                    Image("CitizenKane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                GeometryReader { proxy in
                    BlurView(style: .systemThinMaterialDark)
                }
                
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.ccRed)
            }
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

#Preview {
    EmptyCardView()
}
