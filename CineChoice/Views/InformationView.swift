//
//  InformationView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct InformationView: View {
    
    let ratings: FilmRatingModel
    @Binding var showInformation: Bool
    @State var selectedAction: String
    
    var body: some View {
        
        let totalPercentage = ratings.averageLike + ratings.averageDislike + ratings.averageUnseen
        
        ZStack {
            
            BlurView(style: .systemThinMaterialDark)
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                VStack(spacing: 3) {
                    InformationGridView(percentage: ratings.averageLike, color: .ccYellow, totalPercentage: CGFloat(totalPercentage), maxHeight: maxAllowedHeight(), selectedAction: selectedAction)
                    InformationGridView(percentage: ratings.averageDislike, color: .ccRed, totalPercentage: CGFloat(totalPercentage), maxHeight: maxAllowedHeight(), selectedAction: selectedAction)
                    InformationGridView(percentage: ratings.averageUnseen, color: .ccOtherGray, totalPercentage: CGFloat(totalPercentage), maxHeight: maxAllowedHeight(), selectedAction: selectedAction)
                }
            }
            .frame(width: SizeConstant.cardWidth, height: SizeConstant.cardHeight)
        }
        .onTapGesture {
            showInformation = false
        }
    }
}

private extension InformationView {
    
    private func maxAllowedHeight() -> CGFloat {
        let totalPercentage = ratings.averageLike + ratings.averageDislike + ratings.averageUnseen
        return min((SizeConstant.cardWidth), CGFloat(totalPercentage) * (SizeConstant.cardHeight))
    }
    
}

//struct StrokeModifier: ViewModifier {
//    
//    var selectedAction: String
//    var giveStroke: Bool = false
//    
//    var shouldApplyStroke: Bool {
//        if selectedAction == "like" {
//            return true
//        } else if selectedAction == "dislike" {
//            return true
//        } else if selectedAction == "unseen" {
//            return true
//        } else {
//            return giveStroke
//        }
//    }
//    
//    func body(content: Content) -> some View {
//        content.overlay(Rectangle().stroke(Color.white, lineWidth: giveStroke ? 5: 0))
//    }
//}

// Preview
//struct InformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        InformationView(show: .constant(true), percentages: [30, 20, 50], systemImageNames: ["hand.thumbsup.fill", "hand.thumbsdown.fill", "film"])
//    }
//}
