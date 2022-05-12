//
//  CityListModuleProtocols.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import Foundation
import UIKit


// VIEW -> PRESENTER
protocol CityListPresenterProtocol {
    
    var view: CityListViewProtocol? { get set }
    var router: CityListRouterProtocol? { get set }
    var interactor: CityListInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    func showCityLiveAQIScreen(_ city: String)
}


// PRESENTER -> VIEW
protocol CityListViewProtocol {
    var presenter: CityListPresenterProtocol? { get set}
    func updateCityList(_ result: Result<[CityAQCellModel], Error>)
    func updateLoadingStatus(_ isLoading: Bool)
}

//PRESENTER -> ROUTER

protocol CityListRouterProtocol {
   
    static func createCityListModule() -> UIViewController
    
    func presentCityLiveScreen(_ city: String, view: CityListViewProtocol)
}



//PRESENTER -> INTERACTOR
protocol CityListInteractorInputProtocol {
    var presenter: CityListInteractorOutputProtocol? { get set }
    var dataManager: CityListDataManagerInputProtocol?{ get set }
    func fetchWeatherForCityList()
}

//INTERACTOR -> PRESENTER
protocol CityListInteractorOutputProtocol {
    func didRecieveAQIForCityList(_ result: Result<[AQIData], Error>)
}

//INTERACTOR -> MANAGER
protocol CityListDataManagerInputProtocol {
    var requestHandler: CityListDataManagerOutputProtocol? { get set }
    func fetchCityListAQI()
}

//MANAGER TO INTERACTOR
protocol CityListDataManagerOutputProtocol {
    func cityList(_ result: Result<[AQIData], Error>)
}
