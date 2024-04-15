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
    
    var isHome: Bool
    var isParent: Bool
    
    //TODO: Store system Images, calculated property based on status, potentially activity type? 
    //parent Leg: "map"
    //home: "bed.double"
    //default: "mappin.and.ellipse"
    
    
    
    //Should I store longer address string? could at least display City / country
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    @Transient
    var coords: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    @Transient
    var mapPosition: MapCameraPosition {
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
    
    ///Make a function to update this instead
    @Transient
    var TAInfo: TALocation? {
        didSet {
            latitude = Double(TAInfo?.latitude ?? "0") ?? 0.0
            longitude = Double(TAInfo?.longitude ?? "0") ?? 0.0
            
        }
    }
    
    var TA_ID: String?
    //Needs to be initialized or found via search
    
    //This is currently unsafe with the optional
    func getTAInfo() {
        self.TAInfo = TripAdvisor_Location(locationID: TA_ID!).getLocation()
    }
    
    //for spots within a leg
    init(name: String, parent: Spot?, isHome: Bool, TA_ID: String?){
        self.id = UUID()
        self.name = name
        self.isHome = isHome
        self.isParent = (parent == nil) ? true : false
//        if parent == nil {
//            self.isParent = true
//        } else {
//            self.isParent = false
//        }
        self.parentSpot = parent
        self.TA_ID = TA_ID
    }
    
    //for leg/top level
    convenience init(name: String){
        self.init(name: name, parent: nil, isHome: false, TA_ID: nil)
        
    }
    
    
    
    
}
