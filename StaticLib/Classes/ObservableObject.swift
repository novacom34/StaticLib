//
//  Base.swift
//  AppBasicLibrary
//
//  Created by Roma Novakov on 04.05.16.
//  Copyright © 2016 novacom. All rights reserved.
//

import Foundation

//MARK: - ObservableModelProtocol Protocol
public protocol ObservableProtocol {
    
    func registerObserver(_ observer: NSObject)
    func unregisterObserver(_ observer: NSObject)
    func notifyObserversWithSelector(_ selector: Selector, andObject object: AnyObject?)
    func notifyObserversInMainThreadWithSelector(_ selector: Selector, andObject object: AnyObject?)
}


//MARK: - ObservableObject

//
//
// ObservableObject it's base class of all Observable Models in app.
//
//

open class ObservableObject : NSObject, ObservableProtocol {
    
    private(set) open var observerSet : NSMutableSet = NSMutableSet()
    
    lazy private(set) var safeQueue: DispatchQueue = {
        let queue = DispatchQueue(label: "com.model.safeAccessThread", attributes: [])
        return queue
    }()
    
    open func registerObserver(_ observer: NSObject) {
        
        self.safeQueue.sync(flags: .barrier, execute: { [unowned self] in
            let weakLink = WeakLink(target: observer)
            self.observerSet.add(weakLink)
        })
    }
    
    open func unregisterObserver(_ observer: NSObject) {
        
        self.safeQueue.sync(flags: .barrier, execute: { [unowned self] in
            let weakLink = WeakLink(target: observer)
            self.observerSet.remove(weakLink)
        })
    }
    
//MARK: - Notify Observers functions
    open func notifyObserversWithSelector(_ selector: Selector, andObject object: AnyObject?) {
        
        let observersSetCopy = self.observerSet.copy() as! NSSet
        
        for obj in observersSetCopy {
            let weakLink = obj as! WeakLink
            if let isResponse = weakLink.target?.responds(to: selector) {
                if isResponse {
                    let observer = weakLink.target
                    observer?.perform(selector,
                                      with: self,
                                      with: object)
                }
            }
        }
    }

    
    open func notifyObserversInMainThreadWithSelector(_ selector: Selector, andObject object: AnyObject?) {
    
        if Thread.isMainThread {
            self.notifyObserversWithSelector(selector, andObject: object)
        } else {
            DispatchQueue.main.sync(execute: {[unowned self] in
                self.notifyObserversWithSelector(selector, andObject: object)
            })
        }
    }

//MARK: -
    
    
}



