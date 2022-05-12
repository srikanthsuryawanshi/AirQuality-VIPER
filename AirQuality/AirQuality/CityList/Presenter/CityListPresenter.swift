//
//  CityListPresenter.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import Foundation

class CityListPresenter: CityListPresenterProtocol {
    
    var view: CityListViewProtocol?
    var router: CityListRouterProtocol?
    var interactor: CityListInteractorInputProtocol?

    func viewDidLoad() {
        interactor?.fetchWeatherForCityList()
    }
    
    func showCityLiveAQIScreen(_ city: String) {
        if let view = view, let router = router {
            router.presentCityLiveScreen(city, view: view)
        }
    }
    
}


extension CityListPresenter: CityListInteractorOutputProtocol {
    func didRecieveAQIForCityList(_ result: Result<[AQIData], Error>) {
        switch result {
        case .success(let cityListData):
            let cityCellList:[CityAQCellModel] = cityListData.map { data in
                let cellData = CityAQCellModel()
                cellData.cityName =  data.city ?? "DEFAULT"
                cellData.aqValue =  data.aqi ?? 0.0
                cellData.updateLastUpdateTime(data.timestamp ?? 0.0)
                return cellData
            }
            view?.updateCityList(.success(cityCellList))
        case .failure(let error):
            view?.updateCityList(.failure(error))
        }
    }
}
