//
//  DataModel_newItems.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation

extension DataModel {
    
    func createSpot(spotTitle: String, parent: Spot?, isHome: Bool) {
        
        let newSpot = Spot(name: spotTitle, parent: parent, isHome: isHome)
        
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
        //try? modelContext.save()
    }
    
    //TODO: find why this is needed with creation functionality, should be temporary
    //save modelcontext / fetch / view updating
    func createLegTest(legTitle: String, homeTitle: String) -> Spot {
        //UI textfield to create, popup with map search
        //need to pass maplocation? tripadvisor?
        
        let newLeg = Spot(name: legTitle)
        modelContext.insert(newLeg)
        
        
        createSpot(spotTitle: homeTitle, parent: newLeg, isHome: true)
        
        
        createSpot(spotTitle: "activity1", parent: newLeg, isHome: false)
        createSpot(spotTitle:  "activity2", parent: newLeg, isHome: false)
        createSpot(spotTitle:  "activity3", parent: newLeg, isHome: false)
        
        //try? modelContext.save()

        
        
        return newLeg
    }
    
    
}


