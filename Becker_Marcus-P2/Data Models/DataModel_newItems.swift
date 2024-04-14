//
//  DataModel_newItems.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation

extension DataModel {
    
    func createLeg(legTitle: String, legHome: Spot) {
        //UI textfield to create, popup with map search
        //need to pass maplocation? tripadvisor?
        
        let newLeg = Leg(name: legTitle, home: legHome)
        
        modelContext.insert(newLeg)
        
    }
    
    func createSpot(spotTitle: String) {
        
        let newSpot = Spot(name: spotTitle)
        
        modelContext.insert(newSpot)
    }
    
    
}


