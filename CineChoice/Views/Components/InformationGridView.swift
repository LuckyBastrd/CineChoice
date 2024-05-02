//
//  InformationGridView.swift
//  CineChoice
//
//  Created by Lucky on 02/05/24.
//

import SwiftUI

struct InformationGridView: View {

    let percentage: Int
    let color: Color
    let totalPercentage: CGFloat
    let maxHeight: CGFloat
    let selectedAction: String
    
    var body: some View {
        ZStack {
            if percentage != 0 {
                Rectangle()
                    .foregroundColor(color)
                    .frame(height: min(getHeight(), SizeConstant.cardHeight))
                    .cornerRadius(10)
                
                Text("\(percentage) %")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                    .background(.clear)
                    .padding(.horizontal, 3)
            }
        }
    }
    
    private func getHeight() -> CGFloat {
        return (maxHeight / totalPercentage) * CGFloat(percentage)
    }
}

//#Preview {
//    InformationGridView()
//}
