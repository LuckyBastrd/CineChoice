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
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(color)
                .frame(height: getHeight())
                .cornerRadius(10)
            
            Text("\(percentage) %")
                .font(.system(size: 30))
                .foregroundColor(.black)
                .background(.clear)
                .padding(.horizontal, 3)
        }
    }
    
    private func getHeight() -> CGFloat {
        return (UIScreen.main.bounds.height / 1.45) * CGFloat(percentage)
    }
}

//#Preview {
//    InformationGridView()
//}
