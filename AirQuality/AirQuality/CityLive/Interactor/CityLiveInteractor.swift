//
//  CityLiveInteractor.swift
//  AirQuality
//
//  Created by Srikanth SP on 10/05/22.
//

import Foundation

class CityLiveInteractor: CityLiveInteractorInputProtocol, CityLiveDataManagerOutputProtocol {
    
    var presenter: CityLiveInteractorOutputProtocol?
    
    var dataManager: CityLiveDataManagerInputProtocol?
    
    func fetchWeatherForCity(_ city: String) {
        dataManager?.fetchCityAQI(city)
    }
    
    func cityLive(_ result: Result<AQIData, Error>) {
        presenter?.didRecieveAQIForCity(result)
    }
    
}
