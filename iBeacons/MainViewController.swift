//
//  ViewController.swift
//  iBeacons
//
//  Created by Lance  on 8/13/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let locationService = LocationService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setEditing(false, animated: false)
        
        // set up beacons to monitor
        if (self.locationService.isBeaconCapable()) {
            self.locationService.setBeacons()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "info" {
            let vc = segue.destinationViewController as! InfoViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                vc.selectedRow = indexPath.row
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationService.beacons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.locationService.beacons[indexPath.row].identifier
        return cell
    }

}


