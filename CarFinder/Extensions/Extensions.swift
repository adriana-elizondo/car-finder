//
//  Extensions.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 05/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

extension Car {
    func cleanliness() -> String{
        return self.innerCleanliness.replacingOccurrences(of: "_", with: " ").lowercased()
    }
    
    func cleanlinessImage() -> UIImage?{
        switch self.innerCleanliness {
        case "VERY_CLEAN":
            return UIImage.init(named: "very_clean")
        case "CLEAN":
            return UIImage.init(named: "clean")
        case "REGULAR":
            return UIImage.init(named: "regular")
        default:
            return UIImage.init(named: "not_clean")
        }
    }
    
    func transmissionName() -> String{
        switch self.transmission {
        case "M":
            return "manual"
        case "A":
            return "automatic"
            
        default:
            return "unknown"
        }
    }
    
    func fuelTypeName() -> String{
        switch self.fuelType {
        case "P":
            return "petrol"
        case "D":
            return "diesel"
        case "E":
            return "electric"
        default:
            return "unknown"
        }
    }
    
    func fuelLevelPercentage() -> String{
        return String("\(self.fuelLevel * 100) %")
    }
    
    func carColor() -> UIColor{
        switch self.color {
        case "midnight_black":
            return UIColor.init(colorLiteralRed: 12/255, green: 12/255, blue: 12/255, alpha: 1.0)
        case "hot_chocolate":
            return UIColor.init(colorLiteralRed: 74/255, green: 59/255, blue: 48/255, alpha: 1.0)
        case "midnight_black_metal":
            return UIColor.init(colorLiteralRed: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)
        case "light_white":
            return UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        case "iced_chocolate":
            return UIColor.init(colorLiteralRed: 99/255, green: 81/255, blue: 68/255, alpha: 1.0)
        case "alpinweiss":
            return UIColor.init(colorLiteralRed: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
        case "saphirschwarz":
            return UIColor.init(colorLiteralRed: 10/255, green: 10/255, blue: 10/255, alpha: 1.0)
        case "iced_chocolate_metal":
            return UIColor.init(colorLiteralRed: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)
        default:
            return UIColor.white
        }
    }
    
    
}
