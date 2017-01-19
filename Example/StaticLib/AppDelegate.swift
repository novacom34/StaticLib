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
    var abstractModel : AbstractModel = AbstractModel()
    var array : Array = [AnyObject]()
    
    let accessQueue = DispatchQueue(label: "com.novacom.thread", attributes: [])
    
//======================================= TEST ZONE ==========================================
//============================================================================================
//============================================================================================
    
    // MARK: - Model Observer Methods
    
    func modelWillLoad(_ model: AbstractModel) {
        print("ModelWillLoad")
    }
    
    func modelDidLoad(_ model: AbstractModel) {
        print("ModelDidLoad")
    }
    
    func modelFailLoading(_ model: AbstractModel, withError error: NSString) {
        print("ModelFailLoading")
    }
    
    func modelDidUnload(_ model: AbstractModel) {
        //print("=modelDidUnload: \(model) \n \(self)")
    }
    
    func modelLoading(_ model: AbstractModel, withProgress progress: NSNumber) {
        let floatValue = progress.floatValue
        print("floatValue: \(floatValue)")
    }
    
    // MARK: - Array Model Observer Methods
    
    func arrayModel(_ arrayModel: AbstractArrayModel, didAddElementsAtIndexs indexs: Array<Any>) {
        
        print("Add elements with count: \(arrayModel.array.count)")
    }
    
    func arrayModel(_ arrayModel: AbstractArrayModel, didMoveElementAtIndexs indexs: Array<Any>)
    {
        print("Move elements with idxs: \(indexs)")
    }
    
    func arrayModel(_ arrayModel: AbstractArrayModel, didRemoveElementsAtIndexs indexs: Array<Any>) {
        print("Remove elements count: \(arrayModel.array.count)")
    }
    
    
    
//======================================= TEST ZONE ==========================================
//============================================================================================
//============================================================================================
    
    
    // MARK: - Implementation
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        //self.arrayModel.registerObserver(self)
        
        self.accessQueue.async {
            //self.abstractModel.loading()
        }
        
        
        
        self.arrayModel.registerObserver(self)
        //self.observebl.registerObserver(self)
        
        let obs1 = AbstractModel()
        let obs2 = AbstractModel()
        let obs3 = AbstractModel()
        
        self.arrayModel.addModel(obs1)
        
        print("===========================")
        print("\(self.arrayModel.array)")
        
        
        self.accessQueue.async {

            //self.observebl.loading()
            
//            self.arrayModel.addModel(obs1)
            //self.arrayModel.addModels([obs2])
            //self.arrayModel.addModels([obs3])
            
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
        

        
        
        
//        print(self.arrayModel.array)
//        self.arrayModel.moveModelAtIndex(0, toIndex: 1)
//        print(self.arrayModel.array)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

