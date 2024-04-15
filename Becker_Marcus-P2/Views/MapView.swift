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
    
    //@Binding var coordinate: CLLocationCoordinate2D
    @Binding var spot: Spot?
    
    //@ObservedObject var myVM = LocationManager()
    
    @State private var position: MapCameraPosition = .automatic
    //this is a binding, can go in viewmodel
    
    @State var visibleRegion: MKCoordinateRegion?
    @State private var selectedResult: MKMapItem?
    
    @State private var searchResults: [MKMapItem] = []
    //visibleRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10, longitudinalMeters: 10)
    
    //@Binding var searchstring: String
    
    var body: some View {
        
        
        
        Map(position: $position, selection: $selectedResult) {
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
        .onChange(of: searchResults) { withAnimation { position = .automatic } }
        .onChange(of: spot) { withAnimation { position = spot?.mapPosition ?? .automatic}
            print(spot?.latitude)
            print(spot?.longitude)
            }
        .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
        
    }
}

extension CLLocationCoordinate2D {
    static let rome = CLLocationCoordinate2D(latitude: 41.8967, longitude: 12.4822)
    
}


