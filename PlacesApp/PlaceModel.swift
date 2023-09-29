//
//  PlaceModel.swift
//  PlacesApp
//
//  Created by Zaki on 21.09.2023.
//

import RealmSwift

class Place: Object {
    @objc dynamic var nameLabel = ""
    @objc dynamic var imageData: Data?
    @objc dynamic var locationLabel: String?
    @objc dynamic var typeLabel: String?
    
    let restaurantsList = ["Bonsai", "Burger Heroes", "Kitchen", "Love&Life", "Morris Pub", "Sherlock Holmes", "Speak Easy", "X.O", "Балкан Гриль", "Бочка", "Вкусные истории", "Дастархан", "Индокитай", "Классик", "Шок"]
    
    func savePlaces() {
        
        for place in restaurantsList {
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }
            
            let newPlace = Place()
            newPlace.nameLabel = place
            newPlace.locationLabel = "Алматы"
            newPlace.typeLabel = "Ресторан"
            newPlace.imageData = imageData
            
            NetworkManager.saveObject(newPlace)
        }
    }
}
