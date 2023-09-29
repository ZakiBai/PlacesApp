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
    
    convenience init(nameLabel: String, imageData: Data?, locationLabel: String?, typeLabel: String?) {
        self.init()
        self.nameLabel = nameLabel
        self.imageData = imageData
        self.locationLabel = locationLabel
        self.typeLabel = typeLabel
    }
}
