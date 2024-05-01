//
//  UserModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import Foundation

struct UserModel: Decodable, Encodable{
    let userID: String
    let userPicture: String
    let userAction: Int
}
