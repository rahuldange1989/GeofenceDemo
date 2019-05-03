//
//  GeofenceModel.swift
//  GeofenceDemo
//
//  Created by Rahul Dange on 5/3/19.
//  Copyright © 2019 Rahul Dange. All rights reserved.
//

import UIKit
import MapKit

class GeofenceModel: NSObject, Codable, MKAnnotation {
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, radius, note
    }
    
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var note: String
    
    var title: String? {
        if note.isEmpty {
            return "No Note"
        }
        return note
    }
    
    var subtitle: String? {
        return "Radius: \(radius)m"
    }
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, note: String) {
        self.coordinate = coordinate
        self.radius = radius
        self.note = note
    }
    
    // MARK: Codable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        radius = try values.decode(Double.self, forKey: .radius)
        note = try values.decode(String.self, forKey: .note)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(radius, forKey: .radius)
        try container.encode(note, forKey: .note)
    }
    
    public class func getSavedGeofenceModel() -> GeofenceModel? {
        guard let savedData = UserDefaults.standard.data(forKey: AppConstants.SAVED_GEOFENCE_KEY) else { return nil }
        let decoder = JSONDecoder()
        if let savedGeofence = try? decoder.decode(GeofenceModel.self, from: savedData) as GeofenceModel {
            return savedGeofence
        }
        return nil
    }
}
