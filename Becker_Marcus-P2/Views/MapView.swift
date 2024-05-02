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
                        }
                        .annotationTitles(.hidden)
            
            ForEach(mapViewModel.displayedSpots, id: \.self) {result in
                Marker(item: result.mapItem)
                        }
                        .annotationTitles(.hidden)
            
            
            ///Trying to map selected spot
            if let currentSpot = mapViewModel.selectedSpot {
                Marker(item: currentSpot.mapItem)
            }
            //Marker(item: mapViewModel.selectedSpot.mapItem)
            
            
//            Annotation(mapViewModel.selectedSpot!.mapItem) {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 5).fill(.background)
//                    RoundedRectangle(cornerRadius: 5).stroke(.secondary, lineWidth: 5)
//                    Image(systemName: "bed.double").padding(5)
//                }
//            }
            //.annotationTitles(.hidden)
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
                    HStack {
                        Spacer()
                        //Searchbar(position: $position, searchResults: $searchResults, searchString: $searchstring )
                        //SearchCompleter(locVM: myVM)
                        //SearchCompleterLabelView(searchResult: myVM.searchResults.first, locVM: myVM)
                        }
                        Spacer()
                    }
        .onMapCameraChange { context in
            mapViewModel.visibleRegion = context.region
                }
        
        .onChange(of: mapViewModel.searchResults) { withAnimation {
            if let resultItem = mapViewModel.searchResults.first {
                mapViewModel.position = (.item(resultItem))
                mapViewModel.selectedMapItem = resultItem
            }
        }
        }
        
        
        
        
        
        
        
        //.onChange(of: mapViewModel.searchResults) { withAnimation { mapViewModel.position = .automatic } }
        
        //.onChange(of: spot) { withAnimation { position = .item(spot?.mapItem ?? MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 50, longitude: 20)))) }
        .onChange(of: mapViewModel.selectedSpot) { withAnimation { mapViewModel.position = mapViewModel.selectedSpot?.mapPosition ?? .automatic}
        ///temp output
            print(mapViewModel.selectedSpot?.latitude)
            print(mapViewModel.selectedSpot?.longitude)
            }
        .onChange(of: mapViewModel.position.positionedByUser) {
            print("live")
            print(mapViewModel.position)
            print(mapViewModel.position.camera?.centerCoordinate)
            print(mapViewModel.position.item)
            print(mapViewModel.position.positionedByUser)
            
        }
        .onChange(of: mapViewModel.searchPresented) {
            print("search change")
            print(mapViewModel.searchPresented)
        }
        .onChange(of: isSearching) {
            print("isSearch")
            print(isSearching)
        }
        ///temp
        .mapControls {
                    //MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
        
    }
}




