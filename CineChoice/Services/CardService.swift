//
//  CardServices.swift
//  CineChoice
//
//  Created by Lucky on 27/04/24.
//

import Foundation

struct CardService {
    
    var filmViewModel = FilmViewModel()
    
//    func fetchCardModels() async throws -> [CardModel] {
//        let film = filmViewModel.films
//        return film.map({ CardModel(film: $0) })
//    }
    
    func fetchCardModels() async throws -> [CardModel] {
        let film = filmViewModel.films
        return film.map({ CardModel(film: $0) })
    }
}
