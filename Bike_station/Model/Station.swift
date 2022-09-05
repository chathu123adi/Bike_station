//
//  Station.swift
//  Bike_station
//
//  Created by vinoj randika on 2022-09-03.
//

import Foundation
////Mark: Station
//struct Station: Decodable {
//
//}

//Mark: Station data
struct Station: Identifiable, Decodable {
    let id: Int
    let stationName: String // label
    let availableBike:Int  // bike
    let availablePlaces: Int // bike_racks
    let availableFreeSlot: Int // free_rack
    let longitute , latitude: Double
    
    
//    enum CodingKeys: String, CodingKey{
//        case id
//        case numberOfBike = "dsfggs"
//        case numberOfAvailableBike = "sdg"
//        case userDistance = "sdgsj"
//    }
}
