//
//  BeaconRegion.swift
//  iBeacons
//
//  Created by Lance  on 9/11/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import Foundation
import CoreLocation

class Beacon {
    
    var uuid: NSUUID
    var identifier: String
    var major: CLBeaconMajorValue
    var minor: CLBeaconMinorValue
    
    init(uuid: NSUUID, identifier: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {
        self.uuid = uuid
        self.identifier = identifier
        self.major = major
        self.minor = minor
    }
    
    func send2Parse(beacon: Beacon!){
        var beaconEvent = PFObject(className:"Event")
        beaconEvent["uuid"] = beacon.uuid.UUIDString
        beaconEvent["identifier"] = beacon.identifier
        beaconEvent["major"] = Double(beacon.major)
        beaconEvent["minor"] = Double(beacon.minor)
        beaconEvent.saveInBackground()

    }
    
}