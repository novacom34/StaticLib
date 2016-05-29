//
//  AbstractCell.swift
//  Pods
//
//  Created by Roma Novakov on 29.05.16.
//
//

import Foundation


/*
 @property (weak, nonatomic) id delegate;
 
 @property (strong, nonatomic) VMBase *viewModel;
 
 -(void)fillWithModel:(VMBase *)viewModel;
 */

// MARK: - ====== Abstract Cell Protocol ======
public protocol AbstractCellProtocol {
    
    func fillWithViewModel(viewModel: AbstractViewModel)
    weak var viewModel: AbstractViewModel? {get set}
    weak var delegat: NSObject? {get set}
    
}



// MARK: - ====== Abstract TableView Cell Class ======
public class AbstractTableViewCell : UITableViewCell, AbstractCellProtocol, ObserverModelProtocol {
    
    public weak var delegat: NSObject?
    public weak var viewModel: AbstractViewModel?{
        didSet {
            oldValue?.unregisterObserver(self)
            viewModel?.registerObserver(self)
        }
    }
    
    // MARK: Abstract Cell Protocol Methods
    public func fillWithViewModel(viewModel: AbstractViewModel) {
        
    }
    
    // MARK: Observer Model Methods
    
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
    
}



// MARK: - ====== Abstract CollectionView Cell Class ======
public class AbstractCollectionViewCell : UICollectionViewCell, AbstractCellProtocol, ObserverModelProtocol{
    
    public weak var delegat: NSObject?
    public weak var viewModel: AbstractViewModel?{
        didSet {
            oldValue?.unregisterObserver(self)
            viewModel?.registerObserver(self)
        }
    }
    
    
    public func fillWithViewModel(viewModel: AbstractViewModel) {
        
    }
    
    // MARK: Observer Model Methods
    
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
    
}
