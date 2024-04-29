//
//  FilmCKView.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import SwiftUI
import CloudKit

struct FilmCKView: View {
    
    @ObservedObject var filmViewModel = FilmViewModel()
    let airtableManager = AirtableManager()
    
    var body: some View {
        Button("Save Film") {
//            let film = FilmModel(recordID: CKRecord.ID(recordName: "Film"),
//                            filmID: "4",
//                            filmTitle: "Dune",
//                            filmPoster: CKAsset(fileURL: URL(fileURLWithPath: "/Users/lucky/Downloads/CineChoice/dune.jpg")),
//                            filmSoundtrack: CKAsset(fileURL: URL(fileURLWithPath: "/Users/lucky/Downloads/CineChoice/dune.mp3")),
//                            filmLikes: 0,
//                            filmDislikes: 0,
//                            filmNotWatched: 0)
//            
//            filmViewModel.saveFilmToCloudKit(film: film)
            
            airtableManager.fetchRecordsFromAirtable()
        }
    }
}

#Preview {
    FilmCKView()
}
