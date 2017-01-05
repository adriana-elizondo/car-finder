//
//  CarTableViewCell.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 04/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

protocol CarCellDelegate : class {
    func showOnMap(car: Car?)
}

class CarTableViewCell : UITableViewCell{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var make: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var fuelType: UILabel!
    @IBOutlet weak var fuelProgressView: UIProgressView!
    @IBOutlet weak var transmissionType: UILabel!
    @IBOutlet weak var cleanliness: UILabel!
    @IBOutlet weak var cleanlinessImage: UIImageView!
    
    var car : Car?
    weak var delegate : CarCellDelegate?
    
    func setUpCellWithCar(car: Car){
        name.text = car.name
        modelName.text = car.modelName
        make.text = car.make
        fuelType.text = car.fuelType
        fuelProgressView.progress = Float(car.fuelLevel)
        transmissionType.text = car.transmissionName()
        cleanliness.text = car.cleanliness()
        cleanlinessImage.image = car.cleanlinessImage()
        
        CarHelper.imageForCar(car: car) { (image) in
            self.carImageView.image = image
        }
        self.car = car
    }
    
    @IBAction func viewOnMap(_ sender: Any) {
        delegate?.showOnMap(car: self.car)
    }
}
