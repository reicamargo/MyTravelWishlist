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
                            .frame(width: 44, height: 44)
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
        .overlay(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            VStack(alignment: .leading) {
                Text("Instructions")
                    .font(.headline)
                Text("1) One tap in a location to pin a marker.")
                    .font(.subheadline)
                Text("2) A long tap on a marker to show details.")
                    .font(.subheadline)
            }
            .padding(6)
            .background(.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
        })
        .sheet(item: $mapViewModel.selectedLocation, content: { location in
            EditPinView(location: location) { location, action in
                mapViewModel.update(location: location, action: action)
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
