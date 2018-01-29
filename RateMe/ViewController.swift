//
//  ViewController.swift
//  RateMe
//
//  Created by Syed Askari on 29/01/2018.
//  Copyright © 2018 Syed Askari. All rights reserved.
//

import UIKit
import StatusAlert

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitAction(_ sender: UIButton) {
        // Creating StatusAlert instance
        let statusAlert = StatusAlert.instantiate(withImage: UIImage(named: "checkmark"),
                                                  title: "Submitted",
                                                  message: "",
                                                  canBePickedOrDismissed: false)
        
        // Presenting created instance
        statusAlert.showInKeyWindow()
    }
    
}

