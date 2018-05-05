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

class MakeScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTripDelegate {
    func updateTrip(trip: Trip, number: Int) {
        self.trip = trip
        self.tripNumber = number
    }
    
    var trip: Trip!
    var tripNumber: Int!
    var updateTripDelegate: UpdateTripDelegate!
    var centerPlace: CLLocation!
    var tableView: UITableView!
    var cancelButton: UIButton!
    var attractions: [Attraction]! = []
    var restaurantDelegate: RestaurantDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pullAttractions()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.tableView.reloadData()
        }
        
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
        
        cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(backgroundOrange, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
        }
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func doStuff () {
        view.backgroundColor = .white
        
        title = self.trip.endLocation
        
        let mapView = MKMapView()
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 100
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
        
        tableView = UITableView()
        tableView.bounces = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.backgroundColor = .white
        //tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attractions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "tableCell")
       
        cell.textLabel?.text = self.attractions[indexPath.row].name
        
        if self.attractions[indexPath.row].img != nil {
            cell.imageView?.image = UIImage(data: self.attractions[indexPath.row].img! as Data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "tableCell")
        
        restaurantDelegate.addToRestaurants(restaurant: (cell.textLabel?.text)!)
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    func pullAttractions () {
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: "Food",
                                                                 location: self.trip.endLocation,
                                                                 latitude: nil,
                                                                 longitude: nil,
                                                                 radius: 15000,
                                                                 categories: nil,
                                                                 locale: .english_unitedStates,
                                                                 limit: 20,
                                                                 offset: 0,
                                                                 sortBy: .rating,
                                                                 priceTiers: nil,
                                                                 openNow: true,
                                                                 openAt: nil,
                                                                 attributes: nil) { (response) in
                                                                    
                                                                    if let response = response,
                                                                        let businesses = response.businesses,
                                                                        businesses.count > 0 {
                                                                        for business in businesses {
                                                                            var atr: Attraction!
                                                                            if business.imageUrl != nil {
                                                                                atr = Attraction(name: business.name!, url: business.imageUrl!)
                                                                            } else {
                                                                                atr = Attraction(name: business.name!, url: nil)
                                                                            }
                                                                            self.attractions.append(atr)
                                                                        }
                                                                    }
        }
    }
}
