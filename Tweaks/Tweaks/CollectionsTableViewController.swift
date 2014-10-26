//
//  CollectionsTableViewController.swift
//  TweaksDemo
//
//  Created by dasdom on 28.09.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit

class CollectionsTableViewController: UITableViewController, UITextFieldDelegate {

    let collections: [TweakCollection]
    
    init(collections: [TweakCollection]) {
        self.collections = collections
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(StepperTableViewCell.self, forCellReuseIdentifier: "StepperCell")
        tableView.registerClass(SwitchTableViewCell.self, forCellReuseIdentifier: "SwitchCell")
        tableView.registerClass(ColorTableViewCell.self, forCellReuseIdentifier: "ColorCell")
        tableView.registerClass(StringTableViewCell.self, forCellReuseIdentifier: "StringCell")
        tableView.rowHeight = 44
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "dismiss:")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return collections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections[section].allTweaks().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?

        let tweak: AnyObject = collections[indexPath.section].allTweaks()[indexPath.row]
        println("tweak: \(tweak)")
        if let tweak = tweak as? Tweak<Int> {
            println("Tweak<Int>: currentValue \(tweak.currentValue)")
            let stepperCell = tableView.dequeueReusableCellWithIdentifier("StepperCell", forIndexPath: indexPath) as StepperTableViewCell
            configStepperCell(stepperCell, tweak: tweak)
            stepperCell.stepper.value = Double(tweak.currentValue!)
            stepperCell.stepper.stepValue = 1
            cell = stepperCell
        } else if let tweak = tweak as? Tweak<Float> {
            println("Tweak<Float>: currentValue \(tweak.currentValue)")
            let stepperCell = tableView.dequeueReusableCellWithIdentifier("StepperCell", forIndexPath: indexPath) as StepperTableViewCell
            configStepperCell(stepperCell, tweak: tweak)
            stepperCell.stepper.value = Double(tweak.currentValue!)
            stepperCell.stepper.stepValue = 0.01
            cell = stepperCell
//        } else if let tweak = tweak as? Tweak<CGFloat> {
//            println("tweak is CGFloat: \(tweak.currentValue)")
//            configStepperCell(cell, tweak: tweak)
//            cell.stepper.value = Double(tweak.currentValue!)
//            cell.stepper.stepValue = 0.01
        } else if let tweak = tweak as? Tweak<Double> {
            println("Tweak<Double>: currentValue \(tweak.currentValue)")
            let stepperCell = tableView.dequeueReusableCellWithIdentifier("StepperCell", forIndexPath: indexPath) as StepperTableViewCell
            configStepperCell(stepperCell, tweak: tweak)
            stepperCell.stepper.value = tweak.currentValue!
            stepperCell.stepper.stepValue = 0.01
            cell = stepperCell
        } else if let tweak = tweak as? Tweak<Bool> {
            println("Tweak<Bool>: currentValue \(tweak.currentValue)")
            let switchCell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as SwitchTableViewCell
            switchCell.nameLabel.text = tweak.name
            switchCell.valueSwitch.on = tweak.currentValue!
            switchCell.valueSwitch.addTarget(self, action: "changeBoolValue:", forControlEvents: .ValueChanged)
            cell = switchCell
        } else if let tweak = tweak as? Tweak<UIColor> {
            println("Tweak<UIColor>: currentValue \(tweak.currentValue)")
            let colorCell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath) as ColorTableViewCell
            colorCell.nameLabel.text = tweak.name
            if let hexString = tweak.currentValue?.hexString() {
                colorCell.textField.text = hexString
                colorCell.colorView.backgroundColor = tweak.currentValue
            }
            colorCell.textField.tag = 100
            colorCell.textField.delegate = self
            cell = colorCell
        } else if let tweak = tweak as? Tweak<String> {
            println("Tweak<String>: currentValue \(tweak.currentValue)")
            let stringCell = tableView.dequeueReusableCellWithIdentifier("StringCell", forIndexPath: indexPath) as StringTableViewCell
            stringCell.nameLabel.text = tweak.name
            if let string = tweak.currentValue {
                stringCell.textField.text = string
            }
            stringCell.textField.tag = 101
            stringCell.textField.delegate = self
            cell = stringCell
        } else {
            println("tweak is something else")
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collections[section].name
    }
    
    func configStepperCell<T>(cell: StepperTableViewCell, tweak: Tweak<T>) {
        cell.nameLabel.text = tweak.name
        cell.valueLabel.text = "\(tweak.currentValue!)"
        cell.stepper.addTarget(self, action: "changeCurrentValue:", forControlEvents: .ValueChanged)
    }
    
    func changeCurrentValue(sender: UIStepper) {
        if let indexPath = indexPathForCellSubView(sender) {
            let tweak: AnyObject = collections[indexPath.section].allTweaks()[indexPath.row]
            if let tweak = tweak as? Tweak<Int> {
                tweak.currentValue = Int(sender.value)
            } else if let tweak = tweak as? Tweak<Float> {
                tweak.currentValue = Float(sender.value)
//            } else if let tweak = tweak as? Tweak<CGFloat> {
//                tweak.currentValue = CGFloat(sender.value)
            } else if let tweak = tweak as? Tweak<Double> {
                tweak.currentValue = sender.value
            }
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
    }
    
    func changeBoolValue(sender: UISwitch) {
        if let indexPath = indexPathForCellSubView(sender) {
            let tweak: AnyObject = collections[indexPath.section].allTweaks()[indexPath.row]
            if let tweak = tweak as? Tweak<Bool> {
                tweak.currentValue = sender.on
            }
//            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 100:
            let hexString: NSString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            if hexString.length == 6 {
                let scanner = NSScanner(string: hexString)
                
                var value = UInt32()
                if scanner.scanHexInt(&value) {
                    if let indexPath = indexPathForCellSubView(textField) {
                        let tweak: AnyObject = collections[indexPath.section].allTweaks()[indexPath.row]
                        if let tweak = tweak as? Tweak<UIColor> {
                            tweak.currentValue = UIColor.colorFromHex(hexString)
                        }
                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                    }
                    //                textField.textColor = UIColor.greenColor()
                } else {
                    //                textField.textColor = UIColor.redColor()
                }
            }
        case 101:
            let theString: NSString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)

            if let indexPath = indexPathForCellSubView(textField) {
                let tweak: AnyObject = collections[indexPath.section].allTweaks()[indexPath.row]
                if let tweak = tweak as? Tweak<String> {
                    tweak.currentValue = theString
                }
            }
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    func indexPathForCellSubView(view: UIView) -> NSIndexPath? {
        let convertedPoint = view.superview!.convertPoint(view.center, toView: tableView)
        let indexPath = tableView.indexPathForRowAtPoint(convertedPoint)
        println("indexPath \(indexPath)")
        return indexPath
    }
    
    func dismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
