//
//  DataModel_newItems.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation

extension DataModel {
    
    func createSpot(spotTitle: String, parent: Spot?, isHome: Bool, TA_ID: String?) {
        
        let newSpot = Spot(name: spotTitle, parent: parent, isHome: isHome, TA_ID: TA_ID)
        modelContext.insert(newSpot)
        
        //MARK: This actually triggers the API Call, determine whether this should stay at the creation level
        newSpot.getTAInfo()
        
        
        
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
    
    func deleteSpot(spot: Spot) {
        //TODO: Does this need to use an ID instead of object??
        modelContext.delete(spot)
        fetchData()
    }
    
    //TODO: find why this is needed with creation functionality, should be temporary
    //save modelcontext / fetch / view updating
    func createLegTest(legTitle: String, homeTitle: String) -> Spot {
        //UI textfield to create, popup with map search
        //need to pass maplocation? tripadvisor?
        
        let newLeg = Spot(name: legTitle)
        modelContext.insert(newLeg)
        
        
        createSpot(spotTitle: homeTitle, parent: newLeg, isHome: true, TA_ID: "271186")
        
        
        createSpot(spotTitle: "activity1", parent: newLeg, isHome: false, TA_ID: "17070224")
        createSpot(spotTitle:  "activity2", parent: newLeg, isHome: false, TA_ID: "27413778")
        createSpot(spotTitle:  "activity3", parent: newLeg, isHome: false, TA_ID: "1205494")
        
        //try? modelContext.save()

        
        
        return newLeg
    }
    
    
}


