//
//  ContentView.swift
//  CineChoiceUI
//
//  Created by Leonardo Marhan on 25/04/24.
//

import SwiftUI
import SwiftData
import FCUUID

struct QRView: View {
    
    var body: some View{
        ZStack{
            NavigationStack{
                ZStack{
                    Rectangle()
                        .fill(Color("ccGray"))
                        .ignoresSafeArea()
                    
                    VStack{
                        HStack{
                            Button(action: {
                                
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            Spacer()
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        .padding(.horizontal)
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.yellow)
                                .frame(width: 310, height: 310)
                            //profile picture
                            RoundedRectangle(cornerRadius: 17)
                                .foregroundColor(.red)
                                .frame(width: 80, height: 80)
                                .padding(EdgeInsets(top: -210, leading: 0, bottom: 0, trailing: 0))
                            //qr
                            QRCodeView(deviceId: "\(String(describing: FCUUID.uuidForDevice()))")
                        }
                        Spacer()
                        HStack{
                            Spacer()
                            NavigationLink(destination: ScanView()){
                                ZStack{
                                    Circle()
                                        .foregroundColor(.yellow)
                                        .frame(width: 70, height: 70)
                                    Image(systemName: "camera.fill")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.black)
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear{
            AudioPlayer.stopMusic()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QRView()
    }
}
