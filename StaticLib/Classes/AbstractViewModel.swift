//
//  AbstractViewModel.swift
//  Pods
//
//  Created by Roma Novakov on 29.05.16.
//
//

import Foundation

/*
 Required childe init method
override init() {
    super.init()
    
    self.viewIdentifire = "cell_test"
    self.viewClassName = "TestCell"
}
*/

open class AbstractViewModel : AbstractModel {
    
    open var viewIdentifire : String!
    open var viewClassName : String! {
        set {
            self.className = newValue
        }
        
        get {
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
            return "\(namespace).\(className!)"
        }
    }
    
    private var className: String!
    
}
