//
//  NewViewController.swift
//  RateMe
//
//  Created by Syed Askari on 30/01/2018.
//  Copyright © 2018 Syed Askari. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseStorage
import FirebaseDatabase

class NewViewController: UIViewController  {

    var locationManager: CLLocationManager!
    var geoCoder: CLGeocoder!
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        geoCoder = CLGeocoder()
        ref = Database.database().reference()
        self.location()
        
        let data = DataModel.init(name: "test", receiptNumber: "test123", rating: 2)
        
        // to get data from firebase database
        ref.child("rate").observe(DataEventType.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            print (value)
        }
        
        // to store data in firebase database
//        ref.child("rate").setValue(["name":"test", "receiptNumber":"test321","rating":2])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            #if debug
                println("Location services are not enabled");
            #endif
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        print(coord.latitude)
        print(coord.longitude)

        CLGeocoder().reverseGeocodeLocation(locationObj) {(placemarks, error) in
            if (error != nil) {
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
        if ((error) != nil)
        {
            print(error)
        }
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        if placemark != nil {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            print (placemark.locality)
            print (placemark.postalCode)
            print (placemark.administrativeArea)
            print (placemark.country)
            print (placemark.location?.timestamp)
            print (placemark.name)
            print (placemark.timeZone)
        }
    }
    
}
