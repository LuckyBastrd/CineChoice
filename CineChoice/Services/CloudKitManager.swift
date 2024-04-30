////
////  CloudKitManager.swift
////  CineChoice
////
////  Created by Lucky on 26/04/24.
////
//
//import CloudKit
//
//class CloudKitManager {
//    
//    static let shared = CloudKitManager()
//
//    func fetchFilms(completion: @escaping ([FilmModel]?, Error?) -> Void) {
//        
//        let query = CKQuery(recordType: "Film", predicate: NSPredicate(value: true))
//        
//        // Adding sort descriptor to sort by the "filmDate" field in ascending order
//        query.sortDescriptors = [NSSortDescriptor(key: "filmID", ascending: true)]
//        
//        let db = CKContainer.default().publicCloudDatabase
//        
//        db.perform(query, inZoneWith: nil) { records, error in
//            if let error = error {
//                completion(nil, error)
//            } else if let records = records {
//                let films = records.map { FilmModel(record: $0) }
//                completion(films, nil)
//                //print(films)
//            }
//        }
//    }
//}
