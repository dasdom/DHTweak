//
//  TweakCollection.swift
//  TweaksDemo
//
//  Created by dasdom on 22.08.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import Foundation

class TweakCollection {
    let name: String
//    var tweaks = [AnyObject]()
    
    private var identifierTweaks = [String:AnyObject]()
    
    init(name: String) {
        self.name = name
    }
    
    func allTweaks() -> [AnyObject] {
        var tweaks = [AnyObject]()
        for (key, value) in identifierTweaks {
            tweaks.append(value)
        }
        return tweaks
    }
    
    func addTweak<T>(tweak: Tweak<T>) {
//        tweaks.append(tweaks)
        identifierTweaks[tweak.tweakIdentifier] = tweak
    }
    
    func removeTweak<T>(tweak: Tweak<T>) {
//        for i in 0..<tweaks.count {
//            let tweakFromCollection: (AnyObject) = tweaks[i]
//            if tweakFromCollection as AnyObject == tweak as AnyObject {
//                
//            }
//        }
        tweak.remove()
        identifierTweaks.removeValueForKey(tweak.tweakIdentifier)
    }
    
    func tweakWithIdentifier(identifier: String) -> AnyObject? {
        return identifierTweaks[identifier]
    }
}