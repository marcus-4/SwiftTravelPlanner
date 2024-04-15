//From TripAdvisor API reference
//Marcus Becker

import Foundation

@Observable
class TripAdvisor_Location {
    
    let decoder = JSONDecoder()

    let headers = ["accept": "application/json"]

    let request = NSMutableURLRequest(url: NSURL(string: "https://api.content.tripadvisor.com/api/v1/location/271186/details?key=2AF4CBB1A0984815B81A299C018AB444&language=en&currency=USD")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    //how to pass modified versions
    
    func getLocation() {
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let data = data
            {
                do{
                    
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse!)
                    
                    let receivedLocation = try self.decoder.decode(TALocation.self,from: data)
                    print(receivedLocation.latitude)
                } catch {
                    print(error as Any)
                }
            }
        })
        
        
        dataTask.resume()
    }
    
    
}



