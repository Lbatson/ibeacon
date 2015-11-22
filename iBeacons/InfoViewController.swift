//
//  InfoViewController.swift
//  iBeacons
//
//  Created by Lance  on 9/4/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    let locationService = LocationService.instance
    var selectedRow: Int = 0
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let beacon = LocationService.instance.beacons[selectedRow]
        uuidLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        uuidLabel.numberOfLines = 2
        uuidLabel.text = beacon.proximityUUID.UUIDString
        identifierLabel.text = beacon.identifier
        majorLabel.text = String(beacon.major!.intValue)
        minorLabel.text = String(beacon.minor!.intValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}
