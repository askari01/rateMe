//
//  NewViewController.swift
//  RateMe
//
//  Created by Syed Askari on 30/01/2018.
//  Copyright © 2018 Syed Askari. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase

class NewViewController: UIViewController  {

    var locationManager: CLLocationManager!
    var geoCoder: CLGeocoder!
    var ref: DatabaseReference!

    @IBOutlet weak var receiptNumber: UITextField!
    
    var name: String!
    var lat: Double!
    var lng: Double!
    var locality: String!
    var postalCode: String!
    var country: String!
    var timeStamp: String!
    var alert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        geoCoder = CLGeocoder()
        alert = UIAlertController()

        ref = Database.database().reference()
//        self.location()
        
        _ = DataModel.init(name: "test", receiptNumber: "test123", rating: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.location()
    }
    
    func createSettingsAlertController(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment:"" ), style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment:"" ), style: .default, handler: { action in
            UIApplication.shared.canOpenURL(URL(string: UIApplicationOpenSettingsURLString)!)
        })
//        controller.addAction(cancelAction)
        controller.addAction(settingsAction)
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func location() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                // Request when-in-use authorization initially
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted, .denied:
                // Disable location features
                createSettingsAlertController(title: "Issue", message: "Please allow location access to the app")
                break
            case .authorizedWhenInUse:
                // Enable basic location features
                break
            case .authorizedAlways:
                // Enable any of your app's location features
                break
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        } else {
                print("Location services are not enabled")
                createSettingsAlertController(title: "Issue", message: "Please enable location from settings")
        }
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        if (receiptNumber.text?.isEmpty)! {
            receiptNumber.shake()
            return
        }
        
        guard let lat2 = lat else {
            locationManager.startUpdatingLocation()
            return
        }
        
        // to get data from firebase database
        ref
            .child("\(receiptNumber.text!)")
            .observe(DataEventType.value)
            { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let receipt = value?.value(forKeyPath: "receiptNumber") as? String
                if self.receiptNumber.text! != receipt {
                    self.performSegue(withIdentifier: "showRating", sender: self)
                } else {
                    print ("already exists")
                    self.receiptNumber.shake()
                }
        }
    }
    
    // MARK: - Navigation
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRating" {
            let vc: ViewController = segue.destination as! ViewController // swiftlint:disable:this force_cast
            vc.name = name
            vc.receiptNumber = receiptNumber.text!
            vc.lat = lat
            vc.lng = lng
            vc.locality = locality
            vc.postalCode = postalCode
            vc.country = country
            vc.timeStamp = timeStamp
        }
    }
}

extension NewViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation // swiftlint:disable:this force_cast
        let coord = locationObj.coordinate

        lat = coord.latitude
        lng = coord.longitude
        CLGeocoder().reverseGeocodeLocation(locationObj) {(placemarks, error) in
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                self.displayLocationInfo(placemark: pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        if error != nil{
            print("Error: " + error.localizedDescription)
            self.createSettingsAlertController(title: "Issue", message: "Enable location from settings and check for app permissions")
        }
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        if placemark != nil {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            if let name1 = placemark.name {
                name = name1
            } else {
                name = "couldn't get name"
            }
            if let locality1 = placemark.locality {
                locality = locality1
            } else {
                locality = "couldn't get locality"
            }
            if let postalCode1 = placemark.postalCode {
                postalCode = postalCode1
            } else {
                postalCode = "couldn't get postalCode"
            }
            if let country1 = placemark.country {
                country = country1
            } else {
                country = "couldn't get country"
            }
            timeStamp = String(describing: placemark.location?.timestamp)
        }
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-7.0, 7.0, -7.0, 7.0, -5.0, 5.0, -2.0, 2.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
