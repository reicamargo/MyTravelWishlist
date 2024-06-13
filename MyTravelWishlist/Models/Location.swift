//
//  Location.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import Foundation
import MapKit

struct Location: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 5.501, longitude: -0.141)
    #endif
}
