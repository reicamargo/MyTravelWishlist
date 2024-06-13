//
//  WikiNetwork.swift
//  MyTravelWishlist
//
//  Created by Reinaldo Camargo on 13/06/24.
//

import Foundation

final class WikiNetwork {
    static let shared = WikiNetwork()
    private let decoder: JSONDecoder
    
    private init() {
        decoder = JSONDecoder()
    }
    
    func getNearbyPlaces(latitude: Double, longitude: Double) async throws -> [Page] {
        let wikiAPI = "https://en.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: wikiAPI) else { throw NetworkError.badURL(errorMessage: "Bad URL format...")  }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return try decoder.decode(Result.self, from: data).query.pages.values.sorted()
            
        } catch {
            throw NetworkError.unableToDecode(errorMessage: "Unable to decode the reponse from Wikipedia.")
        }
    }
}

enum NetworkError: Error {
    case badURL(errorMessage: String)
    case unableToDecode(errorMessage: String)
    
    var description: String {
        switch self {
        case .badURL(let errorMessage):
            errorMessage
        case .unableToDecode(let errorMessage):
            errorMessage
        }
    }
}
