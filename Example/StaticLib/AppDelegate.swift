//
//  AppDelegate.swift
//  StaticLib
//
//  Created by Roma Novakov on 05/09/2016.
//  Copyright (c) 2016 Roma Novakov. All rights reserved.
//

import UIKit
import StaticLib

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ObserverModelProtocol, ObserverArrayModelProtocol {

    var window: UIWindow?

    var arrayModel: AbstractArrayModel = AbstractArrayModel()
    var observebl : AbstractModel = AbstractModel()
    var array : Array = [AnyObject]()
    
    let accessQueue = dispatch_queue_create("com.novacom.thread", DISPATCH_QUEUE_SERIAL)
//======================================= TEST ZONE ==========================================
//============================================================================================
//============================================================================================
    
    // MARK: - Model Observer Methods
    
    func modelWillLoad(model: AbstractModel) {
        print("ModelWillLoad")
    }
    
    func modelDidLoad(model: AbstractModel) {
        print("ModelDidLoad")
    }
    
    func modelFailLoading(model: AbstractModel, withError error: NSError) {
        print("ModelFailLoading")
    }
    
    func modelDidUnload(model: AbstractModel) {
        //print("=modelDidUnload: \(model) \n \(self)")
    }
    
    func modelLoading(model: AbstractModel, withProgress progress: NSNumber) {
        let floatValue = progress.floatValue
        print("floatValue: \(floatValue)")
    }
    
    // MARK: - Array Model Observer Methods
    
    func arrayModel(arrayModel: AbstractArrayModel, didAddElementsAtIndexs indexs: [Int]) {
        print("Add elements with count: \(arrayModel.array.count)")
    }
    
    func arrayModel(arrayModel: AbstractArrayModel,
                    didMoveElementAtIndexs indexs: [Int])
    {
        print("Move elements with idxs: \(indexs)")
    }
    
    func arrayModel(arrayModel: AbstractArrayModel, didRemoveElementsAtIndexs indexs: [Int]) {
        print("Remove elements count: \(arrayModel.array.count)")
    }
    
    
    
//======================================= TEST ZONE ==========================================
//============================================================================================
//============================================================================================
    
    
    // MARK: - Implementation
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.arrayModel.registerObserver(self)
        self.observebl.registerObserver(self)
        
        let obs1 = AbstractModel()
        let obs2 = ObservableObject()
        let obs3 = AbstractModel()
        
        dispatch_async(self.accessQueue) {

            self.arrayModel.addModel(obs1)
            self.arrayModel.addModels([obs2])
            self.arrayModel.addModels([obs3])
            
        }
        
        
//        for i in 0...20 {
//            
//            let newQueue = dispatch_queue_create("com.novacom.test.thread\(i)", DISPATCH_QUEUE_SERIAL)
//            self.array+=[newQueue]
//            
//            dispatch_async(newQueue) { [unowned self] in
//                let obs = AbstractModel()
//                self.arrayModel.addModel(obs)
//            }
//            print(i)
//        }
//        
        
        
        /*
        func addModel(model: AnyObject)
        func addModels(models: [AnyObject])
        func insertModels(models: [AnyObject])
        func insertModel(model: AnyObject, atIndex index: Int)
        
        // Remove
        func removeAllModels()
        func removeModel(model: AnyObject)
        func removeModelAtIndex(index: Int)
        
        // Move
        func moveModelAtIndex(index: Int, toIndex newIndex: Int)
        
        // Replace
        func replaceModel(model: AnyObject, atIndex index: Int)
        */
        
        
        
        
//        print(self.arrayModel.array)
//        self.arrayModel.moveModelAtIndex(0, toIndex: 1)
//        print(self.arrayModel.array)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

