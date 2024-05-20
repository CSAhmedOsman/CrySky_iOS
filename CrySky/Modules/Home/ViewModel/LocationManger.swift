//
//  LocationManger.swift
//  CrySky
//
//  Created by Mac on 20/05/2024.
//

import Foundation
import CoreLocation

class LocationManager : NSObject , ObservableObject, CLLocationManagerDelegate {
    @Published var location : CLLocation?
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.allowsBackgroundLocationUpdates = false
        self.locationManager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            self.location = location
        }
    }
}
