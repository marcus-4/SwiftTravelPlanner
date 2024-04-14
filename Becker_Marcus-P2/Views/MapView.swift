//
//  MapView.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 3/24/24.
//

import SwiftUI
import MapKit

@MainActor class LocationsHandler: ObservableObject {
    
    static let shared = LocationsHandler()
    public let manager: CLLocationManager

    init() {
        self.manager = CLLocationManager()
        if self.manager.authorizationStatus == .notDetermined {
            self.manager.requestWhenInUseAuthorization()
        }
    }
}



struct MapView: View {
    
    @ObservedObject var myVM = LocationManager()
    
    @State private var searchResults: [MKMapItem] = []
    
    //@Binding var searchstring: String
    
    var body: some View {
        Map {
            Annotation("Rome", coordinate: .rome) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5).fill(.background)
                    RoundedRectangle(cornerRadius: 5).stroke(.secondary, lineWidth: 5)
                    Image(systemName: "bed.double").padding(5)
                }
            }
            //.annotationTitles(.hidden)
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
                    HStack {
                        Spacer()
                        //Searchbar(searchResults: $searchResults, searchString: $searchstring )
                        //SearchCompleter(locVM: myVM)
                        //SearchCompleterLabelView(searchResult: myVM.searchResults.first, locVM: myVM)
                        }
                        Spacer()
                    }
    }
}

extension CLLocationCoordinate2D {
    static let rome = CLLocationCoordinate2D(latitude: 41.8967, longitude: 12.4822)
}


