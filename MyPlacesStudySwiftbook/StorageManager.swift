//
//  StorageManager.swift
//  MyPlacesStudySwiftbook
//
//  Created by Евгений Скилиоти on 25.05.2020.
//  Copyright © 2020 Евгений Скилиоти. All rights reserved.
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
