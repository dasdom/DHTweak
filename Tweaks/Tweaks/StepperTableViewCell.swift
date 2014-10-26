//
//  StepperTableViewCell.swift
//  TweaksDemo
//
//  Created by dasdom on 29.09.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit

class StepperTableViewCell: UITableViewCell {

    let nameLabel: UILabel
    let valueLabel: UILabel
    let stepper: UIStepper
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        nameLabel = {
            let label = UILabel()
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            return label
        }()
        
        valueLabel = {
            let label = UILabel()
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            return label
            }()
        
        stepper = {
            let stepper = UIStepper()
            stepper.setTranslatesAutoresizingMaskIntoConstraints(false)
            return stepper
        }()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(stepper)
        
        let views = ["nameLabel" : nameLabel, "valueLabel" : valueLabel, "stepper" : stepper]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-10-[nameLabel]-5-[valueLabel]-5-[stepper]-10-|", options:  NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nameLabel(valueLabel)]|", options: nil, metrics: nil, views: views))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
