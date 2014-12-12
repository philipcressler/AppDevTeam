//
//  AppDelegate.swift
//  fs2014
//
//  Created by Philip Cressler on 10/21/14.
//  Copyright (c) 2014 Philip Cressler. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var healthStore:HealthKitHandler = HealthKitHandler()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //************* Notifications and background Fetch setup ****************
    
        //enable local notifications
        let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        //set minimum background fetch interval to minimal value
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        //setup healthstore
        healthStore = HealthKitHandler()
        healthStore.setupHealthStoreIfPossible()
        
        //************ Check if Journey is selected ************//
        if let userData = NSUserDefaults.standardUserDefaults().objectForKey("data") as? NSData {
            return true
        }else{
            self.window = UIWindow(frame:UIScreen.mainScreen().bounds)
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var initialViewController = storyboard.instantiateViewControllerWithIdentifier("pickerView") as UIViewController
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setObject(false, forKey: "weeklyNotifications")
            defaults.setObject("Miles", forKey: "units")
            defaults.setObject(true, forKey: "landmarkNotifications")
            
            defaults.synchronize()
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.healthStore.timeOfAppTermination = NSDate()
        
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
    
   func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        println("performing background fetch")
        completionHandler(UIBackgroundFetchResult.NewData)
        self.healthStore.backgroundFetch(self.healthStore.timeOfAppTermination!)
        println("end of background fetch")
    
    }
    
    


}

