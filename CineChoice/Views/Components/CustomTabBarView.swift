//
//  CustomTabBarView.swift
//  CineChoice
//
//  Created by Lucky on 28/04/24.
//

import SwiftUI

enum Tabs: Int {
    case swipe = 0
    case profile = 1
}

struct CustomTabBarView: View {
    
    @Binding var selectedTabs: Tabs
    @Binding var navigateToQR: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                Button { 
                    selectedTabs = .swipe 
                } label: { 
                    GeometryReader { geo in
                        
                        if selectedTabs == .swipe {
                            Rectangle()
                                .foregroundColor(.ccGray)
                                .frame(width: geo.size.width / 2, height: 4)
                                .padding(.leading, geo.size.width / 4)
                                .cornerRadius(5)
                        }
                        
                        VStack {
                            Image(.ccIconLogo) 
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
                
                Button { 
                    selectedTabs = selectedTabs 
                    navigateToQR = true
                } label: { 
                    VStack {
                        Image(systemName: "arrow.left.arrow.right.circle.fill") 
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .background(.clear)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    .tint(Color("ccGray"))
                }
                
                Button { 
                    selectedTabs = .profile
                } label: { 
                    GeometryReader { geo in
                        
                        if selectedTabs == .profile {
                            Rectangle()
                                .foregroundColor(.ccGray)
                                .frame(width: geo.size.width / 2, height: 4)
                                .padding(.leading, geo.size.width / 4)
                                .cornerRadius(5)
                        }
                        
                        VStack {
                            Image(systemName: "person.fill") 
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
                .tint(Color("ccGray"))
                
            }
            .frame(height: 55)
            .background(.ccYellow)
        }
    }
}

//#Preview {
//    CustomTabBarView(selectedTabs: .constant(.swipe))
//}
