//
//  InformationView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct InformationView: View {
    
    let ratings: FilmRatingModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 3) {
                InformationGridView(percentage: ratings.averageDislike, color: .ccYellow)
                InformationGridView(percentage: ratings.averageDislike, color: .ccRed)
                InformationGridView(percentage: ratings.averageDislike, color: .ccGray)
            }
        }
        .frame(width: SizeConstant.cardWidth, height: SizeConstant.cardHeight)
    }
}

// Preview
//struct InformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        InformationView(show: .constant(true), percentages: [30, 20, 50], systemImageNames: ["hand.thumbsup.fill", "hand.thumbsdown.fill", "film"])
//    }
//}
