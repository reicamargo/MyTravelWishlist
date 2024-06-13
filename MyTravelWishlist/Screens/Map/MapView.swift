//
//  ContentView.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var mapViewModel = MapViewModel()
    
    var body: some View {
        MapReader { mapProxy in
            Map(initialPosition: mapViewModel.initialPosition) {
                ForEach(mapViewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(.redPin)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .offset(x: 5, y: -23)
                            .onLongPressGesture {
                                mapViewModel.selectedLocation = location
                            }
                    }
                }
            }
            .mapStyle(.hybrid)
            .onTapGesture { position in
                if let coordinate = mapProxy.convert(position, from: .local) {
                    mapViewModel.addLocation(at: coordinate)
                }
            }
        }
        .sheet(item: $mapViewModel.selectedLocation, content: { location in
            EditPinView(location: location) { location in
                mapViewModel.updateLocation(location: location)
            }
        })
        .fullScreenCover(isPresented: $mapViewModel.needAuthentication) {
            AuthenticationScreen(needAuthentication: $mapViewModel.needAuthentication)
        }
    }
}

#Preview {
    MapView()
}
