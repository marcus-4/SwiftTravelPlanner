//Derived From TripAdvisor API reference Template
//Marcus Becker


///Older version not using the async await astyle call 

import Foundation

@Observable
class TripAdvisor_Location {
    //TODO: Generalize to pass in ID
    let locationID: String
    
    init(locationID: String) {
        self.locationID = locationID
    }
    
    let decoder = JSONDecoder()

    let headers = ["accept": "application/json"]
    
    
    func getLocation() -> TALocation? {
        var receivedLocation: TALocation?
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.content.tripadvisor.com/api/v1/location/\(locationID)/details?key=2AF4CBB1A0984815B81A299C018AB444&language=en&currency=USD")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let data = data
            {
                do{
                    //TODO: Handle Errors properly, interpret code and add logic
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse!)
                    
                    receivedLocation = try self.decoder.decode(TALocation.self,from: data)
                    //print(receivedLocation.latitude)
                    
                } catch {
                    print(error as Any)
                }
            }
        })
        
        
        dataTask.resume()
        return receivedLocation
    }
    
    
}


