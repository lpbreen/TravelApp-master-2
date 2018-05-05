//
//  Trip.swift
//  TApp
//
//  Created by Liam Breen on 4/26/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import Foundation

enum TripType {
    case car
    case plane
}

class Trip {
    
    var startLocation: String
    var endLocation: String
    var startDate: Date
    var endDate: Date
    var hotel: String
    var id: Int
    var tripType: TripType
    
    init(startLocation: String, endLocation: String, startDate: Date, endDate: Date, hotel: String, id: Int, tripType: TripType) {
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.startDate = startDate
        self.endDate = endDate
        self.hotel = hotel
        self.id = id
        self.tripType = tripType
    }
    
}
