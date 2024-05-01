//
//  SplashView.swift
//  CineChoice
//
//  Created by Lucky on 24/04/24.
//

import SwiftUI
import Lottie

struct SplashView: View {
    
    @Environment(AppData.self) private var appData
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(.ccYellow)
                .overlay {
                    if let jsonurl {
                        LottieView {
                            await LottieAnimation.loadedFrom(url: jsonurl)
                        }
                        .playing(.fromProgress(0, toProgress: progress, loopMode: .playOnce))
                        .animationDidFinish{ completed in
                            appData.isSplashFinished = progress != 0 && completed
                        }
                        .task {
                            try? await Task.sleep(for: .seconds(1.3))
                            progress = 0.58
                        }
                    } 
                } 
                .ignoresSafeArea()
        }
    }
    
    private var jsonurl: URL? {
        if let bundlePath = Bundle.main.path(forResource: "CineChoiceLogoAnimation", ofType: "json") {
            return URL(filePath: bundlePath)
        }
        
        return nil
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
