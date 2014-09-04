//
//  ViewController.swift
//  iBeacons
//
//  Created by Lance  on 8/13/14.
//  Copyright (c) 2014 AppCensus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var uuidTextField: UITextField!
    @IBOutlet weak var getInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uuidTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        uuidTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func getInfo(sender: UIButton) {
        if (countElements(uuidTextField.text) > 0) {
            uuidTextField.resignFirstResponder()
            self.performSegueWithIdentifier("info", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "info" {
            let infoVC = segue.destinationViewController as InfoViewController
            infoVC.info = uuidTextField.text
        }
    }
    
}
