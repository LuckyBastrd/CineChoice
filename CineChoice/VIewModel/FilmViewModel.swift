//
//  FilmViewModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.

import SwiftUI

class FilmViewModel: ObservableObject {
    
    @Published var films = [FilmModel]()
    
    func fetchFilms() async throws {
        films = try await SupabaseManager.shared.fetchFilms()
    } 
    
    func removeFilm(_ film: FilmModel) {
        guard let removeIndex = films.firstIndex(where: { $0.filmID == film.filmID }) else { return }
        
        films.remove(at: removeIndex)
    }
}
