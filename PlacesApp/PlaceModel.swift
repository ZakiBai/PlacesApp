//
//  PlaceModel.swift
//  PlacesApp
//
//  Created by Zaki on 21.09.2023.
//

import UIKit

struct Place {
    var restaurantImage: String?
    var image: UIImage?
    var nameLabel: String
    var locationLabel: String?
    var typeLabel: String?
    
    static let restaurantsList = ["Bonsai", "Burger Heroes", "Kitchen", "Love&Life", "Morris Pub", "Sherlock Holmes", "Speak Easy", "X.O", "Балкан Гриль", "Бочка", "Вкусные истории", "Дастархан", "Индокитай", "Классик", "Шок"]
    
    static func getPlaces() -> [Place] {
        var places: [Place] = []
        for place in restaurantsList {
            places.append(Place(restaurantImage: place, image: nil, nameLabel: place, locationLabel: "Алматы", typeLabel: "Ресторан"))
        }
        return places
    }
}
