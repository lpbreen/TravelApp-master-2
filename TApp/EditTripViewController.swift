//
//  EditTripViewController.swift
//  TApp
//
//  Created by Liam Breen on 4/28/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit
import SnapKit
import YelpAPI
import BrightFutures

protocol UpdateTripDelegate {
    func updateTrip(trip: Trip, number: Int)
}

class EditTripViewController: UIViewController, DateDelegate {
    
    func setDate(date: Date, pickingSd: Bool) {
        if pickingSd {
            trip.startDate = date
        } else {
            trip.endDate = date
        }
    }
    
    var trip: Trip!
    var tripNumber: Int!
    var editStartDateButton: UIButton!
    var editEndDateButton: UIButton!
    var doneButton: UIButton!
    var updateTripDelegate: UpdateTripDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 255/255, green: 238/255, blue: 112/255, alpha: 1)
        
        editStartDateButton = UIButton()
        editStartDateButton.setTitle("Edit Start Date", for: .normal)
        editStartDateButton.setTitleColor(niceColor, for: .normal)
        editStartDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 60)
        editStartDateButton.layer.cornerRadius = 6
        editStartDateButton.addTarget(self, action: #selector(editStartDateButtonPressed), for: .touchUpInside)
        view.addSubview(editStartDateButton)
        
        editEndDateButton = UIButton()
        editEndDateButton.setTitle("Edit End Date", for: .normal)
        editEndDateButton.setTitleColor(niceColor, for: .normal)
        editEndDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 60)
        editEndDateButton.layer.cornerRadius = 6
        editEndDateButton.addTarget(self, action: #selector(editEndDateButtonPressed), for: .touchUpInside)
        view.addSubview(editEndDateButton)
        
        doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(niceColor, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        view.addSubview(doneButton)
        
        setupConstraints()
    }
    
    @objc func editStartDateButtonPressed() {
        let newVC = UpdatedCalendarViewController()
        newVC.delegate = self
        newVC.pickingStartDate = true
        present(newVC, animated: true)
    }
    
    @objc func editEndDateButtonPressed() {
        let newVC = UpdatedCalendarViewController()
        newVC.delegate = self
        newVC.pickingStartDate = false
        present(newVC, animated: true)
    }
    
    @objc func doneButtonPressed() {
        updateTripDelegate.updateTrip(trip: trip, number: tripNumber)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        editStartDateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
        }
        
        editEndDateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
        }
        
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
}
