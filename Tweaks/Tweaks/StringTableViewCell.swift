//
//  StringTableViewCell.swift
//  Tweaks
//
//  Created by dasdom on 26.10.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit

class StringTableViewCell: UITableViewCell {

    let nameLabel: UILabel
    let textField: UITextField
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        nameLabel = {
            let label = UILabel()
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            return label
            }()
        
        textField = {
            let textField = UITextField()
            textField.setTranslatesAutoresizingMaskIntoConstraints(false)
            textField.textAlignment = .Right
            return textField
            }()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(textField)
        
        let views = ["nameLabel" : nameLabel, "textField" : textField]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-10-[nameLabel]-(>=5)-[textField(150)]-10-|", options: .AlignAllCenterY, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nameLabel]|", options: .AlignAllCenterY, metrics: nil, views: views))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
