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
     func modelDidLoad(model: AbstractModel)
     optional func modelDidUnload(model: AbstractModel)
     optional func modelDidCancel(model: AbstractModel)
     optional func modelLoading(model: AbstractModel, withProgress progress: NSNumber)
     optional func modelFailLoading(model: AbstractModel, withError error: NSError)
    
}

protocol ObservableModelProtocol {
    
    //===========================================================
    // ============ Method for change model state ===============
    
    func unload()                              //  State.Unload
    func loading()                             //  State.Loading
    func loadingWithProgress(progress: NSNumber)
    func load()                                //  State.Loaded
    func canceled()                            //  State.Canceled
    func failloading(withError: NSError)       //  State.Failed
    //===========================================================
    //===========================================================
    
    
    //===========================================================
    // ================ Base Model Methods ======================
    
    func performLoading()
    func performUnloading()
    func performCanceled()
    
    //===========================================================
    //===========================================================
    
}

public enum State {
    case Unloaded
    case Loading
    case Loaded
    case Failed
    case Canceled
}

public class AbstractModel : ObservableObject, ObservableModelProtocol {

    private(set) var state: State = State.Unloaded

    func unload() {
        
        self.state = .Unloaded
        let selector = Selector("modelDidUnload")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: nil)
        
    }//  State.Unload
    
    func loading() {
        
        self.state = .Loading
        let selector = Selector("modelWillLoad")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: nil)
        
    }//  State.Loading
    
    func loadingWithProgress(progress: NSNumber) {

        let selector = Selector("modelLoading:withError:")
        self.notifyObserversInMainThreadWithSelector(selector, andObject: progress)
        
    }
    
    func load() {
        
    }//  State.Loaded
    
    func canceled() {
        
    }//  State.Canceled
    
    func failloading(withError: NSError) {
        
    }//  State.Failed
    
    
    
}


