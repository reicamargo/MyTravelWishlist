//
//  MapViewModel.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import MapKit
import SwiftUI

@Observable
final class MapViewModel {
    var initialPosition: MapCameraPosition
    private(set) var locations: [Location]
    var needAuthentication: Bool
    var selectedLocation: Location?
    
    init() {
        initialPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: -10.4747, longitude: -54.0176),
                span: MKCoordinateSpan(latitudeDelta: 72, longitudeDelta: 40))
        )
        locations = LocationPersistence.shared.load()
        needAuthentication = true
        
        #if DEBUG
        needAuthentication = false
        #endif
    }
    
    func addLocation(at coordinate: CLLocationCoordinate2D) {
        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        Task {
            await LocationPersistence.shared.add(newLocation: newLocation)
        }
        
        locations.append(newLocation)
    }
    
    func updateLocation(_ updatedLocation: Location) {
        guard let selectedLocation else { return }
        
        Task {
            await LocationPersistence.shared.update(from: selectedLocation, to: updatedLocation)
        }
        
        if let index = locations.firstIndex(of: selectedLocation) {
            locations[index] = updatedLocation
        }
    }
}
