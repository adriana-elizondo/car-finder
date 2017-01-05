//
//  CarListViewController.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 04/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

class CarListViewController : UIViewController{
    @IBOutlet weak var carListTableView: UITableView!{
        didSet{
            carListTableView.addSubview(refreshControl)
            carListTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var messageLabel: UILabel!
    
    lazy var refreshControl : UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(loadCarList), for: .valueChanged)
        return control
    }()
    
    var carList = [Car]()
    var carToShow : Car? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCarList()
    }
    
    func loadCarList(){
        CarHelper.getCarsFromServer { (response, error) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                
                if let cars = response as? [Car]{
                    self.carList = cars
                    self.carListTableView.reloadData()
                }else{
                    self.messageLabel.text = "There was an error loading the cars, please try again later!"
                }
            }
        }
    }
    
    @IBAction func showCarsNearMe(_ sender: Any) {
        carToShow = nil
        self.performSegue(withIdentifier: "goToMap", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMap"{
            if let mapController = segue.destination as? MapViewController{
                mapController.specificCar = carToShow
                mapController.carList = carList
            }
        }else if segue.identifier == "goToCarDetail"{
            if let detailController = segue.destination as? CarDetailViewController,
                let cell = sender as? CarTableViewCell{
                detailController.car = carList[cell.tag]
            }
        }
    }
}

extension CarListViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "carCell") as? CarTableViewCell{
            cell.setUpCellWithCar(car: carList[indexPath.row])
            cell.delegate = self
            cell.tag = indexPath.row
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToCarDetail", sender: tableView.cellForRow(at: indexPath))
    }
}

extension CarListViewController : CarCellDelegate{
    func showOnMap(car: Car?) {
        carToShow = car
        self.performSegue(withIdentifier: "goToMap", sender: nil)
    }
}
