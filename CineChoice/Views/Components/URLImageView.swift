//
//  URLImageView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI

struct URLImageView: View {
    let url: String
    @State private var imageData: Data?
    
    var body: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            ProgressView("")
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    // Fetch image data asynchronously
                    loadImage(from: url)
                }
        }
    }
    
    private func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
        }.resume()
    }
}
