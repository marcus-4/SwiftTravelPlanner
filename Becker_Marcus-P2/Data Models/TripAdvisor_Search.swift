//
//  TripAdvisor_Search.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 5/3/24.
//

import Foundation


@Observable
class TripAdvisor_Search {
    
//    let locationID: String
//    
//    init(locationID: String) {
//        self.locationID = locationID
//    }
    
    let searchStr: String
    init(searchStr: String) {
        self.searchStr = searchStr
    }
    
//    let locPair: String
//    init(locPair: String {
//        
//    }
//    
//    let radius: String
    
    
    let decoder = JSONDecoder()

    let headers = ["accept": "application/json"]
    
    
    func getLocation() async -> TALocation? {
        
        let getter = Task {
            
            
            let url = URL(string: "https://api.content.tripadvisor.com/api/v1/location/search")!
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
              URLQueryItem(name: "key", value: "2AF4CBB1A0984815B81A299C018AB444"),
              URLQueryItem(name: "searchQuery", value: searchStr),
              //URLQueryItem(name: "latLong", value: locPair),
              //URLQueryItem(name: "radius", value: radius),
              //URLQueryItem(name: "radiusUnit", value: "m"),
              URLQueryItem(name: "language", value: "en"),
            ]
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

            var request = URLRequest(url: components.url!)
            
            
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            //let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            let (data, response) = try await session.data(for: request as URLRequest)
            
            
            //TODO: Handle Errors properly, interpret code and add logic
            let httpResponse = response as? HTTPURLResponse
            //print(httpResponse!)
            
            let receivedLocation = try self.decoder.decode(TALocation.self,from: data)
            //print(data)
            //print(receivedLocation.latitude!)
            
            
            
            
            
            
            
            return receivedLocation
        }
        do {
            return try await getter.value
        } catch {
            print(error)
            return nil
        }
        
    }
    
    
}



