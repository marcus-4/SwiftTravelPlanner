//
//  Spot.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/13/24.
//

import Foundation
import SwiftData

@Model
final class Spot: Identifiable {
    var id: UUID
    
    var name: String
    
    var leg: Leg?
    
    var isHome: Bool
    
    init(name: String){
        self.id = UUID()
        self.name = name
        self.isHome = false
    }
    
    
}
