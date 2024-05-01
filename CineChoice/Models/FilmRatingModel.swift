//
//  FilmRatingModel.swift
//  CineChoice
//
//  Created by Lucky on 01/05/24.
//

import Foundation

struct FilmRatingModel: Decodable {
    let filmRatingID: Int
    let filmID: Int
    let filmLike: Int
    let filmDislike: Int
    let filmUnseen: Int
    let totalRating: Int
}
