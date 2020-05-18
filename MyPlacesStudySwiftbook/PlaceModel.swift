//
//  PlaceModel.swift
//  MyPlacesStudySwiftbook
//
//  Created by Евгений Скилиоти on 18.05.2020.
//  Copyright © 2020 Евгений Скилиоти. All rights reserved.
//

import Foundation

struct Place {
        
    var name: String
    var location: String
    var type: String
    var image: String
    
    static let restaurantNames = [
         "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
         "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
         "Speak Easy", "Morris Pub", "Вкусные истории",
         "Классик", "Love&Life", "Шок", "Бочка"
     ]
    
    static func getPlaces () -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Ростов-на-Дону", type: "Ресторан", image: place))
        }
        
        return places
    }
    
    
}
