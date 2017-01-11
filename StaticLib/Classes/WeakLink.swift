//
//  WeakLink.swift
//  AppBasicLibrary
//
//  Created by Roma Novakov on 07.05.16.
//  Copyright © 2016 novacom. All rights reserved.
//

//import Foundation

open class WeakLink : NSObject {
    
    weak var target : NSObject?
    
    init(target : NSObject) {
        self.target = target
    }
    
    func isEqualToWeakLink(_ weakLink: WeakLink) -> Bool {
        return true
    }
    
    override open var hash: Int {
        let hashValue = self.target as? Int
        return hashValue ?? 0
    }
    
    override open func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? WeakLink {
            return self.isEqualToWeakLink(obj)
        }
        return false
    }
    
}

