//
//  CardView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI
import Kingfisher
import CloudKit

struct CardView: View {
    
    @EnvironmentObject var supabaseManager: SupabaseManager
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var degrees: Double = 0
    @State private var isLoadingImage = true
    
    let cardCount: Int
    let card: CardModel
    let index: Int
    @Binding var currentIndex: Int 
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                ZStack {                         
                    KFImage(URL(string: card.film.filmPoster))
                        .resizable()
                        .scaledToFill()
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 10)
                        .frame(width: SizeConstant.cardWidth + 1, height: SizeConstant.cardHeight + 1)
                    
                    LikedMovieIndicatorView(xOffset: $xOffset)
                    DislikedMovieIndicatorView(xOffset: $xOffset)
                    NotWatchYetMovieIndicatorView(yOffset: $yOffset)
                }
            }
        }
        .frame(width: SizeConstant.cardWidth, height: SizeConstant.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset, y: yOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: xOffset)
        .animation(.snappy, value: yOffset)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    onDragChanged(value)
                })
                .onEnded({ value in
                    onDragEnded(value)
                })
        )
        .onAppear {  
            currentIndex = cardCount
        }
    }
}

private extension CardView {
    func xReturnToCentre() {
        xOffset = 0
        degrees = 0
    }
    
    func yReturnToCentre() {
        yOffset = 0
        degrees = 0
    }
    
    func swipeRight() {
        withAnimation { 
            xOffset = 500
            degrees = 12

        } completion: {
            DispatchQueue.main.async {
                UpdateManager.shared.updateCard(
                    card, 
                    from: supabaseManager,
                    action: "like",
                    like: 1,
                    dislike: 0,
                    unseen: 0)
                
                currentIndex -= 1
            }
        }
    }
    
    func swipeLeft() {
        withAnimation { 
            xOffset = -500
            degrees = -12
        } completion: {
            DispatchQueue.main.async {
                UpdateManager.shared.updateCard(
                    card, 
                    from: supabaseManager, 
                    action: "dislike",
                    like: 0,
                    dislike: 1,
                    unseen: 0)
                
                currentIndex -= 1
            }
        }
    }
    
    func swipeUp() {
        withAnimation { 
            yOffset = -1000
        } completion: {
            DispatchQueue.main.async {
                UpdateManager.shared.updateCard(
                    card, 
                    from: supabaseManager, 
                    action: "unseen",
                    like: 0,
                    dislike: 0,
                    unseen: 1)
                
                currentIndex -= 1
            }
        }
    }
}

private extension CardView {
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        
        if value.translation.height < 0 {
            yOffset = value.translation.height
        } 
        
        degrees = Double(value.translation.width / 25)
    }
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        let height = value.translation.height
        
        if abs(width) < abs(SizeConstant.screenXCutOff) && abs(height) < abs(SizeConstant.screenYCutOff) {
            xReturnToCentre()
            yReturnToCentre()
            
            return
        }
        
        if width >= SizeConstant.screenXCutOff {
            swipeRight()
        } else if width <= -SizeConstant.screenXCutOff {
            swipeLeft()
        } else if height >= SizeConstant.screenYCutOff {
            xReturnToCentre()
            yReturnToCentre()
        } else {
            swipeUp()
        }
    }
}

//#Preview {
//    MainView()
//}
