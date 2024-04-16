//
//  DataModel_newItems.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation

extension DataModel {
    

    
    func createSpot(spotTitle: String, parent: Spot?, isHome: Bool, TA_ID: String?, lat: Double, lon: Double) {
        var TAInfo = TripAdvisor_Location(locationID: TA_ID!).getLocation()
        
        print(TAInfo?.longitude ?? 35505)
            
            ///It could be that the async call is not yet populated when we are trying to do this, since it prints 35505 before data. DO async await on the TAinfo
            //i spent a while trying to wrap this up in a task/async await but didn't have much luck, unless making ALL of createSpot an async function
            var myLat: Double = Double(TAInfo?.latitude ?? "") ?? 0.0
            var myLon: Double = Double(TAInfo?.longitude ?? "") ?? 0.0
            
            //trying to pass in lat and lon
            //let newSpot = Spot(name: spotTitle, parent: parent, isHome: isHome, TA_ID: TA_ID, TAInfo: TAInfo, lat: lat, lon: lon)
            //let newSpot = Spot(name: spotTitle, parent: parent, isHome: isHome, TA_ID: TA_ID, TAInfo: TAInfo, lat: (Double(from: TAInfo?.latitude ?? 39)), lon: Double(from: TAInfo?.longitude ?? 13))
            let newSpot = Spot(name: spotTitle, parent: parent, isHome: isHome, TA_ID: TA_ID, TAInfo: TAInfo, lat: myLat, lon: myLon)
            
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
    
        
        func deleteSpot(spot: Spot) {
            //TODO: Does this need to use an ID instead of object??
            modelContext.delete(spot)
            fetchData()
        }
        
        func createLegTest(legTitle: String, homeTitle: String) -> Spot {
            //UI textfield to create, popup with map search
            //need to pass maplocation? tripadvisor?
            
            let newLeg = Spot(name: legTitle)
            modelContext.insert(newLeg)
            
            
            createSpot(spotTitle: homeTitle, parent: newLeg, isHome: true, TA_ID: "271186", lat: 41.904720, lon: 12.500660)
            
            
            createSpot(spotTitle: "activity1", parent: newLeg, isHome: false, TA_ID: "17070224", lat: 41.8, lon: 12.6)
            //createSpot(spotTitle:  "activity2", parent: newLeg, isHome: false, TA_ID: "27413778")
            //createSpot(spotTitle:  "activity3", parent: newLeg, isHome: false, TA_ID: "1205494")
            
            //try? modelContext.save()
            
            
            
            return newLeg
        }
        
        
    }
    
    

