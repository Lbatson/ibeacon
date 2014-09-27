//
//  AppDelegate.swift
//  iBeacons
//
//  Created by Lance  on 8/13/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("8ZRnPK6TTi8p9uGrARtm0RvF1eAKgzciL18oASuF",clientKey:"44iTfaPyK7vU7GWviWY5Shehl6LyLYuzWJNFya68")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.runLocationChecks()
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func runLocationChecks() {
        if (LocationService.instance.isBeaconCapable()) {
            if (!LocationService.instance.isLocationPermitted()) {
                if (UIDevice.currentDevice().systemVersion as NSString).floatValue > 7.0 {
                    LocationService.instance.locationManager.requestAlwaysAuthorization()
                }
                var alert = UIAlertView(
                    title: "Unable to access location",
                    message: "Please enable location services in Settings > Privacy > Location Services for this app",
                    delegate: self,
                    cancelButtonTitle: "OK"
                )
                alert.show()
            }
        } else {
            var alert = UIAlertView(
                title: "Unable to monitor for iBeacons",
                message: "This device is unable to monitor regions for iBeacons",
                delegate: self,
                cancelButtonTitle: "OK"
            )
            alert.show()
        }
    }

}