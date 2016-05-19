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
    
    optional func modelWillLoad(model: AbstractModel)
    optional func modelDidLoad(model: AbstractModel)
    optional func modelWillReload(model: AbstractModel)
    optional func modelDidReload(model: AbstractModel)
    optional func modelDidUnload(model: AbstractModel)
    optional func modelDidCancel(model: AbstractModel)
    optional func modelLoading(model: AbstractModel, withProgress progress: NSNumber)
    optional func modelFailLoading(model: AbstractModel, withError error: NSError)
    
}

@objc public protocol ObservableModelProtocol : class{
    
    //===========================================================
    // ============ Method for change model state ===============
    
    func unload()                              //  State.Unload
    func loading()                             //  State.Loading
    func reloading()                           //  State.Reloading
    func reload()                              //  State.Reload
    func loadingWithProgress(progress: NSNumber)
    func load()                                //  State.Loaded
    func canceled()                            //  State.Canceled
    func failLoading(withError: NSError)       //  State.Failed
    //===========================================================
    //===========================================================
    
    
    //===========================================================
    // ================ Base Model Methods ======================
    
    optional func performLoading()
    optional func performUnloading()
    optional func performCanceled()
    
    //===========================================================
    //===========================================================
    
}

public enum State {
    case Unloaded
    case Loading
    case Loaded
    case Reload
    case Reloading
    case Failed
    case Canceled
}


public class AbstractModel : ObservableObject {

    private(set) var state: State = State.Unloaded

    public func unload() {
        
        self.state = .Unloaded
        self.notifyObserversInMainThreadWithSelector(Selector("modelDidUnload:"), andObject: nil)
        
    }//  State.Unload
    
    public func loading() {
        
        self.state = .Loading
        self.notifyObserversInMainThreadWithSelector(Selector("modelWillLoad:"), andObject: nil)
        
    }//  State.Loading
    
    public func loadingWithProgress(progress: NSNumber) {

        self.notifyObserversInMainThreadWithSelector(Selector("modelLoading:withProgress:"), andObject: progress)
        
    } // State.Loading
    
    public func load() {
        
        self.state = .Loaded
        self.notifyObserversInMainThreadWithSelector(Selector("modelDidLoad:"), andObject: nil)
        
    }//  State.Loaded
    
    public func reloading() {
        
        self.state = .Reloading
        self.notifyObserversInMainThreadWithSelector(Selector("modelWillReload:"), andObject: nil)
        
    }//  State.Reloading
    
    public func reload() {
    
        self.state = .Reload
        self.notifyObserversInMainThreadWithSelector(Selector("modelDidReload:"), andObject: nil)
        
    }//  State.Reload
    
    public func canceled() {
        
        self.state = .Canceled
        self.notifyObserversInMainThreadWithSelector(Selector("modelDidCancel:"), andObject: nil)
        
    }//  State.Canceled
    
    public func failLoading(withError: NSError) {
        
        self.state = .Failed
        self.notifyObserversInMainThreadWithSelector(Selector(
            "modelFailLoading:withError:"),
            andObject: nil)
        
    }//  State.Failed
    
    /*
    public func performLoading() {
        
    }
    
    public func performUnloading() {
        
    }
    
    public func performCanceled() {
        
    }
    */
}


