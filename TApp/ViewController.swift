//
//  ViewController.swift
//  TApp
//
//  Created by Liam Breen on 4/26/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit

protocol TripsLengthDelegate {
    func tripLen(len: Int!)
}

let niceColor = UIColor(red: 52/255.0, green: 187/255.0, blue: 255/255.0, alpha: 1)

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, TripDelegate, UpdateTripDelegate {
    
    func updateTrip(trip: Trip, number: Int) {
        trips[number] = trip
        collectionView.reloadData()
    }
    
    func makeNewTrip(trip: Trip) {
        trips.append(trip)
        setupCollectionView()
    }
    
    
    var collectionView: UICollectionView!
    
    let cellReuseIdentifier = "cellReuse"
    
    var delegate: TripsLengthDelegate!
    
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "+",
            style: .done,
            target: self,
            action: #selector(rightButtonPressed)
        )
        
        let font = UIFont.systemFont(ofSize: 30)
        navigationItem.rightBarButtonItem!.setTitleTextAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font], for: .normal)
        
        navigationItem.rightBarButtonItem!.setTitleTextAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font], for: .selected)
        
        self.title = "My Trips"
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "home.jpeg")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        collectionView.backgroundView = backgroundImage
        
        collectionView.register(TripCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! TripCollectionViewCell
        
        cell.sdLabel.text = "Leaving: " + dateDescriptionModifier(description: String(describing: trips[indexPath.row].startDate))
        cell.edLabel.text = "Returning: " + dateDescriptionModifier(description: String(describing: trips[indexPath.row].endDate))
        cell.slLabel.text = trips[indexPath.row].startLocation
        cell.elLabel.text = trips[indexPath.row].endLocation
        cell.hLabel.text = "Hotel: " + trips[indexPath.row].hotel
        
        var img: UIImage
        if (trips[indexPath.row].tripType == .car) {
            img = UIImage(named: "car.png")!
        } else {
            img = UIImage(named: "plane.png")!
        }
        
        cell.iconImg.image = img
        
        cell.layer.cornerRadius = 20.0
        cell.layer.masksToBounds = true
        cell.setNeedsUpdateConstraints()
            
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(((collectionView.frame.size.width / 2) - 10)*2), height: CGFloat(164))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tripDetailsVC = TripDetailsViewController()
        tripDetailsVC.tripNumber = indexPath.item
        tripDetailsVC.trip = trips[indexPath.item]
        tripDetailsVC.updateTripDelegate = self
        
        let presentVC = UINavigationController(rootViewController: tripDetailsVC)
        present(presentVC, animated: true, completion: nil)
    }
    
    @objc func rightButtonPressed(sender: UIButton) {
        let newVC = NTViewController()
        newVC.delegate = self
        delegate?.tripLen(len: trips.count)
        present(newVC, animated: true, completion: nil)
    }
    
    func setupCollectionView () {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "home.jpeg")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        collectionView.backgroundView = backgroundImage
        
        collectionView.register(TripCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.reloadData()
    }
    
    func dateDescriptionModifier(description: String) -> String {
        print(description)
        let year: String = description.substring(to: description.index(of: "-")!)
        print(year)
        let monthIndex = description.index(description.startIndex, offsetBy: 5)
        let endIndex = description.index(description.startIndex, offsetBy: 2)
        let month: String = description.substring(from: monthIndex).substring(to: endIndex)
        print(month)
        let dayIndex = description.index(description.startIndex, offsetBy: 8)
        let day: String = description.substring(from: dayIndex).substring(to: endIndex)
        print(day)
        return "\(month)/\(day)/\(year)"
    }
    
}

