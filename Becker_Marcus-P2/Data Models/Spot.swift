//
//  Spot.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/13/24.
//

import Foundation
import SwiftData
import MapKit

@Model
final class Spot: Identifiable {
    @Attribute(.unique) var id: UUID
    
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Spot.parentSpot)
    var subSpots: [Spot]?
    
    var parentSpot: Spot? {
        didSet {
            self.isParent = false
        }
    }
    
    //var coords: CLLocationCoordinate2D
    
    
    var isHome: Bool
    var isParent: Bool
    
    init(name: String){
        self.id = UUID()
        self.name = name
        self.isHome = false
        self.isParent = true
    }
    
    init(name: String, parent: Spot?, isHome: Bool){
        self.id = UUID()
        self.name = name
        self.isHome = isHome
        self.isParent = false
        self.parentSpot = parent
    }
    
    //convenience init()
    
    
}
