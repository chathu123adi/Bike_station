//
//  StationViewModel.swift
//  Bike_station
//
//  Created by vinoj randika on 2022-09-05.
//

import Foundation
import SwiftUI
import MapKit

class StationViewModel: ObservableObject{
    var apiUrl = "http://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=stacje_rowerowe"
    
    @Published var stationsData = [Station]()
    @ObservedObject private var locationManger =  LocationManager()
    
    func findDistance (longitute: Double, Latitute: Double) -> Int {
        let currentCordinate = self.locationManger.location != nil ? self.locationManger.location!.coordinate: CLLocationCoordinate2D()
        
        let loc1 = CLLocation(latitude: currentCordinate.latitude, longitude: currentCordinate.longitude)
        
        let loc2 = CLLocation(latitude: longitute, longitude: Latitute)
        
        let distance = loc1.distance(from: loc2)
        let roundeddistance = Int(distance.rounded())
        
        return roundeddistance
    }
    
    func fetchStationData () {
        
        var json: AnyObject?
        
        guard let url = URL(string: apiUrl) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.httpBody =
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: request) { data, reponse, error in
                guard let data = data, error == nil else {return}
                
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                    
                    var features =  json?["features"] as! [[String: Any]]
                    
                    for (index, value) in features.enumerated() {
                            var property = value["properties"] as! [String : Any]
                        var geometry = value["geometry"] as! [String : Any]
                        
                        let cordinate = geometry["coordinates"] as? [Double]
                        
                        var id = Int(value["id"] as! String) ?? 0
                            
                            let stationName = property["label"] as! String
                            let availableBike = Int(property["bikes"] as! String) ?? 0
                            let availablePlaces = Int(property["bike_racks"] as! String) ?? 0
                            let updated = property["updated"] as! String
                            let freeRack = Int(property["free_racks"] as! String) ?? 0
                        
                        let longitude = cordinate?[0] as! Double
                        let latitude = cordinate?[1] as! Double
                        
                        self.stationsData.append(Station(id: id, stationName: stationName, availableBike: availableBike, availablePlaces: availablePlaces, availableFreeSlot: freeRack, longitute: longitude, latitude: latitude))
                    }
                    
                }catch{
                    print("Oopz not good json formatted response")
                    group.leave()
                }
                
            }
            task.resume()
        }
        
    }
}
