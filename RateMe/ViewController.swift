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

    @IBOutlet weak var floatingRatingView: FloatRatingView!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        floatingRatingView.delegate = self as? FloatRatingViewDelegate
        floatingRatingView.type = .halfRatings
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
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "newViewController") as! NewViewController
        self.present(newViewController, animated: true, completion: nil)
        
    }
}

extension ViewController: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        print (String(format: "%.2f", self.floatingRatingView.rating))
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        print(String(format: "%.2f", self.floatingRatingView.rating))
        self.submitBtn.setTitleColor(UIColor(displayP3Red: 0.85, green: 0.00, blue: 0.15, alpha: 1.0) , for: .normal)
        self.submitBtn.isEnabled = true
        self.submitBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
    }
    
}

