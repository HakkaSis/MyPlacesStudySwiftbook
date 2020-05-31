//
//  PlaceModel.swift
//  MyPlacesStudySwiftbook
//
//  Created by Евгений Скилиоти on 18.05.2020.
//  Copyright © 2020 Евгений Скилиоти. All rights reserved.
//

import RealmSwift

class Place: Object {
        
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
//     let restaurantNames = [
//        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
//        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
//        "Speak Easy", "Morris Pub", "Вкусные истории",
//        "Классик", "Love&Life", "Шок", "Бочка"
//    ]
    
    
//    func savePlaces() {
//
//        for place in restaurantNames {
//           let newPlace = Place()
//
//            let image = UIImage(named: place)
//            guard let imageData = image?.pngData()  else { return }
//
//            newPlace.name = place
//            newPlace.location = "Rostov"
//            newPlace.type = "bar"
//            newPlace.imageData = imageData
//
//            StorageManager.saveObject(newPlace)
//        }
//
//    }
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
