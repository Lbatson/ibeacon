//
//  InfoViewController.swift
//  iBeacons
//
//  Created by Lance  on 9/4/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var beacon: Beacon!
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uuidLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        uuidLabel.numberOfLines = 2
        uuidLabel.text = beacon.uuid.UUIDString
        identifierLabel.text = beacon.identifier
        majorLabel.text = String(beacon.major)
        minorLabel.text = String(beacon.minor)
        var beaconEvent = PFObject(className:"Event")
        beaconEvent["uuid"] = beacon.uuid.UUIDString
        beaconEvent["identifier"] = beacon.identifier
        beaconEvent["major"] = Double(beacon.major)
        beaconEvent["minor"] = Double(beacon.minor)
        beaconEvent.saveInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}
