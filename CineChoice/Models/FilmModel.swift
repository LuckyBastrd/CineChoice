//
//  FilmModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import Foundation

struct FilmModel: Decodable, Hashable {
    let filmID: Int
    let filmTitle: String
    let filmPoster: String
    let filmSoundtrack: String
}
