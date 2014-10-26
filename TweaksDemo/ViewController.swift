//
//  ViewController.swift
//  TweaksDemo
//
//  Created by dasdom on 25.10.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit
import Tweaks

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fontSize = CGFloat(Tweak.valueForCategory("Main View", collectionName: "Text", name: "Size", defaultValue: 20, minimumValue: 10, maximumValue: 40))
        label.font = UIFont.systemFontOfSize(fontSize)
        
//        let isRedColor = Tweak.valueForCategory("Main View", collectionName: "Text", name: "Red", defaultValue: false)
//        label.textColor = isRedColor ? UIColor.redColor() : UIColor.blackColor()
        
        let textColor = Tweak.valueForCategory("Main View", collectionName: "Text", name: "Color", defaultValue: UIColor.blackColor())
        label.textColor = textColor
        
        let backgroundColor = Tweak.valueForCategory("Main View", collectionName: "Background", name: "Color", defaultValue: UIColor.whiteColor())
        view.backgroundColor = backgroundColor
        
        let text = Tweak.valueForCategory("Main View", collectionName: "Text", name: "Text", defaultValue: "Hello")
        label.text = text
    }
    
}

