//
//  ItineraryViewController.swift
//  TApp
//
//  Created by Liam Breen on 5/5/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

protocol RestaurantDelegate {
    func addToRestaurants(restaurant: String)
}

class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTripDelegate, RestaurantDelegate {
    
    func updateTrip(trip: Trip, number: Int) {
        self.trip = trip
        self.tripNumber = number
    }
    
    func addToRestaurants(restaurant: String) {
        restaurants.append(restaurant)
    }
    
    var trip: Trip!
    var tripNumber: Int!
    var updateTripDelegate: UpdateTripDelegate!
    var centerPlace: CLLocation!
    var tableView: UITableView!
    var restaurants: [String]!
    
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
        
        restaurants = []
        
        tableView = UITableView()
        tableView.bounces = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        setupCosntraints()
    }
 
    func setupCosntraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //////////////////
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Restaurants"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        
        cell!.textLabel!.text = restaurants[indexPath.row]
        cell?.textLabel?.textColor = backgroundOrange
        //cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 24)
        cell?.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        cell!.setNeedsUpdateConstraints()
        return cell!
    }
    
    
    //////////////////
    
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
        makeVC.restaurantDelegate = self
        navigationController?.pushViewController(makeVC, animated: true)
        //present(makeVC, animated: true, completion: nil)
    }
    
}
