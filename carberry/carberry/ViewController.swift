//
//  ViewController.swift
//  carberry
//
//  Created by Roman Mykitchak on 13/10/2018.
//  Copyright © 2018 Roman Mykitchak. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var carTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func send(_ sender: UIButton) {
        //self.carberry()
        self.getCar(userCar:self.carTextField.text!)
    }
    
    func carberry() {
        var gameScore = PFObject(className:"Car")
        gameScore["name"] = "Seat Leon"
        gameScore["petrol"] = "A95"
        gameScore.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                // The object has been saved.
                let alert = UIAlertController(title: "Alert", message: "Car added to database", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                // There was a problem, check error.description
                let alert = UIAlertController(title: "Alert", message: "Adding car error", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getCar(userCar:String) {
        var query = PFQuery(className: "Car")
        do {
            //let car = try query.getObjectWithId("Pf1zzM0L1D")
            query.whereKey("name", equalTo: userCar)
            let cars = try query.findObjects()
            let car = cars.first!
            let carName:String = car["name"] as! String
            let carPetrol:String = car["petrol"] as! String
            let carConsumption = (car["consumption"] as! NSNumber)
            let alert = UIAlertController(title: "Alert", message: "Car got " + carName + " " + carPetrol + " \(carConsumption)", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "GO", style: UIAlertAction.Style.default, handler: { (action) in
                self.performSegue(withIdentifier: "showMap", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
            
        } catch {
            let alert = UIAlertController(title: "Alert", message: "Getting car error", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
//    func getPetrolAndPrice() {
//        var query = PFQuery(className:"Car")
//        query.whereKey("name", equalTo:"Audi")
////        query.findObjectsInBackground
//        query.findObjectsInBackground {
//            (objects: [PFObject]?, error: NSError?) -> Void in
//
//            if error == nil {
//                // The find succeeded.
//                print("Successfully retrieved \(objects!.count) scores.")
//                // Do something with the found objects
//                if let objects = objects {
//                    for object in objects {
//                        print(object.objectId)
//                    }
//                }
//            } else {
//                // Log details of the failure
//                print("Error: \(error!) \(error!.userInfo)")
//            }
//        } as! PFQueryArrayResultBlock
//    }
}

