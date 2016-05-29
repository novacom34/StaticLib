//
//  AbstractArrayModel.swift
//  Pods
//
//  Created by Roma Novakov on 19.05.16.
//
//

import Foundation


@objc public protocol ObserverArrayModelProtocol : class {
    
    optional func arrayModelDidChange(arrayModel: AbstractArrayModel)
    optional func arrayModel(arrayModel: AbstractArrayModel,
                             didAddElementsAtIndexs indexs: [Int])
    optional func arrayModel(arrayModel: AbstractArrayModel,
                             didRemoveElementsAtIndexs indexs: [Int])
    optional func arrayModel(arrayModel: AbstractArrayModel,
                             didReplaceElementsAtIndexs indexs: [Int])
    optional func arrayModel(arrayModel: AbstractArrayModel,
                             didMoveElementAtIndexs indexs: [Int])
    
}

public protocol AbstractArrayModelProtocol {
    
    // Add
    func addModel(model: ObservableObject)
    func addModels(models: [ObservableObject])
    func insertModels(models: [ObservableObject])
    func insertModel(model: ObservableObject, atIndex index: Int)
    
    // Remove
    func removeAllModels()
    func removeModel(model: ObservableObject)
    func removeModelAtIndex(index: Int)
    
    // Move
    func moveModelAtIndex(index: Int, toIndex newIndex: Int)
    
    // Replace
    func replaceModel(model: ObservableObject, atIndex index: Int)
    
}

public class AbstractArrayModel : AbstractModel, AbstractArrayModelProtocol {

    public private(set) var array : [ObservableObject] = []
    
    let safeQueue = dispatch_queue_create("com.model.safeAccessThread", DISPATCH_QUEUE_SERIAL)
    
    public var count : Int {
        return self.array.count
    }
    
    public func addModel(model: ObservableObject) {
        
        dispatch_barrier_sync(safeQueue) { [unowned self] in
            self.array.append(model)
        }
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: [self.array.count-1])
        
    }

    public func addModels(models: [ObservableObject]) {
        
        objc_sync_enter(self.array)
        
        var indexs : [Int] = [Int]()
        
        for model in models {
            
            dispatch_barrier_sync(safeQueue) { [unowned self] in
                self.array.append(model)
            }
            indexs.append(self.array.count-1)
        }
        
        objc_sync_exit(self.array)
        
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: [self.array.count-1])
        // end
    }
    
    public func insertModels(models: [ObservableObject]) {
        
    }
    
    public func insertModel(model: ObservableObject, atIndex index: Int) {
        
    }
    
    // Remove
    public func removeAllModels() {
        
    }
    
    /**
     This method  bala bal bala
     
     - parameter model: Model need vla
     */
    public func removeModel(model: ObservableObject) {
        if self.array.count>0 {
            
            let selector = Selector("arrayModel:didRemoveElementsAtIndexs:")
            self.notifyObserversInMainThreadWithSelector(selector, andObject: [self.array.count-1])
        }
    }
    
    public func removeModelAtIndex(index: Int) {
        
    }
    
    // Move
    public func moveModelAtIndex(index: Int, toIndex newIndex: Int) {
        
    }
    
    // Replace
    public func replaceModel(model: ObservableObject, atIndex index: Int) {
        
    }
 
    
    
    
    
    
    
    
    

    /*
    //=======================================================
    public func addModel(model: AnyObject) {

        objc_sync_enter(self.mutableArray)
        
        self.mutableArray.addObject(model)
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: [self.mutableArray.count-1])
        
        
        objc_sync_exit(self.mutableArray)

    }
    
    
    //=======================================================
    /**
     Insert models after rest of the models
     
     - parameter models: new models
     */
    public func addModels(models: [AnyObject]) {
        
        objc_sync_enter(self.mutableArray)
        
        var indexs : [Int] = [Int]()

        for model in models {
            self.mutableArray.addObject(model)
            indexs.append(self.array.count-1)
        }
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)
        
        objc_sync_exit(self.mutableArray)
        
    }
    
    //=======================================================
    public func insertModel(model: AnyObject, atIndex index: Int) {
        objc_sync_enter(self.mutableArray)
        
        self.mutableArray.insertObject(model, atIndex: index)
        
        var indexs : [Int] = [Int]()
        
        indexs.append(index)
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)
        
        objc_sync_exit(self.mutableArray)
    }
    
    //=======================================================
    /**
     Insert models before all rest of the models
     - parameter models: New models
     */
    public func insertModels(models: [AnyObject]) {
        
        objc_sync_enter(self.mutableArray)
        
        let oldValues = NSArray(array: self.mutableArray)
        self.mutableArray.removeAllObjects()
        self.mutableArray.addObjectsFromArray(models)
        self.mutableArray.addObjectsFromArray(oldValues as [AnyObject])
        
        var indexs : [Int] = [Int]()
        for var i = 0; i < models.count; i++ {
            indexs.append(i)
        }
        
        let selector = Selector("arrayModel:didAddElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)
        
        objc_sync_exit(self.mutableArray)
    }
    
    //=======================================================
    public func removeAllModels() {
        objc_sync_enter(self.mutableArray)

        self.mutableArray.removeAllObjects()
        let selector = Selector("arrayModelDidChange:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: nil)
        
        objc_sync_exit(self.mutableArray)
    }
    
    //=======================================================
    
    public func removeModel(model: AnyObject) {
        objc_sync_enter(self.mutableArray)
        
        var indexs : [Int] = [Int]()
        indexs+=[self.mutableArray.indexOfObject(model)]
        self.mutableArray.removeObject(model)
        
        let selector = Selector("arrayModel:didRemoveElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)

        objc_sync_exit(self.mutableArray)
    }
    
    //=======================================================
    public func removeModelAtIndex(index: Int) {
        objc_sync_enter(self.mutableArray)
        
        self.mutableArray.removeObjectAtIndex(index)
        var indexs : [Int] = [Int]()
        indexs+=[index]
        let selector = Selector("arrayModel:didRemoveElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)

        objc_sync_exit(self.mutableArray)
    }
    
    //=======================================================
    public func moveModelAtIndex(index: Int, toIndex newIndex: Int) {
        objc_sync_enter(self.mutableArray)
        
        let model = self.mutableArray[index]
        self.mutableArray.removeObjectAtIndex(index)
        self.mutableArray.insertObject(model, atIndex: newIndex)
        
        var indexs : [Int] = [Int]()
        indexs+=[index, newIndex]

        let selector = Selector("arrayModel:didMoveElementAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: indexs)
        
        objc_sync_exit(self.mutableArray)
    }
    
    //=======================================================
    public func replaceModel(model: AnyObject, atIndex index: Int) {
        objc_sync_enter(self.mutableArray)
        
        self.mutableArray.replaceObjectAtIndex(index, withObject: model)
        let selector = Selector("arrayModel:didReplaceElementsAtIndexs:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: [index])
        
        objc_sync_exit(self.mutableArray)
    }
*/
    
}

