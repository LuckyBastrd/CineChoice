//
//  SwiftUIView.swift
//  StarNote
//
//  Created by Bintang Anandhiya on 25/04/24.
//

import SwiftUI
import Kingfisher
import Supabase

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)  // << here !!
    }
}

struct PickerView: View {

    @State var pickerSelection = 0

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemYellow
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }

    var body: some View {
        Picker(selection: $pickerSelection, label: Text("")) {
            Image(systemName: "hand.thumbsup.fill").tag(0)
            Image(systemName: "hand.thumbsdown.fill").tag(1)
            Image(systemName: "eye.slash.fill").tag(2)
            
                
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("CCGray2")))
        .pickerStyle(SegmentedPickerStyle())
        
    }
}

struct ProfileView: View {
    
    @EnvironmentObject var supabaseManager: SupabaseManager
    
    @State var pickerSelection = 0

    private var gs = UIScreen.main.bounds.width/17
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemYellow
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: gs) {
                HStack(spacing: gs){
                    
                    
                    KFImage(URL(string: (supabaseManager.user?.userPicture)!))
                        .resizable()
                        .scaledToFill()
                        .frame(width: gs*7,height: gs*7)
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                        
                    
                    VStack(spacing:gs){
                        HStack{
                            Image(systemName: "popcorn.circle.fill")
                                .resizable()
                                .foregroundColor(.yellow)
                                .scaledToFill()
                                .frame(width: gs)
                            Spacer()
                            Text("123")
                                .font(.system(size: 25))
                                .foregroundStyle(.white)
                        }
                        .padding(20)
                        .frame(width: gs*7, height:gs*3)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("CCGray2")))
                        
                        
                        HStack{
                            Image(systemName: "figure.2.circle.fill")
                                .resizable()
                                .foregroundColor(.yellow)
                                .scaledToFill()
                                .frame(width: gs)
                            Spacer()
                            Text("12")
                                .font(.system(size: 25))
                                .foregroundStyle(.white)
                        }
                        .padding(20)
                        .frame(width: gs*7, height:gs*3)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("CCGray2")))
                        
                        
                    }
                }
                
                
                HStack{
                    Picker(selection: $pickerSelection, label: Text("")) {
                        Image(systemName: "hand.thumbsup.fill").tag(0)
                        Image(systemName: "hand.thumbsdown.fill").tag(1)
                        Image(systemName: "eye.slash.fill").tag(2)
                        
                            
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("CCGray2")))
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width:15*gs,height:2*gs)
                }
                
                HStack{
                    FilmGridViewGenerator(input: supabaseManager.userInteractions, filterd: $pickerSelection)
                        .padding(.horizontal, gs)
                }
            }
            .frame(minHeight: 700)
        }
        .background(Color("CCGray1"))
//        .onAppear {
//            
//            Task {
//                do {
//                    
//                    
//                    
//                } catch {
//                    print("Error fetching user data: \(error)")
//                }
//            }
//        }
    }
}

#Preview {
    ContentView()
}

