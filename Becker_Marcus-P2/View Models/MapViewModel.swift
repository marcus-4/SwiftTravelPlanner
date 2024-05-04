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
    
    
    var displayedSpots: [Spot] = []
    
    //TODO: Sync these up, didset? what is driving?
    var selectedMapItem: MKMapItem?
    var selectedSpot: Spot? {
        didSet {
            updateDisplayedSpots()
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
    
    var searchPresented: Bool = true {
        didSet {
            if searchPresented == false {
                searchResults = []
            }
        }
    }
    
    var visibleRegion: MKCoordinateRegion?
    
    //var searchResults = [MKLocalSearchCompletion]()
    
    let manager = CLLocationManager()
    var searchCompleter = MKLocalSearchCompleter()
    
    var apiManager = APIManager()
    
    init() {
        
        //apiManager = APIManager(mapViewModel: self)
        
    }
        
    func updateDisplayedSpots() {
        if let localSelectSpot = selectedSpot {
            if var localDisplayedSpots = localSelectSpot.subSpots {
                
                ///Shows or Hides Pin for Overall Leg
                //localDisplayedSpots.append(localSelectSpot)
                self.displayedSpots = localDisplayedSpots
            }
            
            //selectedMapItem = localSelectSpot.mapItem
        }
        selectedMapItem = selectedSpot?.mapItem
        
    }
    
    
    func search() {
        if useTASearch {
            TASearch()
        } else {
            normalSearch()
        }
    }
    
    
    
    func normalSearch() {
        //print("search execute")
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchStr
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
    
    
    func TASearch() {
        Task{
            await apiManager.getTASearch(searchStr: searchStr)
        }
        
    }
    
    
    
    func apiUpdate() {
        
        Task {
            await selectedSpot?.getTAInfo()
            
        }
        
        
    }
    
    
    
    
    
}


