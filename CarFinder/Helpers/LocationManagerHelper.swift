//
//  LocationManagerHelper.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 05/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol LocationManagerDelegate: class{
    func didUpdateLocation()
}

class LocationManagerHelper : NSObject, CLLocationManagerDelegate{
    static let sharedInstance: LocationManagerHelper = LocationManagerHelper()
    
    var locationManager: CLLocationManager?
    
    func startUpdatingLocation(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                locationManager?.startUpdatingLocation()
            }else{
                locationManager?.requestWhenInUseAuthorization()
            }
        }
    }

}
