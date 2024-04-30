//
//  FilmModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import CloudKit

//struct FilmModel: Hashable {
//    let recordID: CKRecord.ID
//    let filmID: String
//    let filmTitle: String
//    let filmPoster: CKAsset
//    let filmSoundtrack: CKAsset
//    let filmLikes: Int
//    let filmDislikes: Int
//    let filmNotWatched: Int
//}


import Foundation

struct FilmModel: Decodable, Hashable {
    let filmID: Int
    let filmTitle: String
    let filmPoster: String
    let filmSoundtrack: String
    let like: Int
    let dislike: Int
    let unseen: Int
}

//struct FilmPoster: Codable {
//    let url: String
//}
//
//struct FilmSoundtrack: Codable {
//    let url: String
//}
//
//struct Fields: Codable {
//    let filmID: Int
//    let filmPoster: [FilmPoster]?
//    let filmSoundtrack: [FilmSoundtrack]?
//}
//
//struct Record: Codable {
//    let fields: Fields
//}
//
//struct FilmModel: Codable {
//    let records: [Record]
//}
