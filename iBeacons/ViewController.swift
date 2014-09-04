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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        uuidTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func getInfo(sender: UIButton) {
        uuidTextField.resignFirstResponder()
        if (countElements(uuidTextField.text) > 0) {
            println(uuidTextField.text)
//            TODO: set up infoviewcontroller
//            self.performSegueWithIdentifier("info", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "info" {
//            TODO: set data in infoviewcontroller
        }
    }
}

