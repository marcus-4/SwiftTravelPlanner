//
//  Spot.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/13/24.
//

import Foundation
import SwiftData
import MapKit
import _MapKit_SwiftUI

@Model
final class Spot: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Spot.parentSpot)
    var subSpots: [Spot]?
    
    var parentSpot: Spot?
    
    var isParent: Bool
    
    //TODO: Store system Images, calculated property based on status, potentially activity type? 
    //parent Leg: "map"
    //home: "bed.double"
    //default: "mappin.and.ellipse"
    
    var spotType: String
    
    
    @Transient
    var iconName: String {
        switch spotType {
        case "leg":
            return "map"
        case "home":
            return "bed.double"
        case "place":
            return "mappin.and.ellipse"
        default:
            return "mappin.and.ellipse"
        }
    }
    
    
    
    
    
    //Should I store longer address string? could at least display City / country
    
    var latitude: Double
    var longitude: Double
    
    
    @Transient
    var mapItem: MKMapItem {
        
        .init(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
        
        
    }
    
    
    
    @Transient
    var mapPosition: MapCameraPosition {
        .item(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))))
        
        ///This doesn't work, but ^^ is too zoomed in
//        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 50,
//                                         longitudinalMeters: 50))
        ///A leg should show all spots, so mapPosition should be flexible at the spot level
    }
        
    
    
    var TA_ID: String
    //Needs to be initialized or found via search
    
    ///Make a function to update this instead
    @Transient
    var TAInfo: TALocation? //{
//        didSet {
//            latitude = Double(TAInfo?.latitude ?? "0") ?? 0.0
//            longitude = Double(TAInfo?.longitude ?? "0") ?? 0.0
//            
//        }
    //}
    
    //This is currently unsafe with the optional
    //MARK: Working to add this functionality to the createSpot function in datamodel
    func getTAInfo() async {
        
        Task {
            if TA_ID != "" {
                self.TAInfo = try await TripAdvisor_Location(locationID: TA_ID).getLocation()
            }
        }
    }
     
    
    //for spots within a leg
    init(name: String, parent: Spot?, sType: String, TA_ID: String, TAInfo: TALocation?, lat: Double, lon: Double){
        self.id = UUID()
        self.name = name
        self.spotType = sType
        self.isParent = (parent == nil) ? true : false
        self.parentSpot = parent
        self.TA_ID = TA_ID
        self.TAInfo = TAInfo
        self.latitude = lat
        self.longitude = lon
    }
    
    //for leg/top level

    convenience init(name: String, parent: Spot?, sType: String, lat: Double, lon: Double){
        self.init(name: name, parent: parent, sType: sType, TA_ID: "", TAInfo: nil, lat: lat, lon: lon)
        
    }
    
    
    
    
}
