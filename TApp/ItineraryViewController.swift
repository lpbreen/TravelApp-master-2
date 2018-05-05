//
//  ItineraryViewController.swift
//  TApp
//
//  Created by Liam Breen on 5/5/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ItineraryViewController: UIViewController, UpdateTripDelegate {
    func updateTrip(trip: Trip, number: Int) {
        self.trip = trip
        self.tripNumber = number
    }
    
    var trip: Trip!
    var tripNumber: Int!
    var updateTripDelegate: UpdateTripDelegate!
    var centerPlace: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerPlace = CLLocation(latitude: 0, longitude: 0)
        
        let address = self.trip.endLocation
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            
            if let unwrappedLat = lat, let unwrappedLon = lon {
                self.centerPlace = CLLocation(latitude: unwrappedLat, longitude: unwrappedLon)
            }
            self.doStuff()
        }
        
        
    }
 
    func doStuff () {
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "+",
            style: .done,
            target: self,
            action: #selector(rightButtonPressed)
        )
        
        let font = UIFont.systemFont(ofSize: 30)
        navigationItem.rightBarButtonItem!.setTitleTextAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font], for: .normal)
        
        navigationItem.rightBarButtonItem!.setTitleTextAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font], for: .selected)
        
        title = self.trip.endLocation
        
        let mapView = MKMapView()
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height/2
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        //mapView.center = view.center
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: self.centerPlace.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        view.addSubview(mapView)
    }
    
    @objc func rightButtonPressed(sender: UIButton) {
        let makeVC = MakeScheduleViewController()
        self.updateTripDelegate = makeVC
        updateTripDelegate.updateTrip(trip: trip, number: tripNumber)
        
        present(makeVC, animated: true, completion: nil)
    }
    
}
