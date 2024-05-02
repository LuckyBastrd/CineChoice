//
//  ScanView.swift
//  CineChoiceUI
//
//  Created by Leonardo Marhan on 25/04/24.
//

import Foundation
import SwiftUI
import AVKit

struct ScanView: View {
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment (\.openURL) private var openURL
    @StateObject private var qrDelegate = QRScannerDelegate()
    @State private var scannedCode: String = ""
    @EnvironmentObject var supabaseManager: SupabaseManager
    @State private var scannedUserID: String? = nil
//    @State private var scannedUserImage: UIImage?
    @State private var isShowingView = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                ZStack{
                    NavigationLink(
                        destination: EmptyView(), // Pass scannedCode
                        isActive: $isShowingView,
                        label: {
                            EmptyView() // Invisible navigation link trigger
                        })
                        .opacity(0)
                        .navigationBarBackButtonHidden(true)
                    Rectangle()
                        .fill(Color("ccGray"))
                        .ignoresSafeArea()
                    VStack{
                        NavigationLink (destination: ContentView()){
                            HStack{
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .navigationBarBackButtonHidden(true)
                        
                        Spacer()
                        //Scanner
                        GeometryReader{ geometry in
                            ZStack{
                                CameraView(frameSize: CGSize(width: geometry.size.width, height: geometry.size.width), session: $session)
                                    .scaleEffect(0.97)
                                
                                ForEach(0...4, id: \.self) { index in
                                    let rotation = Double(index) * 90
                                    
                                    RoundedRectangle(cornerRadius: 2, style: .circular)
                                        .trim(from: 0.58, to: 0.67)
                                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                                        .rotationEffect(.init(degrees: rotation))
                                }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            //Animation
                            .overlay(alignment: .top, content:{
                                Rectangle()
                                    .fill(Color.yellow)
                                    .frame(height: 3)
                                    .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                                    .offset(y: isScanning ? geometry.size.width : 0)
                            })
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onAppear{
                                checkCameraPermission()
                            }
                            .alert(errorMessage, isPresented: $showError){
                                if cameraPermission == .denied {
                                    Button("Settings") {
                                        let settingsString = UIApplication.openSettingsURLString
                                        if let settingsURL = URL(string: settingsString){
                                            openURL(settingsURL)
                                        }
                                    }
                                    Button("Cancel", role: .cancel){
                                        
                                    }
                                }
                            }
                            .onChange(of: qrDelegate.scannedCode) { newValue in
                                if let code = newValue {
                                    scannedCode = code
                                    session.stopRunning()
                                    stopScanAnimation()
                                    print(code)
                                    qrDelegate.scannedCode = nil
                                    isShowingView = true
                                    return
                                }
                            }
                            
                        }
                        .padding(.horizontal, 70)
                        
                        Spacer()
                        HStack{
                            Spacer()
                            NavigationLink(destination: QRView()){
                                ZStack{
                                    Circle()
                                        .foregroundColor(.yellow)
                                        .frame(width: 70, height: 70)
                                    
                                    Image(systemName: "qrcode")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                        }.padding(.horizontal)
                    }
                }
            }
        }
        
    }
    func scanAnimation() {
        withAnimation(.easeInOut(duration: 0.75).delay(0.1).repeatForever(autoreverses: true)){
            isScanning = true
        }
    }
    func stopScanAnimation() {
        withAnimation(.easeInOut(duration: 0.75)){
            isScanning = false
        }
    }
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                cameraPermission = .approved
                setupCamera()
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                }
                else {
                    cameraPermission = .denied
                    presentError("Please Provide Access to Camera for Scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for Scanning codes")
            default: break
            }
        }
    }
    func setupCamera(){
        do{
            //Finding back camera
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
            else {
                presentError("UNKNOWN DEVICE ERROR")
                return
                }
            
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput)
            else{
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }
            
            //Input output dari camera
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            //Output config untuk baca qr code
            qrOutput.metadataObjectTypes = [.qr]
            //Delegate untuk nerima qr code dari camera
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            scanAnimation()
            
        }
        catch{
            presentError(error.localizedDescription)
        }
    }
    func presentError(_ message: String){
        errorMessage = message
        showError.toggle()
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
