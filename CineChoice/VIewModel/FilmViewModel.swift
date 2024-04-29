//
//  FilmViewModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import SwiftUI
import CloudKit

class FilmViewModel: ObservableObject {
    
    @Published var films: [FilmModel] = []
    
    func saveFilmToCloudKit(film: FilmModel) {
        
        let filmRecord = CKRecord(recordType: "Film")
        filmRecord["filmID"] = film.filmID as CKRecordValue
        filmRecord["filmTitle"] = film.filmTitle as CKRecordValue
        filmRecord["filmLikes"] = film.filmLikes as CKRecordValue
        filmRecord["filmDislikes"] = film.filmDislikes as CKRecordValue
        filmRecord["filmNotWatched"] = film.filmNotWatched as CKRecordValue
        
        // Add CKAsset objects for the poster and music
        filmRecord["filmPoster"] = film.filmPoster
        filmRecord["filmSoundtrack"] = film.filmSoundtrack
        
        let database = CKContainer.default().publicCloudDatabase
        database.save(filmRecord) { (record, error) in
            if let error = error {
                print("Error saving film to CloudKit: \(error)")
            } else {
                print("Film saved to CloudKit successfully")
            }
        }
        
    }
    
    func fetchFilms() {
        CloudKitManager.shared.fetchFilms { [weak self] films, error in
            if let error = error {
                print("Error fetching films: \(error)")
                return
            }
            DispatchQueue.main.async {
                self?.films = films ?? []
            }
        }
    }
}
