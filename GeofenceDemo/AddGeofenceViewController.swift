//
//  AddGeofenceViewController.swift
//  GeofenceDemo
//
//  Created by Rahul Dange on 5/3/19.
//  Copyright © 2019 Rahul Dange. All rights reserved.
//

import UIKit

class AddGeofenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Event Handler Methods -
    @IBAction func saveNewGeofence(_ sender: Any) {
    }
    
    @IBAction func cancelAddGeofenceAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
