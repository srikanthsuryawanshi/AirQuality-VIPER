//
//  CityListInteractor.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import Foundation

class CityListInteractor: CityListInteractorInputProtocol {
    var presenter: CityListInteractorOutputProtocol?
    
    var dataManager: CityListDataManagerInputProtocol?
    
    func fetchWeatherForCityList() {
        dataManager?.fetchCityListAQI()
    }
    
    
}

extension CityListInteractor: CityListDataManagerOutputProtocol {
    func cityList(_ result: Result<[AQIData], Error>) {
        presenter?.didRecieveAQIForCityList(result)
    }
}
