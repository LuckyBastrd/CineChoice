//
//  FilmCKView.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import SwiftUI
import CloudKit
import FCUUID

struct FilmCKView: View {
    
//    @ObservedObject var filmViewModel = FilmViewModel()
//    let airtableManager = AirtableManager()
    
    @StateObject var filmViewModel = FilmViewModel()
    @StateObject var userViewModel = UserViewModel()    
    
    var body: some View {
        VStack {
            //
        }
        .onAppear{
            Task {
                do {
                    try await userViewModel.fetchUser(for: "aa")
                } catch {
                    print("Error fetching film data: \(error)")
                }
            }
        }
//        Button("Save Film") {
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
//            
//            airtableManager.fetchRecordsFromAirtable()
//        }
    }
}

#Preview {
    FilmCKView()
}
