//
//  MakeScheduleViewController.swift
//  TApp
//
//  Created by Liam Breen on 5/5/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

//
//  ItineraryViewController.swift
//  TApp
//
//  Created by Liam Breen on 5/5/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit
import MapKit

class MakeScheduleViewController: UIViewController, UpdateTripDelegate {
    func updateTrip(trip: Trip, number: Int) {
        self.trip = trip
        self.tripNumber = number
    }
    
    var trip: Trip!
    var tripNumber: Int!
    var updateTripDelegate: UpdateTripDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = self.trip.endLocation
        
        let mapView = MKMapView()
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = 300
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
    }
    
}

