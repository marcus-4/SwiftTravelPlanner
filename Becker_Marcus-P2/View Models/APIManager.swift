//
//  APIManager.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation



//Search with TA


class APIManager {
    
    //var mapViewModel: MapViewModel
    
    var TAItem: TALocation?
    
    init(TAItem: TALocation? = nil) {

        self.TAItem = TAItem
    }
    
    func getTASearch(searchStr: String) async {
        
        Task {
            if searchStr != "" {
                self.TAItem = try await TripAdvisor_Search(searchStr: searchStr).getLocation()
            } else {
                print("Search String is Empty")
            }
            
        }
        
        print(TAItem)
    }
    
}
