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
    
    func fillWithViewModel(_ viewModel: AbstractViewModel?)
    weak var viewModel: AbstractViewModel? {get set}
    weak var delegat: NSObject? {get set}
    
}



// MARK: - ====== Abstract TableView Cell Class ======
open class AbstractTableViewCell : UITableViewCell, AbstractCellProtocol, ObserverModelProtocol {
    
    open weak var delegat: NSObject?
    open weak var viewModel: AbstractViewModel?{
        didSet {
            oldValue?.unregisterObserver(self)
            viewModel?.registerObserver(self)
            self.fillWithViewModel(viewModel)
        }
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewModel = nil
    }
    
    // MARK: Abstract Cell Protocol Methods
    open func fillWithViewModel(_ viewModel: AbstractViewModel?) {
        
    }
    
    // MARK: Observer Model Methods
    
    open func modelWillLoad(_ model: AbstractModel) {
        
    }
    
    open func modelDidLoad(_ model: AbstractModel) {
        
    }
    
    open func modelWillReload(_ model: AbstractModel) {
        
    }
    
    open func modelDidReload(_ model: AbstractModel) {
        
    }
    
    open func modelDidUnload(_ model: AbstractModel) {
        
    }
    
    open func modelDidCancel(_ model: AbstractModel) {
        
    }
    
    open func modelLoading(_ model: AbstractModel, withProgress progress: NSNumber) {
        
    }
    
    open func modelFailLoading(_ model: AbstractModel, withError error: NSString) {
        
    }
    
}



// MARK: - ====== Abstract CollectionView Cell Class ======
open class AbstractCollectionViewCell : UICollectionViewCell, AbstractCellProtocol, ObserverModelProtocol{
    
    open weak var delegat: NSObject?
    open weak var viewModel: AbstractViewModel? {
        didSet {
            oldValue?.unregisterObserver(self)
            viewModel?.registerObserver(self)
            self.fillWithViewModel(viewModel)
        }
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
    }
    
    open func fillWithViewModel(_ viewModel: AbstractViewModel?) {
        
    }
    
    // MARK: Observer Model Methods
    
    open func modelWillLoad(_ model: AbstractModel) {
        
    }
    
    open func modelDidLoad(_ model: AbstractModel) {
        
    }
    
    open func modelWillReload(_ model: AbstractModel) {
        
    }
    
    open func modelDidReload(_ model: AbstractModel) {
        
    }
    
    open func modelDidUnload(_ model: AbstractModel) {
        
    }
    
    open func modelDidCancel(_ model: AbstractModel) {
        
    }
    
    open func modelLoading(_ model: AbstractModel, withProgress progress: NSNumber) {
        
    }
    
    open func modelFailLoading(_ model: AbstractModel, withError error: NSString) {
        
    }
    
}
