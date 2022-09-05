//
//  StationDetailsView.swift
//  Bike_station
//
//  Created by vinoj randika on 2022-09-05.
//

import SwiftUI
import MapKit

struct StationDetailsView: View {
    var stationObject: Station
    
    @ObservedObject private var locationManger =  LocationManager()
    
    
    
    var body: some View {
        
        let currentCordinate = self.locationManger.location != nil ? self.locationManger.location!.coordinate: CLLocationCoordinate2D()
        
        let loc1 = CLLocation(latitude: currentCordinate.latitude, longitude: currentCordinate.longitude)
        
        let loc2 = CLLocation(latitude: stationObject.latitude, longitude: stationObject.longitute)
        
        var distance = loc1.distance(from: loc2)
        var roundeddistance = Int(distance.rounded())
        
        let longitude = stationObject.longitute
        let latitude = stationObject.latitude
        
        VStack {
            
            ZStack {
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude:longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), interactionModes: [])
                
                HStack{
                    Image("bike")
                    Text("\(stationObject.availableBike)")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(.green)
                        .padding()
                        .cornerRadius(10)
                }
            }
          
            
            VStack (alignment: .leading){
                Text((stationObject.stationName))
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .frame(alignment: .leading)
                
                Text("\(roundeddistance)m - Bike Station")
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: .topLeading
              )
            .padding()
            
            
            HStack (spacing: 50){
                VStack {
                    Image("bike")
                    Text("Available Bikes")
                    Text("\(stationObject.availableBike)")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.green)
                }
                
                VStack {
                    Image("lock")
                    Text("Available Places")
                    Text("\(stationObject.availablePlaces)")
                        .font(.system(size: 60, weight: .bold))
                }
            }
            .padding()
            
        }
    }
}

struct StationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailsView(stationObject: Station(id: 1, stationName: "la", availableBike: 1, availablePlaces: 1, availableFreeSlot: 1, longitute: 1, latitude: 1))
    }
}
