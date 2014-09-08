//
//  LocationService.swift
//  iBeacons
//
//  Created by Lance  on 9/7/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: CLLocationManager {
    
    let locationManager = CLLocationManager()
    
    class var instance: LocationService {
        struct Singleton {
            static let instance = LocationService()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    // called when location permission status is updated
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("status changed to \(status.toRaw())")
    }
    
    // called when device encounters registered region
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("entered region \(region.description)")
    }
    
    // called when device leaves registered region
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("exited region \(region.description)")
    }
    
    // called when ranging becons in a specified region
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println("ranging for beacons \(beacons) in region \(region)")
    }
    
}