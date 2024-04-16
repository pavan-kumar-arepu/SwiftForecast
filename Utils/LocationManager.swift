//
//  LocationManager.swift
//  WeatherKitApp
//
//  Created by Arepu Pavan Kumar on 2024-04-16.
//


import Foundation
import CoreLocation

/**
 A manager responsible for handling location-related operations and obtaining the user's current location.
 
 The `LocationManager` class is used to manage location services and obtain the user's current location. It adopts the `CLLocationManagerDelegate` protocol to receive updates on location authorization status and location changes.
 
 # Usage
 Initialize an instance of `LocationManager` to start obtaining the user's location. The manager automatically requests authorization from the user and starts updating the location when initialized.
 
 # Example
 let locationManager = LocationManager()

 - Author:   ArepuPavanKumar
 */

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
    }
}
