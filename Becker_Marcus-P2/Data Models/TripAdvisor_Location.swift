//Derived From TripAdvisor API reference Template
//Marcus Becker
/*
import Foundation
 
//MARK: commented out because it was my non-working attempt to adapt to async await style API call, to match notes

@Observable
class TripAdvisor_Location {
    
    let locationID: String
    
    init(locationID: String) {
        self.locationID = locationID
    }
    
    let decoder = JSONDecoder()

    let headers = ["accept": "application/json"]
    
    
    func getLocation() async -> TALocation? {
        
        let getter = Task {
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://api.content.tripadvisor.com/api/v1/location/\(locationID)/details?key=2AF4CBB1A0984815B81A299C018AB444&language=en&currency=USD")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            //let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            let (data, response) = try await session.data(for: request as URLRequest)
            
            
            //TODO: Handle Errors properly, interpret code and add logic
            let httpResponse = response as? HTTPURLResponse
            //print(httpResponse!)
            
            let receivedLocation = try self.decoder.decode(TALocation.self,from: data)
            print(data)
            //print(receivedLocation?.latitude)
            
            
            
            
            
            
            
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


*/

