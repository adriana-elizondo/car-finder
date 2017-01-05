//
//  Car.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 04/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import ObjectMapper


/*
 Current car model from server
 "id": "WMWSW31030T222518",
 "modelIdentifier": "mini",
 "modelName": "MINI",
 "name": "Vanessa",
 "make": "BMW",
 "group": "MINI",
 "color": "midnight_black",
 "series": "MINI",
 "fuelType": "D",
 "fuelLevel": 0.7,
 "transmission": "M",
 "licensePlate": "M-VO0259",
 "latitude": 48.134557,
 "longitude": 11.576921,
 "innerCleanliness": "REGULAR",
 "carImageUrl": "https://de.drive-now.com/static/drivenow/img/cars/mini.png"
 */

class Car : Mappable{
    dynamic var id = ""
    dynamic var modelIdentifier = ""
    dynamic var modelName = ""
    dynamic var name = ""
    dynamic var make = ""
    dynamic var group = ""
    dynamic var color = ""
    dynamic var series = ""
    dynamic var fuelType = ""
    dynamic var fuelLevel = 0.0
    dynamic var transmission = ""
    dynamic var licensePlate = ""
    dynamic var latitude = 0.0
    dynamic var longitude = 0.0
    dynamic var innerCleanliness = ""
    dynamic var carImageUrl = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        modelIdentifier <- map["modelIdentifier"]
        modelName <- map["modelName"]
        name <- map["name"]
        make <- map["make"]
        group <- map["group"]
        color <- map["color"]
        series <- map["series"]
        fuelType <- map["fuelType"]
        fuelLevel <- map["fuelLevel"]
        transmission <- map["transmission"]
        licensePlate <- map["licensePlate"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        innerCleanliness <- map["innerCleanliness"]
        carImageUrl <- map["carImageUrl"]
    }

 }
