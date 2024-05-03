//
//  MapView.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 3/24/24.
//

import SwiftUI
import MapKit


///What exactly does this do? Move into viewModel
//@MainActor class LocationsHandler: ObservableObject {
//    
//    static let shared = LocationsHandler()
//    public let manager: CLLocationManager
//
//    init() {
//        self.manager = CLLocationManager()
//        if self.manager.authorizationStatus == .notDetermined {
//            self.manager.requestWhenInUseAuthorization()
//        }
//    }
//}




struct MapView: View {
    
    @Environment(\.isSearching) private var isSearching
    
    @Bindable var mapViewModel: MapViewModel
    
///These were used originally
//    @Binding var spot: Spot?
//    
//    @State private var position: MapCameraPosition = .automatic
//    //this is a binding, can go in viewmodel
//    
//    @State var visibleRegion: MKCoordinateRegion?
//    @State private var selectedResult: MKMapItem?
//    
//    @State private var searchResults: [MKMapItem] = []
    
    
    
    var body: some View {
        
        //@ObservedObject var mapViewModel: MapViewModel
        
        Map(position: $mapViewModel.position, selection: $mapViewModel.selectedMapItem) {
            
            
            ForEach(mapViewModel.searchResults, id: \.self) {result in
                            Marker(item: result)
                
                            
                            //Annotation(item: result)
                        }
                        .annotationTitles(.hidden)
            
            ForEach(mapViewModel.displayedSpots, id: \.self) {result in
                //Marker(item: result.mapItem)
                Annotation("\(result.name)", coordinate: result.spotCoords) {
                    annotationContent(spot: result)
                }
                
                        }
                        .annotationTitles(.hidden)
            
            
            ///Trying to map selected spot
            if let currentSpot = mapViewModel.selectedSpot {
                //Marker(item: currentSpot.mapItem)
                if (currentSpot.spotType == "leg") {
                    MapCircle(center: currentSpot.spotCoords, radius: currentSpot.radius).foregroundStyle(currentSpot.iconColor.opacity(0.25))
                    
                } else {
                    Annotation("\(currentSpot.name)", coordinate: currentSpot.spotCoords) {
                        annotationContent(spot: currentSpot)
                    }
                }
                //Annotation(item: currentSpot.mapItem)
            }

        }
        .mapStyle(.standard(elevation: .realistic))
        .onMapCameraChange { context in
            mapViewModel.visibleRegion = context.region
            
                }
        
        .onChange(of: mapViewModel.searchResults) { withAnimation {
            
            ///Test automatic view
            mapViewModel.position = .automatic
        }
            if let resultItem = mapViewModel.searchResults.first {
                //mapViewModel.position = (.item(resultItem))
                mapViewModel.selectedMapItem = resultItem
            }
        }
        
        .onChange(of: mapViewModel.displayedSpots) {
            if mapViewModel.searchResults == [] {
                
                mapViewModel.position = .automatic
                if let localLeg = mapViewModel.selectedSpot {
                    localLeg.changeRegion(newRegion: mapViewModel.visibleRegion)
                    
                }
            }
        }
        
        
        
        
        
        //.onChange(of: mapViewModel.searchResults) { withAnimation { mapViewModel.position = .automatic } }
        
        //.onChange(of: spot) { withAnimation { position = .item(spot?.mapItem ?? MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 50, longitude: 20)))) }
        .onChange(of: mapViewModel.selectedSpot) { withAnimation {
            //mapViewModel.position = mapViewModel.selectedSpot?.mapPosition ?? .automatic
            ///Test automatic view
            //print("spotselect \(mapViewModel.selectedSpot)")
            mapViewModel.position = .automatic
        }
        
            
            
            
        ///temp output
            
            }
        
        
        ///temp
        .mapControls {
                    //MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
        
    }
    
    
    
    @ViewBuilder
    private func annotationContent(spot: Spot) -> some View {
        if false {//(spot.spotType == "leg") {

        
            
            
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 5).fill(.background)
                RoundedRectangle(cornerRadius: 5).stroke(.secondary, lineWidth: 5).fill(spot.iconColor)
                Image(systemName: spot.iconName).padding(5)
            }
        }
        
    }
    
    
}




