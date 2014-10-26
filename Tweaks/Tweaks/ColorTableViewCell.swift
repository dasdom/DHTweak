//
//  ColorTableViewCell.swift
//  Tweaks
//
//  Created by dasdom on 26.10.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    let nameLabel: UILabel
    let textField: UITextField
    let colorView: UIView
    
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
        
        colorView = {
            let colorView = UIView()
            colorView.setTranslatesAutoresizingMaskIntoConstraints(false)
            return colorView
        }()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(textField)
        contentView.addSubview(colorView)
        
        let views = ["nameLabel" : nameLabel, "textField" : textField, "colorView" : colorView]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-10-[nameLabel]-(>=5)-[colorView(30)]-5-[textField(70)]-10-|", options: .AlignAllCenterY, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nameLabel]|", options: .AlignAllCenterY, metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[colorView(30)]", options: .AlignAllCenterY, metrics: nil, views: views))

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
