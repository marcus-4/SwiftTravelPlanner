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
import SwiftUI

@Model
final class Spot: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Spot.parentSpot)
    var subSpots: [Spot]?
    
    var parentSpot: Spot?
    
    var isParent: Bool
    
    ///TODO: Does not live update
    var isHome: Bool
    
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
    
    @Transient
    var iconColor: Color {
        switch spotType {
        case "leg":
            return .orange
        case "home":
            return .purple
        case "place":
            return .blue
        default:
            return .yellow
        }
    }

    
    
    
    //Should I store longer address string? could at least display City / country
    
    var latitude: Double
    var longitude: Double
    
    var latDelta: Double
    var lonDelta: Double
    
    var radius: Double {
        return max(latDelta*111000, lonDelta*111000) / 2
    }
    
    
//    @Transient
//    var spotAnnotation: Annotation {
//        
//        .init(coordinate: CLLocationCoordinate2D, anchor: UnitPoint, content: () -> Content, label: () -> Label)
////    Label(name, systemImage: Image(systemName: iconName)
////              Content : annotationContent()
//        
//    }
//   
//    @ViewBuilder
//    func annotationContent() -> (() -> Content) {
//        ZStack {
//            RoundedRectangle(cornerRadius: 5).fill(.background)
//            RoundedRectangle(cornerRadius: 5).stroke(.secondary, lineWidth: 5)
//            Image(systemName: iconName).padding(5)
//        }
//    }
//        
    
    @Transient
    var spotCoords: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
    
    
    
    @Transient
    var mapItem: MKMapItem {
        
        .init(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
        
        
    }
    
    @Transient
    var mapRegion: MKCoordinateRegion {
        get {
            MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                       span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
        }
        
        
        set{
            self.latitude = newValue.center.latitude
            self.longitude = newValue.center.longitude
            self.latDelta = newValue.span.latitudeDelta
            self.lonDelta = newValue.span.longitudeDelta
            
            
        }
    }
    
    
    @Transient
    var mapPosition: MapCameraPosition {
        .item(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))))
        
        //.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
        //                           span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)))
        
        ///This doesn't work, but ^^ is too zoomed in
//        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 50,
//                                         longitudinalMeters: 50))
        ///A leg should show all spots, so mapPosition should be flexible at the spot level
    }
        
    
    
    var TA_ID: String
    //Needs to be initialized or found via search
    
    ///Make a function to update this instead
    @Transient
    var TAInfo: TALocation?
    
    //This is currently unsafe with the optional
    //MARK: Working to add this functionality to the createSpot function in datamodel
    func getTAInfo() async {
        
        Task {
            if TA_ID != "" {
                self.TAInfo = try await TripAdvisor_Location(locationID: TA_ID).getLocation()
            } else {
                print("TA_ID is Empty")
            }
            
        }
    }
    
    
    func changeSpotType() {
        switch isHome {
        case true: self.spotType = "home"
        default: self.spotType = "place"
        }
        
    }
    
    func changeRegion(newRegion: MKCoordinateRegion?) {
        if let newRegion = newRegion { self.mapRegion = newRegion }
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
        self.isHome = false;
        self.latDelta = 0.001
        self.lonDelta = 0.001
    }
    
    //for leg/top level
    convenience init(name: String, parent: Spot?, sType: String, lat: Double, lon: Double){
        self.init(name: name, parent: parent, sType: sType, TA_ID: "", TAInfo: nil, lat: lat, lon: lon)
        
    }
    
    //using MKMapItem from search- this is functionally the same as doing it from the dataModel function
    convenience init(mapItem: MKMapItem, parent: Spot?){
        
        self.init(name: mapItem.name!, parent: parent, sType: "place", TA_ID: "", TAInfo: nil, lat: mapItem.placemark.coordinate.latitude, lon: mapItem.placemark.coordinate.longitude)
        
        //self.init(mapItem) = mapItem
        //self.mapItem = mapItem
        ///comment out @Transient above, not sure why it isnt letting me add directly - might be irrelevant due to transient MKMapItem
    }
    
    
}
