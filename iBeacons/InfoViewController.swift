//
//  InfoViewController.swift
//  iBeacons
//
//  Created by Lance  on 9/4/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    var info = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = info
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
