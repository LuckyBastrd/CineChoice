//
//  BlurView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView()
        
        DispatchQueue.global(qos: .background).async {
            // Perform blur effect initialization asynchronously
            let blurEffect = UIBlurEffect(style: style)
            
            DispatchQueue.main.async {
                // Update the UI on the main thread
                view.effect = blurEffect
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Do nothing
    }
}

