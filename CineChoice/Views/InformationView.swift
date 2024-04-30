//
//  InformationView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct InformationView: View {
    
    @Binding var show: Bool
    var percentages: [CGFloat]
    var systemImageNames: [String]
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ForEach(0..<self.percentages.count, id: \.self) { index in
                        ZStack {
                            Rectangle()
                                .foregroundColor(self.colors[index])
                                .cornerRadius(10)
                            
                            HStack {
                                Text("\(Int(self.percentages[index]))%")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                                    .background(.clear)
                                    .padding(.horizontal, 3)
                                
                                
                                Image(systemName: self.systemImageNames[index])
                                            .resizable()
                                            .foregroundColor(.black)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45, height: 45)
                                            .padding(.horizontal, 3)
                            }
                            
                            

                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * self.percentages[index] / 100)
                    }
                }
            }
        }
        .frame(width: SizeConstant.cardWidth, height: SizeConstant.cardHeight)
    }
    
    // Example colors, you can replace with your own
    let colors: [Color] = [.ccYellow, .ccRed, .ccOtherGray]
}

// Preview
struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(show: .constant(true), percentages: [30, 20, 50], systemImageNames: ["hand.thumbsup.fill", "hand.thumbsdown.fill", "film"])
    }
}
