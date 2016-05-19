//
//  AbstractArrayModel.swift
//  Pods
//
//  Created by Roma Novakov on 19.05.16.
//
//

import Foundation


@objc public protocol ArrayModelObserver : class {
    
    optional func arrayModelDidChange(arrayModel: AbstractArrayModel)
    optional func arrayModel(arrayModel: AbstractArrayModel,
                             didAddElementsAtIndexs indexs: [Int])
    optional func arrayModel(arrayModel: AbstractArrayModel,
                             didRemoveElementsAtIndexs indexs: [Int])
    optional func arrayModel(arrayModel: AbstractArrayModel,
                             didReplaceElementsAtIndexs indexs: [Int])
    optional func arrayModel(arrayModel: AbstractArrayModel,
                             didMoveElementAtIndexs indexs: Int, toIndex: Int)
    
}

public protocol AbstractArrayModelProtocol {
    
    // Add
    func addModel(model: AnyObject)
    func addModels(models: [AnyObject])
    func insertModels(models: [AnyObject])
    func insertModel(model: AnyObject, atIndex index: Int)
    
    // Remove
    func removeAllModels()
    func removeModel(model: AnyObject)
    func removeModelAtIndex(index: Int)
    
    // Move
    func moveModel(model: AnyObject, toIndex: Int)
    func moveModelAtIndex(index: Int, toIndex: Int)
    
    // Replace
    func replaceModel(model: AnyObject, atIndex: Int)
    func replaceModels(model: [AnyObject])
    
}


public class AbstractArrayModel : AbstractModel, AbstractArrayModelProtocol {

    private(set) public var array : Array = [AnyObject]()
    
    // Add
    public func addModel(model: AnyObject) {
        
        objc_sync_enter(self.array)
        
        self.array.append(model)
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: [self.array.count-1])
        
        objc_sync_exit(self.array)

    }
    
    /**
     Insert models after rest of the models
     
     - parameter models: new models
     */
    public func addModels(models: [AnyObject]) {
        
        objc_sync_enter(self.array)
        
        var indexs : [Int] = [Int]()

        for model in models {
            self.array.append(model)
            indexs.append(self.array.count-1)
        }
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)
        
        objc_sync_exit(self.array)
        
    }
    
    public func insertModel(model: AnyObject, atIndex index: Int) {
        objc_sync_enter(self.array)
        
        self.array.insert(model, atIndex: index)
        
        var indexs : [Int] = [Int]()
        indexs.append(index)
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)
        
        objc_sync_exit(self.array)
    }
    
    /**
     Insert models before all rest of the models
     
     - parameter models: New models
     */
    public func insertModels(models: [AnyObject]) {
        objc_sync_enter(self.array)
        
        let oldValues = self.array
        var sumarryValues : [AnyObject] = models
        sumarryValues+=oldValues
        self.array.removeAll()
        self.array += sumarryValues
        
        var indexs : [Int] = [Int]()
        for var i = 0; i < models.count; i++ {
            indexs.append(i)
        }
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)
        
        objc_sync_exit(self.array)
    }
    
    // Remove
    public func removeAllModels() {
        objc_sync_enter(self.array)
        
        
        
        objc_sync_exit(self.array)
    }
    public func removeModel(model: AnyObject) {
        objc_sync_enter(self.array)
        
        
        
        objc_sync_exit(self.array)
    }
    public func removeModelAtIndex(index: Int) {
        objc_sync_enter(self.array)
        
        
        
        objc_sync_exit(self.array)
    }
    
    // Move
    public func moveModel(model: AnyObject, toIndex: Int) {
        objc_sync_enter(self.array)
        
        
        
        objc_sync_exit(self.array)
    }
    public func moveModelAtIndex(index: Int, toIndex: Int) {
        objc_sync_enter(self.array)
        
        
        
        objc_sync_exit(self.array)
    }
    
    // Replace
    public func replaceModel(model: AnyObject, atIndex: Int) {
        objc_sync_enter(self.array)
        
        
        
        objc_sync_exit(self.array)
    }
    public func replaceModels(model: [AnyObject]) {
        objc_sync_enter(self.array)
        
        
        
        objc_sync_exit(self.array)
    }

    
}

