//
//  LocationManager.swift
//  Becker_Marcus-P2
//
//  Created by Marcus Becker on 4/14/24.
//

import Foundation
import MapKit
import Combine


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, MKLocalSearchCompleterDelegate {
    let manager = CLLocationManager()
    @Published var region: MKCoordinateRegion
    @Published var location: CLLocationCoordinate2D?
    @Published var name: String = ""
    @Published var search: String = ""

    @Published var searchResults = [MKLocalSearchCompletion]()
    var publisher: AnyCancellable?
    var searchCompleter = MKLocalSearchCompleter()

    override init() {
        let latitude = 0
        let longitude = 0
        self.region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude:
                                                                        CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), span:
                                            MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        super.init()
        manager.delegate = self
        searchCompleter.delegate = self

        self.publisher = $search.receive(on: RunLoop.main).sink(receiveValue: { [weak self] (str) in
            self?.searchCompleter.queryFragment = str
        })
    }
    

    func requestLocation() {
        manager.requestLocation()
    }
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
   
    func getDistance(searchResult: MKLocalSearchCompletion, completionHandler: @escaping (String) -> ()) {
      let searchRequest = MKLocalSearch.Request(completion: searchResult)
      let search = MKLocalSearch(request: searchRequest)
      var placeMarkCoordinates: CLLocation = CLLocation(latitude: 0, longitude: 0)
      search.start { (response, error) in
        guard let coordinate = response?.mapItems[0].placemark.coordinate else {
          return
        }

        placeMarkCoordinates = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
          let targetloc = CLLocation(latitude: self.location?.latitude ?? 0, longitude: self.location?.longitude ?? 0)
          completionHandler("\(String(format: " Distance : %.2f ",targetloc.distance(from: placeMarkCoordinates).toKilometers())) KM")
      }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }
    
    func update() {
            let latitude = location?.latitude ?? 0
            let longitude = location?.longitude ?? 0
            self.region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude:
                                                                            CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), span:
                                                MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemarks, error in

                guard let placemark = placemarks?.first else {
                    let errorString = error?.localizedDescription ?? "Unexpected Error"
                    print("Unable to reverse geocode the given location. Error: \(errorString)")
                    return
                }

                let reversedGeoLocation = GeoLocation(with: placemark)
                self.name = reversedGeoLocation.name
            }
        }
        func reverseUpdate() {
            let geocoder = CLGeocoder()

            geocoder.geocodeAddressString(name) { placemarks, error in
                
                guard error == nil else {
                    print("*** Error in \(#function): \(error!.localizedDescription)")
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("*** Error in \(#function): placemark is nil")
                    return
                }
                let coord = placemark.location?.coordinate ?? CLLocationCoordinate2D(latitude:
                                                                                        CLLocationDegrees(0), longitude: CLLocationDegrees(0))
                self.region = MKCoordinateRegion(center: coord, span:
                                                    MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                self.location = CLLocationCoordinate2D(latitude: placemark.location?.coordinate.latitude ?? 0, longitude: placemark.location?.coordinate.longitude ?? 0)
                
            }

        }
    
}
extension CLLocationDistance {
    func toMiles() -> CLLocationDistance {
        return self*0.00062137
    }

    func toKilometers() -> CLLocationDistance {
        return self/1000
    }
}

struct GeoLocation {
    let name: String
    let streetName: String
    let city: String
    let state: String
    let zipCode: String
    let country: String
    init(with placemark: CLPlacemark) {
            self.name           = placemark.name ?? ""
            self.streetName     = placemark.thoroughfare ?? ""
            self.city           = placemark.locality ?? ""
            self.state          = placemark.administrativeArea ?? ""
            self.zipCode        = placemark.postalCode ?? ""
            self.country        = placemark.country ?? ""
        }

}
