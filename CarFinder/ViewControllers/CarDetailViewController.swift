//
//  CarDetailViewController.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 05/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

class CarDetailViewController : UIViewController{
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var series: UILabel!
    @IBOutlet weak var fueltype: UILabel!
    @IBOutlet weak var fuelLevel: UILabel!
    @IBOutlet weak var transmission: UILabel!
    @IBOutlet weak var licensePlate: UILabel!
    @IBOutlet weak var cleanliness: UILabel!
    @IBOutlet weak var colorView: UIView!{
        didSet{
            colorView.layer.cornerRadius = 5
            colorView.layer.masksToBounds = true
        }
    }
    
    var car : Car? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let car = self.car{
            setUpDetail(with: car)
        }
    }
    
    private func setUpDetail(with car: Car){
        CarHelper.imageForCar(car: car) { (image) in
            self.carImage.image = image
        }
        
        series.text = car.series
        fueltype.text = car.fuelTypeName()
        fuelLevel.text = car.fuelLevelPercentage()
        transmission.text = car.transmissionName()
        licensePlate.text = car.licensePlate
        cleanliness.text = car.cleanliness()
        colorView.backgroundColor = car.carColor()
    }
    
}
