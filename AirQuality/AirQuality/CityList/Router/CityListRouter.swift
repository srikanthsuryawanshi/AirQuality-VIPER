//
//  CityListRouter.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import Foundation
import UIKit

class CityListRouter: CityListRouterProtocol {
    static func createCityListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "CityListNavigationController") as! UINavigationController
        
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        
        if let view = navController.children.first as? CityListView {
            
            var presenter: CityListPresenterProtocol & CityListInteractorOutputProtocol =
            appDelegate.container.resolve(CityListPresenter.self)!
            var interactor: CityListInteractorInputProtocol & CityListDataManagerOutputProtocol =
            appDelegate.container.resolve(CityListInteractor.self)!
            var dataManager: CityListDataManagerInputProtocol = appDelegate.container.resolve(CityListDataManager.self)!
            let router: CityListRouterProtocol = appDelegate.container.resolve(CityListRouter.self)!
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.dataManager = dataManager
            dataManager.requestHandler = interactor
            
            return navController
        }
        
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    func presentCityLiveScreen(_ city: String, view: CityListViewProtocol) {

        DispatchQueue.main.async {
            guard let viewVC = view as? UIViewController,
            let cityLiveScreen =  CityLiveRouter.createCityLiveModule() as? CityLiveView else {
                fatalError("Invalid View Protocol type")
            }
            cityLiveScreen.configure(cityName: city)
            viewVC.navigationController?.pushViewController(cityLiveScreen, animated: true)
        }
    }
}



