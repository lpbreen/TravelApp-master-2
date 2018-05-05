//
//  HeaderReusableView.swift
//  TravelApp
//
//  Created by Zack Hurwitz on 4/28/18.
//  Copyright © 2018 Zack. All rights reserved.
//

import UIKit
import SnapKit

class HeaderReusableView: UICollectionReusableView {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel.textColor = .red
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
        
        
        super.updateConstraints()
    }
    
    
}

