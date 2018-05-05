//
//  TripCollectionViewCell.swift
//  TApp
//
//  Created by Liam Breen on 4/26/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit
import SnapKit

class TripCollectionViewCell: UICollectionViewCell {
    
    var slLabel: UILabel!
    var elLabel: UILabel!
    var sdLabel: UILabel!
    var edLabel: UILabel
    var hLabel: UILabel!
    
    var arrowLabel: UILabel!
    
    var iconImg: UIImageView!
    
    override init(frame: CGRect) {
        slLabel = UILabel()
        elLabel = UILabel()
        sdLabel = UILabel()
        edLabel = UILabel()
        hLabel = UILabel()
        iconImg = UIImageView()
        
        super.init(frame: frame)
        
        let tBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        contentView.backgroundColor = tBackgroundColor
        
        slLabel = UILabel()
        elLabel = UILabel()
        sdLabel = UILabel()
        edLabel = UILabel()
        hLabel = UILabel()
        arrowLabel = UILabel()
        
        slLabel.text = "Start Location: "
        elLabel.text = "End Location: "
        sdLabel.text = "Start Date: "
        edLabel.text = "End Date: "
        hLabel.text = "Hotel: "
        arrowLabel.text = " -> "
        
        slLabel.textColor = .white
        elLabel.textColor = .white
        sdLabel.textColor = .white
        edLabel.textColor = .white
        hLabel.textColor = .white
        arrowLabel.textColor = .white

        
        slLabel.font = UIFont.systemFont(ofSize: 24)
        elLabel.font = UIFont.systemFont(ofSize: 24)
        sdLabel.font = UIFont.systemFont(ofSize: 16)
        edLabel.font = UIFont.systemFont(ofSize: 16)
        hLabel.font = UIFont.systemFont(ofSize: 16)
        arrowLabel.font = UIFont.systemFont(ofSize: 24)
        
        
        
        contentView.addSubview(slLabel)
        contentView.addSubview(elLabel)
        contentView.addSubview(sdLabel)
        contentView.addSubview(edLabel)
        contentView.addSubview(hLabel)
        contentView.addSubview(arrowLabel)
        contentView.addSubview(iconImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        slLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
        }
        arrowLabel.snp.makeConstraints { make in
            make.leading.equalTo(slLabel.snp.trailing).offset(2)
            make.centerY.equalTo(slLabel.snp.centerY)
        }
        elLabel.snp.makeConstraints { make in
            make.centerY.equalTo(slLabel.snp.centerY)
            make.leading.equalTo(arrowLabel.snp.trailing).offset(2)
        }
        sdLabel.snp.makeConstraints { make in
            make.leading.equalTo(slLabel.snp.leading)
            make.top.equalTo(slLabel.snp.bottom).offset(8)
        }
        edLabel.snp.makeConstraints { make in
            make.top.equalTo(sdLabel.snp.bottom).offset(8)
            make.leading.equalTo(slLabel.snp.leading)
        }
        hLabel.snp.makeConstraints { make in
            make.top.equalTo(edLabel.snp.bottom).offset(8)
            make.leading.equalTo(slLabel.snp.leading)
        }
        iconImg.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
        
        super.updateConstraints()
    }
    
    
}
