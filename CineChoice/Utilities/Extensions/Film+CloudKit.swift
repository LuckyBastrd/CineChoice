////
////  Film+CloudKit.swift
////  CineChoice
////
////  Created by Lucky on 26/04/24.
////
//
//import CloudKit
//
//extension FilmModel {
//    
//    init(record: CKRecord) {
//        self.recordID = record.recordID
//        self.filmID = record["filmID"] as? String ?? ""
//        self.filmTitle = record["filmTitle"] as? String ?? ""
//        self.filmPoster = record["filmPoster"] as? CKAsset ?? CKAsset(fileURL: URL(string: "")!)
//        self.filmSoundtrack = record["filmSoundtrack"] as? CKAsset ?? CKAsset(fileURL: URL(string: "")!)
//        self.filmLikes = record["filmLikes"] as? Int ?? 0
//        self.filmDislikes = record["filmDislikes"] as? Int ?? 0
//        self.filmNotWatched = record["filmNotWatched"] as? Int ?? 0
//    }
//    
//}
