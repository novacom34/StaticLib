//
//  AbstractViewController.swift
//  Pods
//
//  Created by Roma Novakov on 27.05.16.
//
//

import Foundation

public class AbstractViewController : UIViewController, ObserverModelProtocol, ObserverArrayModelProtocol {
    
    public var modelArray : AbstractArrayModel? {
        didSet {
            oldValue?.unregisterObserver(self)
            modelArray?.registerObserver(self)
        }
    }
    
    public var model : AbstractModel? {
        didSet {
            oldValue?.unregisterObserver(self)
            model?.registerObserver(self)
        }
    }
    
    
    // MARK: - Life cycle
    override public func viewDidLoad() {
        
  
    }
    
    // MARK: - Observer Model Methods
    
    public func modelWillLoad(model: AbstractModel) {
        
    }
    
    public func modelDidLoad(model: AbstractModel) {
        
    }
    
    public func modelWillReload(model: AbstractModel) {
        
    }
    
    public func modelDidReload(model: AbstractModel) {
        
    }
    
    public func modelDidUnload(model: AbstractModel) {
        
    }
    
    public func modelDidCancel(model: AbstractModel) {
        
    }
    
    public func modelLoading(model: AbstractModel, withProgress progress: NSNumber) {
        
    }
    
    public func modelFailLoading(model: AbstractModel, withError error: NSError) {
        
    }
    
    // MARK: - Observer Array Model Methods
    
    public func arrayModelDidChange(arrayModel: AbstractArrayModel) {
        
    }
    
    public func arrayModel(arrayModel: AbstractArrayModel,
                    didAddElementsAtIndexs indexs: [Int]) {
        
    }
    
    public func arrayModel(arrayModel: AbstractArrayModel,
                    didRemoveElementsAtIndexs indexs: [Int]) {
        
    }
    
    public func arrayModel(arrayModel: AbstractArrayModel,
                    didReplaceElementsAtIndexs indexs: [Int]) {
        
    }
    
    public func arrayModel(arrayModel: AbstractArrayModel,
                    didMoveElementAtIndexs indexs: [Int]) {
        
    }
    
}





//@property (strong, nonatomic) SCArrayModelParent *modelArray;
//@property (strong, nonatomic) SCModelParent      *model;



