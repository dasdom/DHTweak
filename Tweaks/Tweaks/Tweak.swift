//
//  Tweak.swift
//  TweaksDemo
//
//  Created by dasdom on 22.08.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import Foundation
import UIKit

public class Tweak<T: Any> {
    let tweakIdentifier: String
    let name: String
    private let action: ((Tweak) -> ())?
    private let defaultValue: T
    private var storedCurrentValue: T?
    
    private var minimumValue: T?
    private var maximumValue: T?
    private var stepValue: T?
    
    var currentValue: T? {
        get {
            return self.storedCurrentValue ?? defaultValue
        }
        set {
            println("newValue: \(newValue), min \(minimumValue), max \(maximumValue)")
            if newValue != nil {
                if let value = newValue as? Bool {
                    storedCurrentValue = newValue
                    NSUserDefaults.standardUserDefaults().setBool(value, forKey: tweakIdentifier)
                    println("Bool")
                } else if let value = newValue as? Int {
                    if (minimumValue != nil && value < (minimumValue as? Int)) || (maximumValue != nil && value > (maximumValue as? Int)) {
                        println("value out of range")
                    } else {
                        storedCurrentValue = newValue
                        NSUserDefaults.standardUserDefaults().setInteger(value, forKey: tweakIdentifier)
                    }
                    println("Int")
                } else if let value = newValue as? Float {
                    if (minimumValue != nil && value < (minimumValue as? Float)) || (maximumValue != nil && value > (maximumValue as? Float)) {
                        println("value out of range")
                    } else {
                        storedCurrentValue = newValue
                        NSUserDefaults.standardUserDefaults().setFloat(value, forKey: tweakIdentifier)
                    }
                    println("Float")
                } else if let value = newValue as? CGFloat {
                    if (minimumValue != nil && value < (minimumValue as? CGFloat)) || (maximumValue != nil && value > (maximumValue as? CGFloat)) {
                        println("value out of range")
                    } else {
                        storedCurrentValue = newValue
                        NSUserDefaults.standardUserDefaults().setFloat(Float(value), forKey: tweakIdentifier)
                    }
                    println("Float")
                } else if let value = newValue as? Double {
                    if (minimumValue != nil && value < (minimumValue as? Double)) || (maximumValue != nil && value > (maximumValue as? Double)) {
                        println("value out of range")
                    } else {
                        storedCurrentValue = newValue
                        NSUserDefaults.standardUserDefaults().setDouble(value, forKey: tweakIdentifier)
                    }
                    println("Double")
                } else if let value = newValue as? String {
                    storedCurrentValue = newValue
                    NSUserDefaults.standardUserDefaults().setObject(value, forKey: tweakIdentifier)
                    println("String")
                } else if let value = newValue as? UIColor {
                    storedCurrentValue = newValue
                    let stringValue = value.hexString()
                    NSUserDefaults.standardUserDefaults().setObject(stringValue, forKey: tweakIdentifier)
                    println("UIColor: \(stringValue)")
                } else {
                    assert(false, "This is not a valid tweak default value. Use Bool, Int, Float, Double or String")
                }
                let valueHasBeenSetKey = "\(tweakIdentifier).valueHasBeenSet"
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: valueHasBeenSetKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    init(identifier: String, name: String, defaultValue: T) {
        self.tweakIdentifier = identifier
        self.defaultValue = defaultValue
        self.name = name
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        let valueHasBeenSetKey = "\(tweakIdentifier).valueHasBeenSet"
        if userDefaults.boolForKey(valueHasBeenSetKey) == true {
            if let value = defaultValue as? Bool {
                self.currentValue = NSUserDefaults.standardUserDefaults().boolForKey(identifier) as? T
                println("Bool")
            } else if let value = defaultValue as? Int {
                self.currentValue = NSUserDefaults.standardUserDefaults().integerForKey(identifier) as? T
                println("Int")
            } else if let value = defaultValue as? Float {
                self.currentValue = NSUserDefaults.standardUserDefaults().floatForKey(identifier) as? T
                println("Float")
            } else if let value = defaultValue as? CGFloat {
                self.currentValue = NSUserDefaults.standardUserDefaults().floatForKey(identifier) as? T
                println("CGFloat")
            } else if let value = defaultValue as? Double {
                self.currentValue = NSUserDefaults.standardUserDefaults().doubleForKey(identifier) as? T
                println("Double")
            } else if let value = defaultValue as? String {
                self.currentValue = NSUserDefaults.standardUserDefaults().stringForKey(identifier) as? T
                println("String")
            } else if let value = defaultValue as? UIColor {
                if let hexString = NSUserDefaults.standardUserDefaults().stringForKey(identifier) {
                    self.currentValue = UIColor.colorFromHex(hexString) as? T
                }
            } else {
                assert(false, "This is not a valid tweak default value. Use Bool, Int, Float, Double or String")
            }
        }

        println("identifer: \(identifier)")
    }
    
    func remove() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(tweakIdentifier)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
//    class func reset() {
//        let store = TweakStore.sharedTweakStore
//        
//        store.removeAllCategories()
//        NSUserDefaults.resetStandardUserDefaults()
//    }

    public class func valueForCategory(categoryName: String, collectionName: String, name: String, defaultValue: T, minimumValue: T? = nil, maximumValue: T? = nil) -> T {
        
        let identifier = categoryName.lowercaseString + "." + collectionName.lowercaseString + "." + name
        
        let collection = collectionWithName(collectionName, categoryName: categoryName)
        
//        let store = TweakStore.sharedTweakStore
//        
//        var category = store.categoryWithName(categoryName)
//        if category == nil {
//            category = TweakCategory(name: categoryName)
//            store.addCategory(category!)
//        }
//        
//        var collection = category!.collectionWithName(collectionName)
//        if collection == nil {
//            collection = TweakCollection(name: collectionName)
//            category!.addCollection(collection!)
//        }
        
        var tweak = collection.tweakWithIdentifier(identifier) as Tweak?
        if tweak == nil {
            tweak = Tweak(identifier: identifier, name: name, defaultValue: defaultValue) as Tweak!
            
            collection.addTweak(tweak!)
        }
        
        if minimumValue != nil && maximumValue != nil {
            tweak!.minimumValue = minimumValue
            tweak!.maximumValue = maximumValue
        }
        
        return (tweak!.currentValue ?? tweak!.defaultValue) as T
    }
    
//    class func removeForCategory(categoryName: String, collectionName: String, name: String) {
//        let identifier = categoryName.lowercaseString + "." + collectionName.lowercaseString + "." + name
//        
//        let collection = collectionWithName(collectionName, categoryName: categoryName)
//
//        if let tweak = collection.tweakWithIdentifier(identifier) as Tweak? {
//            tweak.remove()
//        }
//        
//    }
    
    class func collectionWithName(collectionName: String, categoryName: String) -> TweakCollection {
        let store = TweakStore.sharedTweakStore
        
        var category = store.categoryWithName(categoryName)
        if category == nil {
            category = TweakCategory(name: categoryName)
            store.addCategory(category!)
        }
        
        var collection = category!.collectionWithName(collectionName)
        if collection == nil {
            collection = TweakCollection(name: collectionName)
            category!.addCollection(collection!)
        }
        return collection!
    }
}