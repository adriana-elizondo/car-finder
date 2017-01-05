//
//  CarHelper.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 04/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit
import Haneke

class CarHelper{
    
    static func getCarsFromServer(with completion: @escaping (_ result: Any?, _ error : Error?) -> Void){
        NetworkHelper.getDataWithUrl(stringUrl: "cars.json") { (success, response, error) in
            if success, let results = (response as? [Any]){
                completion(carListFromJson(jsonArray: results), nil)
            }else{
                print("Error \(error)")
                completion(nil, error)
            }
        }
    }
    
    static func carListFromJson(jsonArray: [Any]?) -> [Car]{
        var carList = [Car]()
        guard jsonArray != nil else {return carList}
        
        for json in jsonArray!{
            if let currentCar = json as? [String : Any],
                let car = Car(JSON: currentCar){
                carList.append(car)
            }
        }
        return carList
    }
    
    static func imageForCar(car: Car, completion: @escaping (_ image: UIImage) -> Void){
        let carImageUrl = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(car.modelIdentifier)/\(car.color)/2x/car.png"
        
        print("\(carImageUrl)")
        if let url = URL.init(string: carImageUrl){
            Shared.imageCache.fetch(URL: url).onSuccess({ (image) in
                completion(image)
            })
        }
    }
    
    static func carsNearMeNow(carList : [Car], longitude: Double, latitude: Double, range : Double) -> [CarAnnotation]{
        return carList.filter { (abs($0.longitude) - abs(longitude)) < range && (abs($0.latitude) - abs(latitude)) < range}.map{CarAnnotation.init(with: $0)}
    }
}
