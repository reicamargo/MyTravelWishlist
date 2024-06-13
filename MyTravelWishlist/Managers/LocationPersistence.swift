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
    
    private func save(_ locations: [Location]) {
        if let locationEncoded = try? JSONEncoder().encode(locations) {
            try? locationEncoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
        return
    }
    
    func add(newLocation: Location) async {
        var locations = load()
        locations.append(newLocation)
        
        save(locations)
    }
    
    func update(from oldLocation: Location, to newLocation: Location) async {
        var locations = load()
        
        if let index = locations.firstIndex(of: oldLocation) {
            locations[index] = newLocation
            save(locations)
        }
        return
    }
    
    func delete(location: Location) async {
        var locations = load()
        
        locations.removeAll { $0.id == location.id }
        save(locations)
    }
}
