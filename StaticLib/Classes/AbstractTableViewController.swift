//
//  AbstractTableViewController.swift
//  Pods
//
//  Created by Roma Novakov on 28.05.16.
//
//

import Foundation


public class AbstractTableViewController : AbstractViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Property Declaration
    @IBOutlet public var tableView: UITableView!
    
    
    // MARK: - UITableViewDataSource
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.modelArray?.count {
            return count
        }
        return 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    
    // MARK: - Observer Array Model Methods
    
    override public func arrayModelDidChange(arrayModel: AbstractArrayModel) {
        
    }
    
    override public func arrayModel(arrayModel: AbstractArrayModel,
                    didAddElementsAtIndexs indexs: [Int]) {
        
    }
    
    override public func arrayModel(arrayModel: AbstractArrayModel,
                    didRemoveElementsAtIndexs indexs: [Int]) {
        
    }
    
    override public func arrayModel(arrayModel: AbstractArrayModel,
                    didReplaceElementsAtIndexs indexs: [Int]) {
        
    }
    
    override public func arrayModel(arrayModel: AbstractArrayModel,
                    didMoveElementAtIndexs indexs: [Int]) {
        
    }
    
}


