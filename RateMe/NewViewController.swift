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

class NewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        let storage = Storage.storage()
        print ("storage: /(storage)")
        let reference = storage.reference()
        print ("storage: /(reference)")
        
        let data = DataModel.init(name: "test", receiptNumber: "test123", rating: 2)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try? encoder.encode(data)
        
        print (jsonData)
        
        reference.child("rate").putData(jsonData!)
        ref.child("rate").setValue(["name":"test", "receiptNumber":"test321","rating":2])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
