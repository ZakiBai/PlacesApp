//
//  StorageManager.swift
//  PlacesApp
//
//  Created by Zaki on 29.09.2023.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place) {
       try! realm.write {
            realm.add(place)
        }
    }
}
