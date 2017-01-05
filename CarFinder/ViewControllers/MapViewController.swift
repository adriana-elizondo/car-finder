//
//  MapViewController.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 04/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import MapKit

class MapViewController : UIViewController{
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.showsUserLocation = true
            mapView.delegate = self
        }
    }
    
    fileprivate var currentLocation: MKUserLocation?{
        didSet{
            guard specificCar == nil && !didUpdateWithInitialLocation else {return}
            showCarsNearMe()
        }
    }
    
    fileprivate var didUpdateWithInitialLocation = false
    
    //Set by previous controller
    var specificCar : Car? = nil{
        didSet{
            guard specificCar != nil else {return}
            showCarOnMap(car: specificCar!)
        }
    }
    var carList : [Car]? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationManagerHelper.sharedInstance.startUpdatingLocation()
    }
    
    @IBAction func refreshCarsNearMe(_ sender: Any) {
        guard carList == nil else {
            showCarsNearMe()
            return
        }
        
        CarHelper.getCarsFromServer { (response, error) in
            DispatchQueue.main.async {
                if let cars = response as? [Car]{
                    self.carList = cars
                    self.showCarsNearMe()
                }else{
                    let alert = UIAlertController.init(title: "Error", message: "Could not load available cars. Please try again later", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }

    }
    
}

extension MapViewController{
    
    fileprivate func showCarsNearMe(){
        didUpdateWithInitialLocation = true
        
        //Pretend Munich center is current location because Shanghai is too far :D
        if let location = currentLocation{
            print("User is currently here \(location.coordinate.latitude) , \(location.coordinate.longitude)")
            if let cars = carList{
                let annotations = CarHelper.carsNearMeNow(carList: cars, longitude: 11.58, latitude: 48.13, range: 10)
                mapView.addAnnotations(annotations)
                moveMapToLocation(location: CLLocationCoordinate2D.init(latitude: 48.13, longitude: 11.58))
            }
        }else{
            locationErrorAlert()
        }
    }
    
    fileprivate func showCarOnMap(car : Car){
        let annotation = CarAnnotation.init(with: car)
        mapView.addAnnotation(annotation)
        moveMapToLocation(location: annotation.coordinate)
    }
    
    fileprivate func moveMapToLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion.init(center: location, span: MKCoordinateSpan.init(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func locationErrorAlert(){
        let alert = UIAlertController.init(title: "Location error",
                                           message: "You didn't allow me to access your location so I can't show you the cars near you! Go to settings and give me permission if you changed your mind.",
                                           preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Go to Settings",
                                           style: .default,
                                           handler: { (action) in
                                            
                                            if let url = URL.init(string: UIApplicationOpenSettingsURLString){
                                                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                                                    //
                                                })
                                                
                                            }else{
                                                alert.dismiss(animated: true, completion: nil)
                                            }
                                            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        currentLocation = userLocation
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CarAnnotation {
            let identifier = annotation.carId
            var annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
                dequeuedView.annotation = annotation
                annotationView = dequeuedView
            } else {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                annotationView.calloutOffset = CGPoint(x: -5, y: 5)
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            
            annotationView.image = UIImage.init(named: "car_icon")
            return annotationView
        }
        
        return nil
    }
}
