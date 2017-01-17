//
//  AbstractViewModel.swift
//  Pods
//
//  Created by Roma Novakov on 29.05.16.
//
//

import Foundation

open class AbstractViewModel : AbstractModel {
    
    public init(viewIdentifire: String, viewClassName: String) {
        super.init()
        
        self.viewIdentifire = viewIdentifire
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        self.viewClassName = "\(namespace).\(viewClassName)"
        
    }
    
    open var viewIdentifire : String!
    open var viewClassName : String!
    
}
