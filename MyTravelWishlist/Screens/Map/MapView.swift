//
//  ContentView.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject var mapViewModel = MapViewModel()
    
    var body: some View {
        MapReader { mapProxy in
            Map(initialPosition: mapViewModel.initialPosition) {
                ForEach(mapViewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(.redPin)
                            .resizable()
                            .frame(width: 50, height: 50)
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
        .fullScreenCover(isPresented: $mapViewModel.needAuthentication) {
            AuthenticationScreen(needAuthentication: $mapViewModel.needAuthentication)
        }
    }
}

#Preview {
    MapView()
}
