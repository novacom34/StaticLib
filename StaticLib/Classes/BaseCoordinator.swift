//
//  BaseCoordinator.swift
//  Pods
//
//  Created by Roma Novakov on 30.05.16.
//
//

import Foundation
import UIKit

public class BaseCoordinator: Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    
    /**
     func start() must be overriden
     */
    public func start() {
        
    }
    
    // add only unique object
    public func addDependancy(coordinator: Coordinator) {
        
        for element in childCoordinators {
            if ObjectIdentifier(element) == ObjectIdentifier(coordinator) { return }
        }
        childCoordinators.append(coordinator)
    }
    
    public func removeDependancy(coordinator: Coordinator) {
        guard childCoordinators.isEmpty == false else { return }
        
        for (index, element) in childCoordinators.enumerate() {
            if ObjectIdentifier(element) == ObjectIdentifier(coordinator) {
                childCoordinators.removeAtIndex(index)
                break
            }
        }
    }
    
    public func removeAllDependancys() {
        childCoordinators.removeAll()
    }
    
}
