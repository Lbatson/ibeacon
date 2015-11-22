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
    let notificationCenter = NSNotificationCenter.defaultCenter()
    var beacons: [CLBeaconRegion]
    
    class var instance: LocationService {
        struct Singleton {
            static let instance = LocationService()
        }
        return Singleton.instance
    }
    
    override init() {
        self.beacons = Array()
        super.init()
        locationManager.delegate = self
        
        guard isBeaconCapable() else {
            notificationCenter.postNotificationName("Beacon_Unsupported", object: nil)
            return
        }
    }
    
    func isBeaconCapable() -> Bool {
        // check to insure device has capability to look for iBeacons
        return CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion)
    }
    
    func setBeacons() {
        let config = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!)
        let regions = config!.objectForKey("regions") as! [NSDictionary]
        
        for region in regions {
            let uuid = region.objectForKey("uuid") as! String
            let identifier = region.objectForKey("identifier") as! String
            let major = CLBeaconMajorValue(region.objectForKey("major") as! Int)
            let minor = CLBeaconMinorValue(region.objectForKey("minor") as! Int)
            let beacon = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: uuid)!, major: major, minor: minor, identifier: identifier)
            self.beacons.append(beacon)
        }
    }
    
    func startMonitoringBeacons() {
        for beacon in self.beacons {
            beacon.notifyEntryStateOnDisplay = true
            locationManager.startMonitoringForRegion(beacon)
            locationManager.startRangingBeaconsInRegion(beacon)
        }
    }
    
    func stopMonitoringBeacons() {
        for beacon in self.beacons {
            locationManager.stopMonitoringForRegion(beacon)
            locationManager.stopRangingBeaconsInRegion(beacon)
        }
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    // called when location permission status is updated
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var statusMessage = "N/A"
        
        switch status {
        case .AuthorizedAlways:
            statusMessage = "Authorized Always"
            self.startMonitoringBeacons()
        case .AuthorizedWhenInUse:
            statusMessage = "Authorized When In Use"
            self.startMonitoringBeacons()
        case .NotDetermined:
            statusMessage = "Not Determined"
            self.stopMonitoringBeacons()
            locationManager.requestAlwaysAuthorization()
        case .Restricted:
            statusMessage = "Restricted"
            self.stopMonitoringBeacons()
            notificationCenter.postNotificationName("Location_Restricted", object: nil)
        case .Denied:
            statusMessage = "Denied"
            self.stopMonitoringBeacons()
            notificationCenter.postNotificationName("Location_Denied", object: nil)
        }
        
        print("status changed to \(statusMessage)")
    }
    
    // called when device encounters registered region
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered region \(region.description)")
    }
    
    // called when device leaves registered region
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exited region \(region.description)")
    }
    
    // called when ranging becons in a specified region
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        print("ranging for beacons \(beacons) in region \(region)")
    }
    
}