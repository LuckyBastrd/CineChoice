//
//  QRCodeView.swift
//  CineChoiceUI
//
//  Created by Leonardo Marhan on 26/04/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var deviceId : String
    
    var body: some View {
        Image(uiImage: generateQRCode(deviceId))
            .interpolation(.none)
            .resizable()
            .cornerRadius(10)
            .frame(width: 220, height: 220)
    }
    
    func generateQRCode(_ deviceId : String) -> UIImage {
        let data = Data(deviceId.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage{
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
