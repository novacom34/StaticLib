//
//  AbstractArrayModel.swift
//  Pods
//
//  Created by Roma Novakov on 19.05.16.
//
//

import Foundation

// MARK: - ObserverArrayModelProtocol
@objc public protocol ObserverArrayModelProtocol : class {
    
    @objc optional func arrayModelDidChange(_ arrayModel: AbstractArrayModel)
    @objc optional func arrayModel(_ arrayModel: AbstractArrayModel, didAddElementsAtIndexs indexs: NSArray)
    @objc optional func arrayModel(_ arrayModel: AbstractArrayModel, didRemoveElementsAtIndexs indexs: NSArray)
    @objc optional func arrayModel(_ arrayModel: AbstractArrayModel, didReplaceElementAtIndex index: NSIndexPath)
    @objc optional func arrayModel(_ arrayModel: AbstractArrayModel, didMoveElementAtIndexs indexs: NSArray)
}


// MARK: - AbstractArrayModelProtocol
public protocol AbstractArrayModelProtocol {
    
    // Add
    func addModel(_ model: AnyObject)
    func addModels(_ models: [AnyObject])
    func insertModels(_ models: [AnyObject])
    func insertModel(_ model: AnyObject, atIndex index: Int)
    
    // Remove
    func removeAllModels()
    func removeModel(_ model: AnyObject)
    func removeModelAtIndex(_ index: Int)
    
    // Move
    func moveModelAtIndex(_ index: Int, toIndex newIndex: Int)
    
    // Replace
    func replaceModel(_ model: AnyObject, atIndex index: Int)
}


// MARK: - AbstractArrayModel
open class AbstractArrayModel : AbstractModel, AbstractArrayModelProtocol {
    
    open var count : Int {
        let arrayCopy = mutableArray.copy() as! NSArray
        return arrayCopy.count
    }
    
    // Public
    open var array : NSArray  {
        get {
            return mutableArray.copy() as! NSArray
        }
    }
    
    // Private
    private var mutableArray : NSMutableArray = NSMutableArray()
    
    open func addModel(_ model: AnyObject) {
        self.safeQueue.sync(flags: .barrier, execute: { [unowned self] in
            self.mutableArray.add(model)
            let indexPath = NSIndexPath(row: self.mutableArray.count-1, section: 0)
            let selector = #selector(ObserverArrayModelProtocol.arrayModel(_:didAddElementsAtIndexs:))
            self.notifyObserversInMainThreadWithSelector(selector, andObject: NSArray(object: indexPath))
        })
    }

    
    // ===================================================================
    // MARK: - Add
    // ===================================================================
    
    open func addModels(_ models: [AnyObject]) {
        
        self.safeQueue.sync(flags: .barrier, execute: { [unowned self] in
    
            let beforeCount = self.mutableArray.count
            self.mutableArray.addObjects(from: models)
            let afterCount = self.mutableArray.count
            
            var mutableIndexPaths : [AnyObject] = []
            
            for index in beforeCount...afterCount-1 {
                 let indexPath = NSIndexPath(row: index, section: 0)
                mutableIndexPaths.append(indexPath)
            }

            let indexArray = NSArray(array: mutableIndexPaths)
            let selector = #selector(ObserverArrayModelProtocol.arrayModel(_:didAddElementsAtIndexs:))
            self.notifyObserversInMainThreadWithSelector(selector, andObject: indexArray)
        })
    }
    
    open func insertModel(_ model: AnyObject, atIndex index: Int) {
        
        safeQueue.sync(flags: .barrier, execute: { [unowned self] in
            
            self.mutableArray.insert(model, at: index)
            let indexPath = NSIndexPath(row: index, section: 0)
            let selector = #selector(ObserverArrayModelProtocol.arrayModel(_:didAddElementsAtIndexs:))
            self.notifyObserversInMainThreadWithSelector(selector, andObject: NSArray(object: indexPath))
        })
    }
    
    open func insertModels(_ models: [AnyObject]) {
        
        safeQueue.sync(flags: .barrier, execute: { [unowned self] in
            
            var oldArray = self.mutableArray.copy() as! NSArray
            self.mutableArray.removeAllObjects()
            self.mutableArray.addObjects(from: models)
            
            var mutableIndexPaths : [AnyObject] = []
            
            for index in 0 ..< self.mutableArray.count {
                let indexPath = NSIndexPath(row: index, section: 0)
                mutableIndexPaths.append(indexPath)
            }

            let indexArray = NSArray(array: mutableIndexPaths)
            let selector = #selector(ObserverArrayModelProtocol.arrayModel(_:didAddElementsAtIndexs:))
            self.notifyObserversInMainThreadWithSelector(selector, andObject: indexArray)
        })
    }
    
    
    // ======================================================================
    // MARK: - Remove
    // ======================================================================
    
    open func removeAllModels() {
        
        safeQueue.sync(flags: .barrier, execute: { [unowned self] in
    
            self.mutableArray.removeAllObjects()
            let selector = #selector(ObserverArrayModelProtocol.arrayModelDidChange(_:))
            self.notifyObserversInMainThreadWithSelector(selector, andObject: nil)
        })
    }
    
    open func removeModel(_ model: AnyObject) {
        
        safeQueue.sync(flags: .barrier, execute: { [unowned self] in
            
            let modelIndex = self.mutableArray.index(of: model)
            self.mutableArray.remove(model)
            let indexPath = NSIndexPath(row: modelIndex, section: 0)
            
            let selector = #selector(ObserverArrayModelProtocol.arrayModel(_:didRemoveElementsAtIndexs:))
            self.notifyObserversInMainThreadWithSelector(selector, andObject: NSArray(object: indexPath))
        })
    }
    
    open func removeModelAtIndex(_ index: Int) {
        
        safeQueue.sync(flags: .barrier, execute: { [unowned self] in
            
            if index<self.mutableArray.count
            {
                self.mutableArray.removeObject(at: index)
                let indexPath = NSIndexPath(row: index, section: 0)
                let selector = #selector(ObserverArrayModelProtocol.arrayModel(_:didRemoveElementsAtIndexs:))
                self.notifyObserversInMainThreadWithSelector(selector, andObject: NSArray(object: indexPath))
            }
        })
    }

    
    // ======================================================================
    // MARK: - Move
    // ======================================================================
    
    open func moveModelAtIndex(_ index: Int, toIndex newIndex: Int) {
        
        safeQueue.sync(flags: .barrier, execute: { [unowned self] in
            
            if index<self.mutableArray.count && newIndex<self.mutableArray.count
            {
                let model = self.mutableArray[index]
                self.mutableArray.removeObject(at: index)
                self.mutableArray.insert(model, at: newIndex)
                
                let oldIndexPath = NSIndexPath(row: index, section: 0)
                let newIndexPath = NSIndexPath(row: newIndex, section: 0)
                
                let selector = #selector(ObserverArrayModelProtocol.arrayModel(_:didMoveElementAtIndexs:))
                self.notifyObserversInMainThreadWithSelector(selector, andObject: NSArray(array: [oldIndexPath, newIndexPath]))
            }
        })
    }

    
    // ======================================================================
    // MARK: - Replace
    // ======================================================================
    
    open func replaceModel(_ model: AnyObject, atIndex index: Int) {
        
        safeQueue.sync(flags: .barrier, execute: { [unowned self] in
        
            if index<self.mutableArray.count
            {
                self.mutableArray.replaceObject(at: index, with: model)
                let selector = #selector(ObserverArrayModelProtocol.arrayModel(_:didReplaceElementAtIndex:))
                self.notifyObserversInMainThreadWithSelector(selector, andObject: NSIndexPath(index: index))
            }
        })
    }
}

//=============================================================================================================
//=============================================================================================================


