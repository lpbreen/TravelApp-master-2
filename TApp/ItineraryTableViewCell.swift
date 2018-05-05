//
//  ItineraryTableViewCell.swift
//  TApp
//
//  Created by Zack Hurwitz on 5/5/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit
import SnapKit

class ItineraryTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
            make.height.equalToSuperview().offset(-4)
        }
    }

}
