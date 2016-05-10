//
//  Base.swift
//  AppBasicLibrary
//
//  Created by Roma Novakov on 04.05.16.
//  Copyright © 2016 novacom. All rights reserved.
//

import Foundation

//MARK: - ModelObserver Protocol
@objc public protocol ObserverModelProtocol : class {

    optional func modelDidLoad()
}

//MARK: - ObservableModelProtocol Protocol
public protocol ObservableProtocol {
    
    var observerSet : NSMutableSet { get }
    
    func registerObserver(observer: NSObject)
    func unregisterObserver(observer: NSObject)
    func notifyObserversWithSelector(selector: Selector, andObject object: AnyObject?)
    func notifyObserversInMainThreadWithSelector(selector: Selector, andObject object: AnyObject?)
    
}


//MARK: - ObservableObject Protocol
public class ObservableObject : NSObject, ObservableProtocol {

    private(set) public var observerSet : NSMutableSet = NSMutableSet()
    
    public func registerObserver(observer: NSObject) {
        
        let lockQueue = dispatch_queue_create("com.registerObserver.queue", nil)
        dispatch_sync(lockQueue) { [unowned self] in
            let weakLink = WeakLink(target: observer)
            self.observerSet.addObject(weakLink)
        }
        
    }
    
    public func unregisterObserver(observer: NSObject) {
        
        let lockQueue = dispatch_queue_create("com.unregisterObserver.queue", nil)
        dispatch_sync(lockQueue) { [unowned self] in
            let weakLink = WeakLink(target: observer)
            self.observerSet.removeObject(weakLink)
        }
    }
   
    public func notifyObserversWithSelector(selector: Selector, andObject object: AnyObject?) {
        
        let lockQueue = dispatch_queue_create("com.unregisterObserver.queue", nil)
        dispatch_sync(lockQueue) { [unowned self] in
            for object in self.observerSet {
                let weakLink = object as! WeakLink
                if let isResponse = weakLink.target?.respondsToSelector(selector) {
                    if isResponse {
                        weakLink.target?.performSelector(selector, withObject: object)
                    }
                }
            }
        }
    }

    public func notifyObserversInMainThreadWithSelector(selector: Selector, andObject object: AnyObject?) {
        
        let lockQueue = dispatch_queue_create("com.unregisterObserver.queue", nil)
        dispatch_sync(lockQueue) { [unowned self] in
            for object in self.observerSet {
                let weakLink = object as! WeakLink
                if let isResponse = weakLink.target?.respondsToSelector(selector) {
                    if isResponse {
                        dispatch_async(dispatch_get_main_queue()) { [unowned  weakLink] in
                            weakLink.target?.performSelector(selector, withObject: object)
                        }
                    }
                }
            }
        }
    }
    
// Only test method
    deinit {
        print("Deinit: "+"\(self)")
    }
    
}


