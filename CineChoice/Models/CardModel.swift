//
//  CardModel.swift
//  CineChoice
//
//  Created by Lucky on 27/04/24.
//

import Foundation

struct CardModel {
    let film: FilmModel
}

extension CardModel: Identifiable, Hashable {
    var id: Int { return film.filmID }
}


