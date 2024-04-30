////
////  CommonModel.swift
////  CineChoice
////
////  Created by Lucky on 29/04/24.
////
//
//import Foundation
//
//// Define enum to differentiate between film and user fields
//enum FieldsType {
//    case film(filmID: String, filmTitle: String, filmPoster: [FilmPoster], filmSoundtrack: [FilmSoundtrack])
//    case user(userID: String, userPicture: [UserPicture])
//}
//
//// Define fields struct with the enum
//struct Fields: Codable {
//    let type: FieldsType
//}
//
//// Define record struct
//struct Record: Codable {
//    let fields: Fields
//}
//
//// Define a common model to hold records
//struct CommonModel: Codable {
//    let records: [Record]
//}
//
//// Define your other structs
//struct UserPicture: Codable {
//    let url: String
//}
//
//struct FilmPoster: Codable {
//    let url: String
//}
//
//struct FilmSoundtrack: Codable {
//    let url: String
//}
