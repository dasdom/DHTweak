//
//  ShakeableWindow.swift
//  TweaksDemo
//
//  Created by dasdom on 29.09.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit

public class ShakeableWindow: UIWindow {

    var isShaking = false
    
    override public func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == UIEventSubtype.MotionShake {
            isShaking = true
            let sec = 0.4 * Float(NSEC_PER_SEC)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(sec)), dispatch_get_main_queue(), {
                if self.shouldPresentTweaksController() {
                    self.presentTweaks()
                }
            })
        }
    }
    
    override public func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        isShaking = false
    }
    
    func shouldPresentTweaksController() -> Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return self.isShaking && UIApplication.sharedApplication().applicationState == .Active
        #endif
    }
    
    func presentTweaks() {
        var visibleViewController = self.rootViewController
        while let presentingViewController = visibleViewController?.presentingViewController {
            visibleViewController = presentingViewController
        }
        
        if (visibleViewController is CategoriesTableViewController) == false {
            visibleViewController?.presentViewController(UINavigationController(rootViewController: CategoriesTableViewController()), animated: true, completion: nil)
        }
    }
}
