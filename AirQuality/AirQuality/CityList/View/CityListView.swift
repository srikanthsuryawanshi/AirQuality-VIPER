//
//  CityListView.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import Foundation
import UIKit


class CityListView: UITableViewController,CityListViewProtocol {
    var presenter: CityListPresenterProtocol?
    
    var tableData:[CityAQCellModel] = []
    
    override func viewDidLoad() {
        configureTable()
        presenter?.viewDidLoad()
    }
    
    func updateCityList(_ result: Result<[CityAQCellModel], Error>) {
        switch result {
        case .success(let list):
            showWeatherForCities(list)
        case .failure(let error):
            showError(error)
        }
    }
    
    func showWeatherForCities(_ cities:[CityAQCellModel]) {
        tableData = cities
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        throwErrorAlert(title: "Error", text: error.localizedDescription)
    }
    
    func updateLoadingStatus(_ isLoading: Bool) {
        //show or hide loading indicator
    }
    
}

extension CityListView {
    func configureTable() {
        self.title = "Air Quality Index(IND)"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let cityCellNib = UINib(nibName: "CityListViewCellTableViewCell",
                                      bundle: nil)
        self.tableView.register(cityCellNib, forCellReuseIdentifier: "CityListViewCellTableViewCell")
        
        addMockData()
    }
    
    func addMockData() {
        let cell1 = CityAQCellModel()
        cell1.cityName = "Bengaluru"
        cell1.aqValue = 50
        cell1.lastUpdated = "a moment ago"
      
        let cell2 = CityAQCellModel()
        cell2.cityName = "Hyderabad"
        cell2.aqValue = 100
        cell2.lastUpdated = "a moment ago"
      
        let cell3 = CityAQCellModel()
        cell3.cityName = "Pune"
        cell3.aqValue = 200
        cell3.lastUpdated = "a moment ago"
      
        let cell4 = CityAQCellModel()
        cell4.cityName = "Mumbai"
        cell4.aqValue = 300
        cell4.lastUpdated = "a moment ago"
      
        let cell5 = CityAQCellModel()
        cell5.cityName = "Chennai"
        cell5.aqValue = 400
        cell5.lastUpdated = "a moment ago"
        
        let cell6 = CityAQCellModel()
        cell6.cityName = "Delhi"
        cell6.aqValue = 500
        cell6.lastUpdated = "a moment ago"
      
        tableData = [cell1,cell2,cell3,cell4,cell5,cell6]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityListViewCellTableViewCell") as? CityListViewCellTableViewCell {
            
            let cellData = tableData[indexPath.row]
            
            cell.configureCell(city: cellData.cityName, value: cellData.aqValue, lastUpdated: cellData.lastUpdated)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = tableData[indexPath.row]
        presenter?.showCityLiveAQIScreen(cellData.cityName)
    }
    
}


extension UIViewController {
    func throwErrorAlert(title:String, text:String) {
        guard self.presentedViewController == nil else {
            self.presentedViewController?.dismiss(animated: true, completion: { [weak self] in
                guard let self =  self else { return }
                self.throwErrorAlert(title: title, text: text)
            })
            return
        }
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
}
