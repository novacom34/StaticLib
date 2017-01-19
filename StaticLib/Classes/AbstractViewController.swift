//
//  AbstractViewController.swift
//  Pods
//
//  Created by Roma Novakov on 27.05.16.
//
//

import Foundation



// ===================================================================
// MARK: - AbstractViewController
// ===================================================================
open class AbstractViewController : UIViewController, ObserverModelProtocol, ObserverArrayModelProtocol {
    
    @IBOutlet var activityIndicator : UIActivityIndicatorView?
    @IBOutlet var noDataLabel : UILabel?
    @IBOutlet var noDataImage : UIImageView?
    
    open var modelArray : AbstractArrayModel? {
        didSet {
            oldValue?.unregisterObserver(self)
            modelArray?.registerObserver(self)
        }
    }
    
    open var model : AbstractModel? {
        didSet {
            oldValue?.unregisterObserver(self)
            model?.registerObserver(self)
        }
    }
    
    // MARK: - Life cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Observer Model Methods
    
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
    
    
    // MARK: - Observer Array Model Methods
    
    open func arrayModelDidChange(_ arrayModel: AbstractArrayModel) {
        
    }
    
    open func arrayModel(_ arrayModel: AbstractArrayModel, didAddElementsAtIndexs indexs: [IndexPath])
    {
        
    }
    
    open func arrayModel(_ arrayModel: AbstractArrayModel, didRemoveElementsAtIndexs indexs: [IndexPath])
    {
        
    }
    
    open func arrayModel(_ arrayModel: AbstractArrayModel, didReplaceElementAtIndex index: IndexPath)
    {
        
    }
    
    open func arrayModel(_ arrayModel: AbstractArrayModel, didMoveElementAtIndexs indexs: [IndexPath])
    {
        
    }
}









// =====================================================================================
// MARK: - AbstractTableViewController
// =====================================================================================
open class AbstractTableViewController : AbstractViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Property Declaration
    @IBOutlet open var tableView: UITableView!
    
    
    
    
    // MARK: - UITableViewDataSource
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.modelArray?.count {
            self.noDataImage?.isHidden = true
            self.noDataLabel?.isHidden = true
            
            return count
        } else {
            self.noDataImage?.isHidden = false
            self.noDataLabel?.isHidden = false
            
            return 0
        }
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel: AbstractViewModel = self.modelArray?.array.object(at: indexPath.row) as! AbstractViewModel
        
        var cell: AbstractTableViewCell? = tableView.dequeueReusableCell(withIdentifier: viewModel.viewIdentifire) as! AbstractTableViewCell?
        
        if cell == nil {
            let aClass: AnyClass? = NSClassFromString(viewModel.viewClassName)
            tableView.register(aClass, forCellReuseIdentifier: viewModel.viewIdentifire)
            cell = tableView.dequeueReusableCell(withIdentifier: viewModel.viewIdentifire) as! AbstractTableViewCell?
        }
        
        cell!.viewModel = viewModel
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Observer Array Model Methods
    
    override open func arrayModelDidChange(_ arrayModel: AbstractArrayModel)
    {
        self.tableView.reloadData()
    }

    
    override open func arrayModel(_ arrayModel: AbstractArrayModel, didAddElementsAtIndexs indexs: [IndexPath]) {
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexs, with:  UITableViewRowAnimation.right)
        self.tableView.endUpdates()
        
    }
    
    override open func arrayModel(_ arrayModel: AbstractArrayModel, didRemoveElementsAtIndexs indexs: [IndexPath])
    {
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: indexs, with: UITableViewRowAnimation.right)
        self.tableView.endUpdates()
    }
    
    override open func arrayModel(_ arrayModel: AbstractArrayModel, didReplaceElementAtIndex index: IndexPath)
    {
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [index], with: .none)
        self.tableView.endUpdates()
    }
    
    override open func arrayModel(_ arrayModel: AbstractArrayModel, didMoveElementAtIndexs indexs: [IndexPath])
    {
        
        let atIndexPath = indexs[0]
        let toIndexPath = indexs[1]
        
        self.tableView.beginUpdates()
        self.tableView.moveRow(at: atIndexPath, to: toIndexPath)
        self.tableView.endUpdates()
    }
}


// ==========================================================================================
// MARK: - AbstractCollectionViewController
// ==========================================================================================

open class AbstractCollectionViewController : AbstractViewController {
    
    
    
}

