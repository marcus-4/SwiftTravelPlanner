//
//  DataModel_newItems.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation
import MapKit

extension DataModel {
    
    
    
    func createSpot(spotTitle: String, parent: Spot?, sType: String, lat: Double, lon: Double) {
        
        
        let newSpot = Spot(name: spotTitle, parent: parent, sType: sType, lat: lat, lon: lon)
        
        modelContext.insert(newSpot)
        
        
        
        if let parent {
            if parent.subSpots != nil {
                parent.subSpots?.append(newSpot)
            } else {
                parent.subSpots = []
                parent.subSpots?.append(newSpot)
            }
        }
        
        
        fetchData()
        
    }
    
    
    
    func createSpotSearch(item: MKMapItem, parent: Spot?, searchString: String) {
        var localType: String = (parent != nil) ? "place" : "leg"
        
        //TODO: attempting to pass in MKMapItem Directly
        //let newSpot = Spot(item)
        
        let newSpot = Spot(name: (item.name ?? searchString), parent: parent, sType: localType, lat: item.placemark.coordinate.latitude, lon: item.placemark.coordinate.longitude)
        
        modelContext.insert(newSpot)
        
        
        
        if let parent {
            if parent.subSpots != nil {
                parent.subSpots?.append(newSpot)
            } else {
                parent.subSpots = []
                parent.subSpots?.append(newSpot)
            }
        }
        
        
        fetchData()
        
    }
    
    
    
    /*
    func createSpotTA(spotTitle: String, parent: Spot?, isHome: Bool, TA_ID: String?, lat: Double, lon: Double) {
        var TAInfo = TripAdvisor_Location(locationID: TA_ID!).getLocation()
        
        print(TAInfo?.longitude ?? 35505)
        
        ///It could be that the async call is not yet populated when we are trying to do this, since it prints 35505 before data. DO async await on the TAinfo
        //i spent a while trying to wrap this up in a task/async await but didn't have much luck, unless making ALL of createSpot an async function
        var myLat: Double = Double(TAInfo?.latitude ?? "") ?? 0.0
        var myLon: Double = Double(TAInfo?.longitude ?? "") ?? 0.0
        
        //trying to pass in lat and lon
        //let newSpot = Spot(name: spotTitle, parent: parent, isHome: isHome, TA_ID: TA_ID, TAInfo: TAInfo, lat: lat, lon: lon)
        //let newSpot = Spot(name: spotTitle, parent: parent, isHome: isHome, TA_ID: TA_ID, TAInfo: TAInfo, lat: (Double(from: TAInfo?.latitude ?? 39)), lon: Double(from: TAInfo?.longitude ?? 13))
        let newSpot = Spot(name: spotTitle, parent: parent, sType: "place", TA_ID: TA_ID, TAInfo: TAInfo, lat: myLat, lon: myLon)
        
        modelContext.insert(newSpot)
        
        //MARK: This actually triggers the API Call, determine whether this should stay at the creation level
        //newSpot.getTAInfo()
        
        
        
        if let parent {
            if parent.subSpots != nil {
                parent.subSpots?.append(newSpot)
            } else {
                parent.subSpots = []
                parent.subSpots?.append(newSpot)
            }
        }
        
        
        fetchData()
        
        
    }
    */
    
    
    
    func deleteSpot(spot: Spot) {
        //TODO: Does this need to use an ID instead of object??
        modelContext.delete(spot)
        fetchData()
    }
    
    
    
}
    
    

