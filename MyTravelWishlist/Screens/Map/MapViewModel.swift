//
//  MapViewModel.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import MapKit
import SwiftUI

final class MapViewModel: ObservableObject {
    private(set) var initialPosition: MapCameraPosition
    @Published var locations: [Location]
    @Published var needAuthentication: Bool
    
    init() {
        initialPosition = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: -10.4747, longitude: -54.0176),
                span: MKCoordinateSpan(latitudeDelta: 72, longitudeDelta: 40))
        )
        locations = [Location]()
        needAuthentication = true
    }
    
    func addLocation(at coordinate: CLLocationCoordinate2D) {
        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
        locations.append(newLocation)
    }
}
