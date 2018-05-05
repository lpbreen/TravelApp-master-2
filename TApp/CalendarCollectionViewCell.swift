//
//  CalendarCollectionViewCell.swift
//  TravelApp
//
//  Created by Zack Hurwitz on 4/24/18.
//  Copyright © 2018 Zack. All rights reserved.
//

import UIKit
import SnapKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    var dayNumberLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        print("2")
        
        dayNumberLabel = UILabel()
        
        contentView.addSubview(dayNumberLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        dayNumberLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        super.updateConstraints()
    }
}

