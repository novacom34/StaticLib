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
class AppDelegate: UIResponder, UIApplicationDelegate, ObserverModelProtocol, ArrayModelObserver {

    var window: UIWindow?

    func modelWillLoad(model: AbstractModel) {
        print("=ModelWillLoad: \(model) \n \(self)")
    }
    
    func modelFailLoading(model: AbstractModel, withError error: NSError) {
        print("=ModelWillLoad: \(model) \n \(self)")
    }
    
    func modelDidUnload(model: AbstractModel) {
        //print("=modelDidUnload: \(model) \n \(self)")
    }
    
    func modelLoading(model: AbstractModel, withProgress progress: NSNumber) {
        let floatValue = progress.floatValue
        print("floatValue: \(floatValue)")
    }

    func arrayModel(arrayModel: AbstractArrayModel, didAddElementsAtIndexs indexs: [Int]) {
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let observebl : AbstractModel = AbstractModel()
        
        
        let arrayModel = AbstractArrayModel()
        
        arrayModel.registerObserver(self)
        
        arrayModel.addModel(observebl)
        arrayModel.addModel(observebl)
        arrayModel.addModel(observebl)
        
//        //for i in 1...100_000 {
//        let observebl : AbstractModel = AbstractModel()
//        observebl.registerObserver(self)
//        observebl.unload()
//        observebl.loadingWithProgress(NSNumber(float: 0.4))
//        observebl.unregisterObserver(self)
//        //}
//        
//        print("End")
        
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

