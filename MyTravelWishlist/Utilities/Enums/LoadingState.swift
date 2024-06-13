//
//  LoadingState.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import Foundation

enum LoadingState {
    case loading, loaded
    case failed(errorMessage: String)
}
