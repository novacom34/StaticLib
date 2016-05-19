//
//  WeakLink.swift
//  AppBasicLibrary
//
//  Created by Roma Novakov on 07.05.16.
//  Copyright © 2016 novacom. All rights reserved.
//

//import Foundation

public class WeakLink : NSObject {
    
    weak var target : NSObject?
    
    init(target : NSObject) {
        self.target = target
    }
    
    func isEqualToWeakLink(weakLink: WeakLink) -> Bool {
        return true
    }
    
    override public var hash: Int {
        let hashValue = self.target as? Int
        return hashValue ?? 0
    }
    
    override public func isEqual(object: AnyObject?) -> Bool {
        if let obj = object as? WeakLink {
            return self.isEqualToWeakLink(obj)
        }
        return false
    }
    
    deinit {
        print("Deinit: \(self)")
    }
    
}

