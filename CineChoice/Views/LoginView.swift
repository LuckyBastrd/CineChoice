//  LoginView.swift
//  CineChoice
//
//  Created by Lucky on 25/04/24.
//

import SwiftUI
import FCUUID


struct LoginView: View {
  
  var body: some View {
      VStack {
          Text("Login View \(FCUUID.uuidForDevice())")
      }
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
      .background(Color(.ccGray))
  }
}
  
  
#Preview {
  LoginView()
}
