//
//  FilmRatingModel.swift
//  CineChoice
//
//  Created by Lucky on 01/05/24.
//

import Foundation

struct FilmRatingModel: Decodable {
    let filmID: Int
    let averageLike: Int
    let averageDislike: Int
    let averageUnseen: Int
}
