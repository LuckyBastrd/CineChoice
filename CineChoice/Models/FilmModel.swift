//
//  FilmModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import CloudKit

struct FilmModel: Hashable {
    let recordID: CKRecord.ID
    let filmID: String
    let filmTitle: String
    let filmPoster: CKAsset
    let filmSoundtrack: CKAsset
    let filmLikes: Int
    let filmDislikes: Int
    let filmNotWatched: Int
}

