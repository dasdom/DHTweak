//
//  SwitchTableViewCell.swift
//  TweaksDemo
//
//  Created by dasdom on 29.09.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    let nameLabel: UILabel
    let valueSwitch: UISwitch
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        nameLabel = {
            let label = UILabel()
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            return label
        }()
        
        valueSwitch = {
            let valueSwitch = UISwitch()
            valueSwitch.setTranslatesAutoresizingMaskIntoConstraints(false)
            return valueSwitch
        }()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueSwitch)
        
        let views = ["nameLabel" : nameLabel, "valueSwitch" : valueSwitch]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-10-[nameLabel]-5-[valueSwitch]-10-|", options: .AlignAllCenterY, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nameLabel]|", options: nil, metrics: nil, views: views))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
