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
            currentSDLabel.text = "Current: " + dateDescriptionModifier(description: String(describing: trip.startDate))
        } else {
            trip.endDate = date
            currentEDLabel.text = "Current: " + dateDescriptionModifier(description: String(describing: trip.endDate))
        }
    }
    
    var trip: Trip!
    var tripNumber: Int!
    var editStartDateButton: UIButton!
    var editEndDateButton: UIButton!
    var currentSDLabel: UILabel!
    var currentEDLabel: UILabel!
    var doneButton: UIButton!
    var updateTripDelegate: UpdateTripDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        editStartDateButton = UIButton()
        editStartDateButton.setTitle("Edit Start Date", for: .normal)
        editStartDateButton.setTitleColor(backgroundOrange, for: .normal)
        editStartDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 60)
        editStartDateButton.layer.cornerRadius = 6
        editStartDateButton.addTarget(self, action: #selector(editStartDateButtonPressed), for: .touchUpInside)
        view.addSubview(editStartDateButton)
        
        editEndDateButton = UIButton()
        editEndDateButton.setTitle("Edit End Date", for: .normal)
        editEndDateButton.setTitleColor(backgroundOrange, for: .normal)
        editEndDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 60)
        editEndDateButton.layer.cornerRadius = 6
        editEndDateButton.addTarget(self, action: #selector(editEndDateButtonPressed), for: .touchUpInside)
        view.addSubview(editEndDateButton)
        
        doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(backgroundOrange, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        view.addSubview(doneButton)
        
        currentSDLabel = UILabel()
        currentSDLabel.text = "Current: " + dateDescriptionModifier(description: String(describing: trip.startDate))
        currentSDLabel.textColor = backgroundOrange
        currentSDLabel.font = UIFont.systemFont(ofSize: 28)
        view.addSubview(currentSDLabel)
        
        currentEDLabel = UILabel()
        currentEDLabel.text = "Current: " + dateDescriptionModifier(description: String(describing: trip.endDate))
        currentEDLabel.textColor = backgroundOrange
        currentEDLabel.font = UIFont.systemFont(ofSize: 28)
        view.addSubview(currentEDLabel)
        
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
            make.top.equalToSuperview().offset(40)
        }
        
        currentSDLabel.snp.makeConstraints { make in
            make.leading.equalTo(editStartDateButton.snp.leading)
            make.top.equalTo(editStartDateButton.snp.bottom).offset(8)
        }
        
        editEndDateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentSDLabel.snp.bottom).offset(24)
        }
        
        currentEDLabel.snp.makeConstraints { make in
            make.leading.equalTo(editEndDateButton.snp.leading)
            make.top.equalTo(editEndDateButton.snp.bottom).offset(8)
        }
        
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
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
