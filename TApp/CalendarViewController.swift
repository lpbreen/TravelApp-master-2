//
//  CalendarViewController.swift
//  TApp
//
//  Created by Liam Breen on 4/28/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit
import SnapKit

let months = ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"]

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var daysCV: UICollectionView!
    let calendarCellReuseIdentifier = "calendarCell"
    let headerReuseIdentifier = "header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Calendar"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 12, right: 0)
        daysCV = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        daysCV.backgroundColor = .white
        daysCV.dataSource = self
        daysCV.delegate = self
        daysCV.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: calendarCellReuseIdentifier)
        daysCV.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        
        view.addSubview(daysCV)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = daysCV.dequeueReusableCell(withReuseIdentifier: calendarCellReuseIdentifier, for: indexPath) as! CalendarCollectionViewCell
        
        cell.dayNumberLabel.text = String(indexPath.item + 1)
        
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numDays = 0
        switch section {
        case 0, 2, 4, 6, 7, 9, 11:
            numDays = 31
        case 3, 5, 8, 10:
            numDays = 30
        case 1:
            numDays = 28
        default:
            numDays = 0
        }
        return numDays
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dayVC = DayViewController()
        navigationController?.pushViewController(dayVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = daysCV.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! HeaderReusableView
        
        if kind == UICollectionElementKindSectionHeader{
            view.titleLabel.text = "\(months[indexPath.section])"
        }
        view.setNeedsUpdateConstraints()
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 70)
    }
}

