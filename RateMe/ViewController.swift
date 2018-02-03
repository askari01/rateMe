//
//  ViewController.swift
//  RateMe
//
//  Created by Syed Askari on 29/01/2018.
//  Copyright © 2018 Syed Askari. All rights reserved.
//

import UIKit
import StatusAlert
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var floatingRatingView: FloatRatingView!
    @IBOutlet weak var submitBtn: UIButton!
    
    var ref: DatabaseReference!
    
    var name: String!
    var receiptNumber: String!
    var rating: Double!
    var lat: Double!
    var lng: Double!
    var locality: String!
    var postalCode: String!
    var country: String!
    var timeStamp: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        floatingRatingView.delegate = self as? FloatRatingViewDelegate
        floatingRatingView.type = .halfRatings
        
        // must be called after reference for storing offline data
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitAction(_ sender: UIButton) {
        submitBtn.isEnabled = false
         //to store data in firebase database
        ref
            .child("\(self.receiptNumber!)")
            .setValue([
            "name": "\(self.name!)",
            "receiptNumber": "\(self.receiptNumber!)",
            "lat": "\(self.lat!)",
            "lng": "\(self.lng!)",
            "locality": "\(self.locality!)",
            "postalCode": "\(self.postalCode!)",
            "country": "\(self.country!)",
            "timeStamp": "\(self.timeStamp!)",
            "rating": self.rating])
        
        // Creating StatusAlert instance
        let statusAlert = StatusAlert.instantiate(withImage: UIImage(named: "checkmark"),
                                                  title: "Submitted",
                                                  message: "Thank You!",
                                                  canBePickedOrDismissed: false)
        // Presenting created instance
        statusAlert.showInKeyWindow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "newViewController") as? NewViewController
            self.present(newViewController!, animated: true, completion: nil)
        }
    }
}

extension ViewController: FloatRatingViewDelegate {
    // MARK: FloatRatingViewDelegate
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
//        print (String(format: "%.2f", self.floatingRatingView.rating))
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
//        print(String(format: "%.2f", self.floatingRatingView.rating))
        self.submitBtn.setTitleColor(UIColor(displayP3Red: 0.85, green: 0.00, blue: 0.15, alpha: 1.0) , for: .normal)
        self.submitBtn.isEnabled = true
        self.submitBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        self.rating = self.floatingRatingView.rating
    }
}
