//
//  CityLivePresenter.swift
//  AirQuality
//
//  Created by Srikanth SP on 10/05/22.
//

import Foundation

class CityLivePresenter: CityLivePresenterProtocol, CityLiveInteractorOutputProtocol {
    
    
    var view: CityLiveViewProtocol?
    
    var router: CityLiveRouterProtocol?
    
    var interactor: CityLiveInteractorInputProtocol?
    
    
    var selectedCity: String?
    
    func viewDidLoad() {
        if let selectedCity = selectedCity {
            interactor?.fetchWeatherForCity(selectedCity)
        }
    }
    
    func updateSelectedCity(_ city: String) {
        selectedCity = city
    }
    func didRecieveAQIForCity(_ result: Result<AQIData, Error>) {
        switch result {
        case .success(let data):
            let model = CityLiveAQIModel()
            model.city = data.city
            model.aqi = data.aqi
            if let time =  data.timestamp {
                model.time = Date(timeIntervalSince1970: time)
            }
            view?.updateCity(.success(model))
        
        case .failure(let error):
            view?.updateCity(.failure(error))
        }
        
    }
}
