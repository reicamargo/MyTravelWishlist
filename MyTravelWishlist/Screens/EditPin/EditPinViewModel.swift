//
//  EditPinViewModel.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import Foundation

final class EditPinViewModel: ObservableObject {
    var location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    func save() -> Location {
        self.location.id = UUID()
        return self.location
    }
}
