//
//  MapViewModel.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/29/24.
//

import Foundation
import MapKit
import _MapKit_SwiftUI



//@MainActor???
@Observable
class MapViewModel {
    
    
    ///make these source of truth
    var position: MapCameraPosition = .automatic
    
    
    var searchResults: [MKMapItem] = []
    
    
    //var displayedSpots: Set<Spot> = []
    var displayedSpots: [Spot] = []
    //var displayedSpots: [MKMapItem] = []
    
    //TODO: Sync these up, didset? what is top Level?
    var selectedMapItem: MKMapItem?
    var selectedSpot: Spot? {
        didSet {
            
            if let localSelectSpot = selectedSpot {
                if var localDisplayedSpots = localSelectSpot.subSpots {
                    
                    localDisplayedSpots.append(localSelectSpot)
                    self.displayedSpots = localDisplayedSpots
                }
                
                //selectedMapItem = localSelectSpot.mapItem
            }
            selectedMapItem = selectedSpot?.mapItem
            
        }
    }
    
    var selectedResult: MKMapItem? {
        didSet {
            if let localSelectedResult = selectedResult {
                print(localSelectedResult)
                selectedMapItem = localSelectedResult
            }
        }
    }
    ///How do I really want these linked??
    
    
    
    var useTASearch: Bool = false

    
    
    var searchStr: String = ""
    
    var searchPresented: Bool = true
    
    var visibleRegion: MKCoordinateRegion?
    
    //var searchResults = [MKLocalSearchCompletion]()
    
    let manager = CLLocationManager()
    var searchCompleter = MKLocalSearchCompleter()
    
    init() {
        
    }
    
    
    func search(for query: String) {
        //print("search execute")
        
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
        
        //print("search complete")
        //print(searchResults)
    }
    
    
    
    func apiUpdate() {
        
        Task {
            await selectedSpot?.getTAInfo()
            
        }
        
        
    }
    
    
    
}








//
//struct SearchCompleter: View {
//    @ObservedObject var locVM: LocationManager
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Search..", text: $locVM.search)
//                    .textFieldStyle(.roundedBorder)
//                List(locVM.searchResults,id: \.self) {res in
//                    VStack(alignment: .leading, spacing: 0) {
//                        SearchCompleterLabelView(searchResult: res, locVM: locVM)
//                    }
//                    .onTapGesture {
//                        locVM.name = res.title
//                        locVM.reverseUpdate()
//                        dismiss()
//                    }
//                }
//            }.padding()
//                .navigationTitle(Text("Search For Place"))
//        }
//    }
//}
//
