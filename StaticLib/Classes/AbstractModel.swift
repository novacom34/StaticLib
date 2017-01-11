//
//  AbstractModel.swift
//  Pods
//
//  Created by Roma Novakov on 11.05.16.
//
//

import Foundation

//MARK: - ModelObserver Protocol
@objc public protocol ObserverModelProtocol : class {
    
    @objc optional func modelWillLoad(_ model: AbstractModel)
    @objc optional func modelDidLoad(_ model: AbstractModel)
    @objc optional func modelWillReload(_ model: AbstractModel)
    @objc optional func modelDidReload(_ model: AbstractModel)
    @objc optional func modelDidUnload(_ model: AbstractModel)
    @objc optional func modelDidCancel(_ model: AbstractModel)
    @objc optional func modelLoading(_ model: AbstractModel, withProgress progress: NSNumber)
    @objc optional func modelFailLoading(_ model: AbstractModel, withError error: NSString)
}

@objc public protocol ObservableModelProtocol : class{
    
    //===========================================================
    // ============ Method for change model state ===============
    func unload()                                   //  State.Unload
    func loading()                                  //  State.Loading
    func reloading()                                //  State.Reloading
    func reload()                                   //  State.Reload
    func loadingWithProgress(_ progress: NSNumber)  //  State.
    func load()                                     //  State.Loaded
    func canceled()                                 //  State.Canceled
    func failLoading(_ withError: NSString)         //  State.Failed
    //===========================================================
    
    
    // ================ Base Model Methods ======================
    @objc optional func performLoading()
    @objc optional func performLoadMore()
    @objc optional func performUnloading()
    @objc optional func performCanceled()
    //===========================================================
}


public enum State {
    case unloaded
    case loading
    case loaded
    case reload
    case reloading
    case failed
    case canceled
}


open class AbstractModel : ObservableObject, ObservableModelProtocol {

    private(set) var state: State = State.unloaded

    open func unload() {
        
        self.state = .unloaded
        self.notifyObserversInMainThreadWithSelector(#selector(ObserverModelProtocol.modelDidUnload(_:)), andObject: nil)
        
    }//  State.Unload
    
    open func loading() {
        
        self.state = .loading
        self.notifyObserversInMainThreadWithSelector(#selector(ObserverModelProtocol.modelWillLoad(_:)), andObject: nil)
        
    }//  State.Loading
    
    open func loadingWithProgress(_ progress: NSNumber) {
        self.notifyObserversInMainThreadWithSelector(#selector(ObserverModelProtocol.modelLoading(_:withProgress:)), andObject: progress)
        
    } // State.Loading
    
    open func load() {
        
        self.state = .loaded
        self.notifyObserversInMainThreadWithSelector(#selector(ObserverModelProtocol.modelDidLoad(_:)), andObject: nil)
        
    }//  State.Loaded
    
    open func reloading() {
        
        self.state = .reloading
        self.notifyObserversInMainThreadWithSelector(#selector(ObserverModelProtocol.modelWillReload(_:)), andObject: nil)
        
    }//  State.Reloading
    
    open func reload() {
    
        self.state = .reload
        self.notifyObserversInMainThreadWithSelector(#selector(ObserverModelProtocol.modelDidReload(_:)), andObject: nil)
        
    }//  State.Reload
    
    open func canceled() {
        
        self.state = .canceled
        self.notifyObserversInMainThreadWithSelector(#selector(ObserverModelProtocol.modelDidCancel(_:)), andObject: nil)
        
    }//  State.Canceled
    
    open func failLoading(_ withError: NSString) {
        
        self.state = .failed
        self.notifyObserversInMainThreadWithSelector(#selector(ObserverModelProtocol.modelFailLoading(_:withError:)),
            andObject: nil)
        
    }//  State.Failed
    
    
    open func performLoading() {
        
    }
    
    open func performLoadMore() {
        
    }
    
    open func performUnloading() {
        
    }
    
    open func performCanceled() {
        
    }
    
}


