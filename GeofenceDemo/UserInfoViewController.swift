//
//  UserInfoViewController.swift
//  GeofenceDemo
//
//  Created by Rahul Dange on 5/2/19.
//  Copyright © 2019 Rahul Dange. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class UserInfoViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var geofenceModel: GeofenceModel?
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.checkForUserLocation()
        self.loadGeofence()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGeofence" {
            let navigationController = segue.destination as! UINavigationController
            let vc = navigationController.viewControllers.first as! AddGeofenceViewController
            vc.delegate = self
        }
    }
    
    // MARK: - Internal Methdos -
    func checkForUserLocation() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func loadGeofence() {
        if let geofence = GeofenceModel.getSavedGeofenceModel() {
            geofenceModel = geofence
            mapView.addAnnotation(geofenceModel!)
            mapView.addOverlay(MKCircle(center: geofenceModel?.coordinate ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0), radius: geofenceModel?.radius ?? 100))
        }
        
    }
    
    func saveGeofence() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self.geofenceModel)
            UserDefaults.standard.set(data, forKey: AppConstants.SAVED_GEOFENCE_KEY)
        } catch {
            print(">>> error encoding Geofence Model")
        }
    }
}

// -- Add Geofence Delegate Methdos
extension UserInfoViewController: AddGeofenceDelegate {
    func addGeofence(coordinate: CLLocationCoordinate2D, radius: Double, note: String) {
        self.geofenceModel = GeofenceModel.init(coordinate: coordinate, radius: radius, note: note)
        self.saveGeofence()
        self.loadGeofence()
    }
}

