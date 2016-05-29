//
//  AbstractTableViewController.swift
//  Pods
//
//  Created by Roma Novakov on 28.05.16.
//
//

import Foundation


class AbstractTableViewController : AbstractViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Property Declaration
    @IBOutlet var tableView: UITableView!
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.modelArray?.count {
            return count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    
    // MARK: - Observer Array Model Methods
    
    override func arrayModelDidChange(arrayModel: AbstractArrayModel) {
        
    }
    
    override func arrayModel(arrayModel: AbstractArrayModel,
                    didAddElementsAtIndexs indexs: [Int]) {
        
    }
    
    override func arrayModel(arrayModel: AbstractArrayModel,
                    didRemoveElementsAtIndexs indexs: [Int]) {
        
    }
    
    override func arrayModel(arrayModel: AbstractArrayModel,
                    didReplaceElementsAtIndexs indexs: [Int]) {
        
    }
    
    override func arrayModel(arrayModel: AbstractArrayModel,
                    didMoveElementAtIndexs indexs: [Int]) {
        
    }
    
}


