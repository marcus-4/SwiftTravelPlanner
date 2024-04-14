//
//  Searchbar.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/13/24.
//

import SwiftUI
import MapKit

struct Searchbar: View {
    //@ObservedObject var locationsHandler = LocationsHandler.shared
    //@Binding var position: MapCameraPosition
    var visibleRegion: MKCoordinateRegion?
    @Binding var searchResults: [MKMapItem]
    
    @Binding var searchString: String
    
    var body: some View {
        HStack{
            TextField("Location", text: $searchString)
            Button {
                            search(for: searchString)
                        } label: {
                            Label("Search", systemImage: "magnifyingglass.circle.fill")
                        }
                        .buttonStyle(.bordered)
        }
        
    }
    
    func search(for query: String) {
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = query
            request.resultTypes = .pointOfInterest
            
            guard let region = visibleRegion else { return }
            request.region = region
            
            Task {
                let search = MKLocalSearch(request: request)
                let response = try? await search.start()
                searchResults = response?.mapItems ?? []
            }
        }
}
