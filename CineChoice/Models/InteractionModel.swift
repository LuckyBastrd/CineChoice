//
//  InteractionModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import Foundation

struct InteractionModel: Decodable {
    let userID: String
    let filmID: Int
    let action: String
    let filmTitle: String
    let filmPoster: String
}

struct AllInteractionModel: Decodable {
    let userID: String
    let userPicture: String
    let filmID: Int
    let action: String
    let filmPoster: String
}
