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


// MARK: - ====== AbstractCellDelegateProtocol ======
@objc public protocol AbstractCellDelegateProtocol  : class {
    @objc optional func needFocus(_ cell: UITableViewCell)
}

// MARK: - ====== Abstract Cell Protocol ======
public protocol AbstractCellProtocol {
    
    func fillWithViewModel(_ viewModel: AbstractViewModel?)
    weak var viewModel: AbstractViewModel? {get set}
    weak var delegat: AnyObject? {get set}
    
}





// MARK: - ====== Abstract TableView Cell Class ======
open class AbstractTableViewCell : UITableViewCell, AbstractCellProtocol, ObserverModelProtocol {
    
    open weak var delegat: AnyObject?
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
        self.needsFocus()
    }
    
    open func needsFocus() {
        if let cellDelegate = self.delegat {
            if (cellDelegate.responds(to: #selector(AbstractCellDelegateProtocol.needFocus(_:)))) {
                cellDelegate.perform(#selector(AbstractCellDelegateProtocol.needFocus(_:)),
                                     with: self)
            }
        }
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
    
    open weak var delegat: AnyObject?
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
