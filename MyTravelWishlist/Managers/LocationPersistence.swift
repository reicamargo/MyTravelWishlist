//
//  LocationPersistence.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import Foundation

final class LocationPersistence {
    static let shared = LocationPersistence()
    private let savePath: URL
    
    private init() {
        savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
    }
    
    func load() -> [Location] {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode([Location].self, from: data)
        } catch {
            return []
        }
    }
    
    func save(_ locations: [Location]) {
        do {
            let locationEncoded = try JSONEncoder().encode(locations)
            try locationEncoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error")
        }
    }
    
    func add(newLocation: Location) async {
        var locations = load()
        locations.append(newLocation)
        
        save(locations)
    }
    
    func update(location: Location) async {
        
    }
}