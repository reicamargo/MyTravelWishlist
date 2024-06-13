//
//  EditPinView.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import SwiftUI

struct EditPinView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var editPinViewModel: EditPinViewModel
    
    private var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Place name", text: $editPinViewModel.location.name)
                    TextField("Place description", text: $editPinViewModel.location.description)
                }
                
                Section("Nearby...") {
                    List {
                        VStack {
                            Text("1")
                            Text("2")
                            Text("3")
                        }
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    onSave(editPinViewModel.save())
                    dismiss()
                }
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.editPinViewModel = EditPinViewModel(location: location)
        self.onSave = onSave
    }
}

#Preview {
    let editLocation = Location(id: UUID(),
                                name: "New location",
                                description: "",
                                latitude: 1.0,
                                longitude: 2.0)
    
    return EditPinView(location: editLocation) { _ in }
}