//
//  CityLiveProtocols.swift
//  AirQuality
//
//  Created by Srikanth SP on 10/05/22.
//

import Foundation
import UIKit

// VIEW -> PRESENTER
protocol CityLivePresenterProtocol {
    
    var view: CityLiveViewProtocol? { get set }
    var router: CityLiveRouterProtocol? { get set }
    var interactor: CityLiveInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    
    func updateSelectedCity(_ city: String) 
}

// PRESENTER -> VIEW
protocol CityLiveViewProtocol {
    var presenter: CityLivePresenterProtocol? { get set}
    
    func updateCity(_ result: Result<CityLiveAQIModel, Error>)
    func updateLoadingStatus(_ isLoading: Bool)
}

//PRESENTER -> ROUTER
protocol CityLiveRouterProtocol {
    static func createCityLiveModule() -> UIViewController
}

//PRESENTER -> INTERACTOR
protocol CityLiveInteractorInputProtocol {
    var presenter: CityLiveInteractorOutputProtocol? { get set }
    var dataManager: CityLiveDataManagerInputProtocol?{ get set }
    
    func fetchWeatherForCity(_ city: String)
}

//INTERACTOR -> PRESENTER
protocol CityLiveInteractorOutputProtocol {
    func didRecieveAQIForCity(_ result: Result<AQIData, Error>)
}

//INTERACTOR -> MANAGER
protocol CityLiveDataManagerInputProtocol {
    var requestHandler: CityLiveDataManagerOutputProtocol? { get set }
    func fetchCityAQI(_ city: String)
}

//MANAGER TO INTERACTOR
protocol CityLiveDataManagerOutputProtocol {
    func cityLive(_ result: Result<AQIData, Error>)
}
