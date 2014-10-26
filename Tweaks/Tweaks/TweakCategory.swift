//
//  TweakCategory.swift
//  TweaksDemo
//
//  Created by dasdom on 22.08.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import Foundation

class TweakCategory {
    let name: String
    
    private var namedCollection = [String:TweakCollection]()
    
    init(name: String) {
        self.name = name
    }
    
    func allCollections() -> [TweakCollection] {
        var collections = [TweakCollection]()
        for (key, value) in namedCollection {
            collections.append(value)
        }
        return collections
    }
    
    func addCollection(collection: TweakCollection) {
        namedCollection[collection.name] = collection
    }
    
    func removeCollection(collection: TweakCollection) {
        namedCollection.removeValueForKey(collection.name)
    }
    
    func collectionWithName(name: String) -> TweakCollection? {
        return namedCollection[name]
    }
}