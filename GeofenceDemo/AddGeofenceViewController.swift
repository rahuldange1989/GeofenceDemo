//
//  AddGeofenceViewController.swift
//  GeofenceDemo
//
//  Created by Rahul Dange on 5/3/19.
//  Copyright © 2019 Rahul Dange. All rights reserved.
//

import UIKit
import MapKit

protocol AddGeofenceDelegate {
    func addGeofence(coordinate: CLLocationCoordinate2D, radius: Double, note: String)
}

class AddGeofenceViewController: UITableViewController {

    @IBOutlet weak var radiusField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    var delegate: AddGeofenceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBtn.isEnabled = false
    }
    
    // MARK: - Event Handler Methods -
    @IBAction func saveNewGeofence(_ sender: Any) {
        if delegate != nil {
            let coordinate = mapView.centerCoordinate
            let radius = Double(radiusField.text!) ?? 100
            let note = noteField.text ?? ""
            
            delegate?.addGeofence(coordinate: coordinate, radius: radius, note: note)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelAddGeofenceAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func zoomToCurrentLocation(_ sender: Any) {
        mapView.zoomToUserLocation()
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        addBtn.isEnabled = !radiusField.text!.isEmpty && !noteField.text!.isEmpty
    }
}

// -- MARK: - UITextfield Delegate Methods -
extension AddGeofenceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
