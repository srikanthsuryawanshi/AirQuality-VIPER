//
//  CityLiveRouter.swift
//  AirQuality
//
//  Created by Srikanth SP on 10/05/22.
//

import Foundation
import UIKit

class CityLiveRouter: CityLiveRouterProtocol {
    static func createCityLiveModule() -> UIViewController {
        
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate

        if  let view = mainStoryboard.instantiateViewController(withIdentifier: "CityLiveView") as? CityLiveView {
            
            var presenter: CityLivePresenterProtocol & CityLiveInteractorOutputProtocol =
            appDelegate.container.resolve(CityLivePresenter.self)!

            var interactor: CityLiveInteractorInputProtocol & CityLiveDataManagerOutputProtocol =
            appDelegate.container.resolve(CityLiveInteractor.self)!
            
            var dataManager: CityLiveDataManagerInputProtocol = appDelegate.container.resolve(CityLiveDataManager.self)!

            let router: CityLiveRouterProtocol = appDelegate.container.resolve(CityLiveRouter.self)!
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.dataManager = dataManager
            dataManager.requestHandler = interactor
            
            return view
        }
        
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

}
