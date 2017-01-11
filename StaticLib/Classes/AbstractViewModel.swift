//
//  AbstractViewModel.swift
//  Pods
//
//  Created by Roma Novakov on 29.05.16.
//
//

import Foundation


open class AbstractViewModel : AbstractModel {
    
    open var viewIdentifire : String  {
        get {
            return "identifire"
        }
    }
    
    open var viewClassName : String  {
        get {
            return "className"
        }
    }
    
}
