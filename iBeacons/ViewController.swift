//
//  ViewController.swift
//  iBeacons
//
//  Created by Lance  on 8/13/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = LocationService.instance.locationManager
    let config = NSDictionary(
        contentsOfFile: NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!
    )
    let uuidRegex = NSRegularExpression(
        pattern: "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$",
        options: nil,
        error: nil
    )
    
    @IBOutlet weak var uuidTextField: UITextField!
    @IBOutlet weak var getInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uuidTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // load info view and set data
        if segue.identifier == "info" {
            let infoVC = segue.destinationViewController as InfoViewController
            infoVC.info = uuidTextField.text
        }
    }
    
    @IBAction func getInfo(sender: UIButton) {
        // check to insure device has capability to look for iBeacons
        if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion) == true {
            locationManager.startUpdatingLocation() // start location or prompt for access
            // check to make sure permissions are valid to use location info
            if CLLocationManager.locationServicesEnabled() &&
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized {
                self.startMonitoring()
            } else {
                if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied {
                    var alert = UIAlertView(
                        title: "Unable to access location",
                        message: "Please enable location services in Settings > Privacy > Location Services for this app",
                        delegate: self,
                        cancelButtonTitle: "OK"
                    )
                    alert.show()
                }
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
    
    func startMonitoring() {
        uuidTextField.resignFirstResponder()
        var uuid = config.objectForKey("uuid") as String
        var identifier = config.objectForKey("identifier") as String
        // use default data unless uuid is entered
        if (countElements(uuidTextField.text) > 0) {
            // check if input is a valid uuid
            let match = uuidRegex.numberOfMatchesInString(
                uuidTextField.text,
                options: nil,
                range: NSRange(location: 0, length: countElements(uuidTextField.text))
            )
            if match > 0 {
                uuid = uuidTextField.text
            } else {
                var alert = UIAlertView(
                    title: "Invalid UUID",
                    message: "Please enter a valid UUID to search",
                    delegate: self,
                    cancelButtonTitle: "OK"
                )
                alert.show()
            }
        }
        // begin monitoring for ibeacon
        let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: uuid), identifier: identifier)
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }

}

extension ViewController: UITextFieldDelegate {
    
    // enable return key to dismiss keyboard
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        uuidTextField.resignFirstResponder()
        return true
    }
    
}
