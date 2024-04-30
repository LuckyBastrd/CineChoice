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
    
    //@ObservedObject var filmViewModel = FilmViewModel()
    @ObservedObject var cardViewModel = CardViewModel()
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var degrees: Double = 0
    @State private var isLoadingImage = true
    
    let cardCount: Int
    //let film: FilmModel
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                if let soundtrackURL = URL(string: card.film.filmSoundtrack) {
                    AudioPlayer.playMusic(url: soundtrackURL)
                    currentIndex = cardCount
                } else {
                    print("Invalid soundtrack URL")
                }
            }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cardViewModel.removeCard(card)
                
                currentIndex -= 1
            }
        }
    }
    
    func swipeLeft() {
        withAnimation { 
            xOffset = -500
            degrees = -12
        } completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cardViewModel.removeCard(card)
                
                currentIndex -= 1
            }
        }
    }
    
    func swipeUp() {
        withAnimation { 
            yOffset = -1000
        } completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cardViewModel.removeCard(card)
                
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
            print("RIGHT")
            swipeRight()
        } else if width <= -SizeConstant.screenXCutOff {
            print("LEFT")
            swipeLeft()
        } else if height >= SizeConstant.screenYCutOff {
            xReturnToCentre()
            yReturnToCentre()
        } else {
            print("UP")
            swipeUp()
        }
    }
}

//#Preview {
//    MainView()
//}
