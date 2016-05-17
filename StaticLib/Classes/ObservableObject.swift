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
        
        objc_sync_enter(self.observerSet)
        
        for obj in self.observerSet {
            let weakLink = obj as! WeakLink
            if let isResponse = weakLink.target?.respondsToSelector(selector) {
                if isResponse {
                    let observer = weakLink.target
                    observer?.performSelector(selector,
                                              withObject: self,
                                              withObject: object)
                }
            }
        }
    
        objc_sync_exit(self.observerSet)
        
    }

    public func notifyObserversInMainThreadWithSelector(selector: Selector, andObject object: AnyObject?) {
        
        objc_sync_enter(self.observerSet)
        
        for obj in self.observerSet {
            let weakLink = obj as! WeakLink
            if let isResponse = weakLink.target?.respondsToSelector(selector) {
                if isResponse {
                    let observer = weakLink.target
                    dispatch_async(dispatch_get_main_queue(),{ [unowned self] in
                        observer?.performSelector(selector,
                            withObject: self,
                            withObject: object)
                    })
                }
            }
        }
        
        objc_sync_exit(self.observerSet)
    }
    
// Only test method
    deinit {
        print("Deinit: "+"\(self)")
    }
    
}







