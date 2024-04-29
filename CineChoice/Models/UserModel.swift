//
//  UserModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import CloudKit
import FCUUID

//struct UserModel {
//    let recordID: CKRecord.ID
//    let userID: String = FCUUID.uuidForDevice()
//    let profilePicture: CKAsset
//}

struct UserPicture: Codable {
    let url: String
}

struct Fields: Codable {
    let userID: String
    let userPicture: [UserPicture]
}

struct Record: Codable {
    let fields: Fields
}

struct UserModel: Codable {
    let records: [Record]
}
