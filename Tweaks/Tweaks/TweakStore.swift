//
//  TweakStore.swift
//  TweaksDemo
//
//  Created by dasdom on 22.08.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import Foundation

private let _TweakStoreSharedInstance = TweakStore(name: "DefaultTweakStore")

public class TweakStore {
    class var sharedTweakStore: TweakStore {
        return _TweakStoreSharedInstance
    }
    
    let name: String
    
    private var namedCategories = [String:TweakCategory]()
    
    init(name: String) {
        self.name = name
    }
    
    func allCategories() -> [TweakCategory] {
        var categories = [TweakCategory]()
        for (key, value) in namedCategories {
            categories.append(value)
        }
        return categories
    }
    
    func addCategory(category: TweakCategory) {
        namedCategories[category.name] = category
    }
    
    func removeCategory(category: TweakCategory) {
        namedCategories.removeValueForKey(category.name)
    }
    
    func removeAllCategories() {
        namedCategories = [String:TweakCategory]()
    }
    
    func categoryWithName(name: String) -> TweakCategory? {
        return namedCategories[name]
    }
}