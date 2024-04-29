//
//  InteractionModel.swift
//  CineChoice
//
//  Created by Lucky on 26/04/24.
//

import CloudKit

struct InteractionModel {
    let recordID: CKRecord.ID
    let userID: CKRecord.Reference
    let filmID: CKRecord.Reference
    let action: String
}
