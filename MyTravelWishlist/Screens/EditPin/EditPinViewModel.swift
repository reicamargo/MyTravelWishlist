//
//  EditPinViewModel.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import Foundation

@MainActor
final class EditPinViewModel: ObservableObject {
    var location: Location
    @Published var nearbyLocations: [Page]
    @Published var loadingState: LoadingState
    
    init(location: Location) {
        self.location = location
        nearbyLocations = [Page]()
        loadingState = .loading
    }
    
    func edit() -> Location {
        self.location.id = UUID()
        return self.location
    }
    
    func loadNearbyPlaces() async {
        do {
            nearbyLocations = try await WikiNetwork.shared.getNearbyPlaces(latitude: location.latitude, longitude: location.longitude)
            loadingState = .loaded
        } catch {
            if let networkError = error as? NetworkError {
                loadingState = .failed(errorMessage: "Error.. \(networkError.description)")
            } else {
                loadingState = .failed(errorMessage: "Error... \(error.localizedDescription)")
            }
        }
    }
}
