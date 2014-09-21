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
    var beacons: [Beacon]
    
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
    }
    
    func isBeaconCapable() -> Bool {
        // check to insure device has capability to look for iBeacons
        return CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion)
    }
    
    func isLocationPermitted() -> Bool {
        // check to make sure permissions are valid to use location info
        return CLLocationManager.locationServicesEnabled() &&
            (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse)
    }
    
    func setBeacons() {
        self.beacons = Array()
        let config = NSDictionary(
            contentsOfFile: NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!
        )
        var uuid = config.objectForKey("uuid") as String
        var identifier = config.objectForKey("identifier") as String
        var major = CLBeaconMajorValue(config.objectForKey("major") as Int)
        var minor = CLBeaconMinorValue(config.objectForKey("minor") as Int)
        let beacon = Beacon(uuid: NSUUID(UUIDString: uuid), identifier: identifier, major: major, minor: minor)
        self.beacons.append(beacon)
    }
    
    func startMonitoringBeacons() {
        for beacon in self.beacons {
            let beaconRegion = CLBeaconRegion(proximityUUID: beacon.uuid, identifier: beacon.identifier)
            beaconRegion.notifyEntryStateOnDisplay = true
            locationManager.startMonitoringForRegion(beaconRegion)
            locationManager.startRangingBeaconsInRegion(beaconRegion)
        }
    }
    
    func stopMonitoringBeacons() {
        for beacon in self.beacons {
            let beaconRegion = CLBeaconRegion(proximityUUID: beacon.uuid, identifier: beacon.identifier)
            locationManager.stopMonitoringForRegion(beaconRegion)
            locationManager.stopRangingBeaconsInRegion(beaconRegion)
            
        }
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    // called when location permission status is updated
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var statusMessage = "N/A"
        
        switch status {
        case .Authorized:
            statusMessage = "Authorized"
            self.startMonitoringBeacons()
        case .AuthorizedWhenInUse:
            statusMessage = "Authorized When In Use"
            self.startMonitoringBeacons()
        case .NotDetermined:
            statusMessage = "Not Determined"
            self.stopMonitoringBeacons()
        case .Restricted:
            statusMessage = "Restricted"
            self.stopMonitoringBeacons()
        case .Denied:
            statusMessage = "Denied"
            self.stopMonitoringBeacons()
        default:
            break;
        }
        
        println("status changed to \(statusMessage)")
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