//
//  Leg.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/13/24.
//

import Foundation
import SwiftData

@Model
final class Leg: Identifiable {
    var id: UUID
    
    var name: String
    
    
    @Relationship(deleteRule: .cascade, inverse: \Spot.leg)
    var spots: [Spot]
    
    @Relationship(deleteRule: .cascade, inverse: \Spot.leg)
    var home: Spot?
    
    init(name: String){
        self.id = UUID()
        self.name = name
        self.spots = []
    }
    
    
}
