//
//  HourTableViewCell.swift
//  TravelApp
//
//  Created by Zack Hurwitz on 4/25/18.
//  Copyright © 2018 Zack. All rights reserved.
//

import UIKit
import SnapKit

class HourTableViewCell: UITableViewCell {
    
    var dateLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(dateLabel)
    }
    
    override func updateConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(4)
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

