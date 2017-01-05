//
//  CarAnnotation.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 05/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CarAnnotation : NSObject, MKAnnotation{
    var car = Car()
    
    var coordinate: CLLocationCoordinate2D{
        get{
            return CLLocationCoordinate2D.init(latitude: car.latitude, longitude: car.longitude)
        }
    }
    
    var title: String?{
        get{
            return car.name
        }
    }
    
    var carId: String{
        get{
            return car.id
        }
    }
    
    init(with car: Car) {
        self.car = car
    }
}
