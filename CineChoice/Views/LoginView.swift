//  LoginView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI
import FCUUID
import AVKit

struct LoginView: View {
    
    @EnvironmentObject var supabaseManager: SupabaseManager
    @EnvironmentObject var createManager: CreateManager
    @StateObject var camera = CameraModel()
    @State var permission = false
    @Binding var doneLogin: Bool
    
    var body: some View {
//      VStack {
//          Text("Login View \(FCUUID.uuidForDevice())")
//      }
//      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
//      .background(Color(.ccGray))
        ZStack{
            Rectangle()
                .fill(Color("ccGray"))
                .ignoresSafeArea()
            VStack{
                GeometryReader{ geometry in
                    ZStack {
                        Rectangle()
                            .foregroundColor(.yellow)
                            .frame(width: 300, height: 300)
                            .cornerRadius(50)
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.system(size: 180))
                            .foregroundColor(.black)
                        CameraPreview(camera: camera)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        camera.checkCameraPermission()
                        permission = true
                    }
                }
                
                Spacer()
                if permission && !camera.isTaken {
                    Button(action: camera.takePic, label: {
                        ZStack{
                            Circle()
                                .foregroundColor(.yellow)
                                .frame(width: 70, height: 70)
                            Image(systemName: "camera.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    })
                    .padding(.vertical, -150)
                }
                
                if camera.isTaken {
                    HStack{
                        Button(action: camera.retake, label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 70, height: 70)
                                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                        })
                        .padding(.vertical, -150)
                        Spacer()
                        Button(action:{
                            print("start upload...")
                            createManager.createNewUser(completion:{ error in
                                    if let error = error {
                                        print("Error making user: \(error)")
                                    } else {
                                        print("User created Successfuly")
                                        Task{
                                            try await createManager.fetchUser(for: FCUUID.uuidForDevice(), from: supabaseManager)
                                        }
                                        self.doneLogin = true
                                    }
                                
                            }, userId: FCUUID.uuidForDevice(), imageData: camera.picData)
                            
                        }, label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 70, height: 70)
                                Image(systemName: "checkmark")
                                    .bold()
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                        })
                        .padding(.vertical, -150)
                    }
                    .padding(.horizontal, 80)
                }
                
                
//                .onTapGesture(perform: camera.takePic)
                Spacer()
            }
        }
    }
}
  
class CameraModel: NSObject ,ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    @Published var base64String = ""
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status {
                    self.setupCamera()
                }
            }
        case .denied, .restricted:
            self.alert.toggle()
            return
        default: return
        }

    }
    
    func setupCamera() {
        do{
            let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first
            
            let input = try AVCaptureDeviceInput(device: device!)
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            
            //Input output dari camera
            self.session.beginConfiguration()
            self.session.commitConfiguration()
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
            }
        }
    }
    
    func retake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                
                self.isSaved = false
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else{return}
        self.picData = imageData
        
        DispatchQueue.main.async {
            self.session.stopRunning()
        }
        
        self.base64String = imageData.base64EncodedString()
        
        //print("\(imageData)")
        //print("Photo data: \(base64String)")
        
    }
    
    func savePic(){
        let image = UIImage(data: self.picData)!
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        //add base64String
        
        self.isSaved = true
        
        print("saved")
    }
}

struct CameraPreview: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    @ObservedObject var camera : CameraModel
    
    func makeUIView(context: Context) -> some UIView {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
//        camera.preview.frame = view.bounds
        
        camera.preview.videoGravity = .resizeAspectFill
        camera.preview.masksToBounds = true
        
        let previewSize = CGSize(width: 310, height: 310) // Desired size of the camera preview
        let xOffset = (view.bounds.width - previewSize.width) / 2
        let yOffset = (view.bounds.width - previewSize.width) / 2
        camera.preview.frame = CGRect(x: xOffset, y: yOffset, width: previewSize.width, height: previewSize.height)
        
        view.layer.addSublayer(camera.preview)
        
        DispatchQueue.global().async {
            camera.session.startRunning()
        }
        
        return view
    }
}

  
//#Preview {
//  LoginView()
//}
