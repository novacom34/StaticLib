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
    
    @IBOutlet open var activityIndicator : UIActivityIndicatorView?
    @IBOutlet open var noDataLabel : UILabel?
    @IBOutlet open var noDataImage : UIImageView?
    
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
    
    open func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AbstractTableViewController.keyboardWillShown(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AbstractTableViewController.keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    open func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    open func keyboardWillShown(notification: NSNotification) {
        
    }
    
    open func keyboardWillHide(notification: NSNotification) {
        
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
open class AbstractTableViewController : AbstractViewController, AbstractCellDelegateProtocol ,UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Property Declaration
    @IBOutlet open weak var tableView: UITableView!
    
    // MARK: - UITableViewDataSource
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.modelArray?.count {
            
            if count>0 {
                
                self.noDataImage?.isHidden = true
                self.noDataLabel?.isHidden = true
                
            } else {
                
                self.noDataImage?.isHidden = false
                self.noDataLabel?.isHidden = false
            }
            
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
        
        cell?.delegat = self
        cell!.viewModel = viewModel
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - AbstractCellDelegateProtocol
    open func needFocus(_ cell: UITableViewCell) {
        
        if let indexPath = self.tableView.indexPath(for: cell) {
            self.tableView.scrollToRow(at: indexPath,
                                       at: UITableViewScrollPosition.top,
                                       animated: true)
        }
    }
    
    // MARK: - Keyboard
    open override func keyboardWillShown(notification: NSNotification) {
        var info = notification.userInfo
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            var contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0)
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
        }
    }
    
    open override func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = UIEdgeInsets.zero
        self.tableView.scrollIndicatorInsets = UIEdgeInsets.zero
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

