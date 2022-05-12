//
//  CityLiveDataManager.swift
//  AirQuality
//
//  Created by Srikanth SP on 10/05/22.
//

import Foundation

class CityLiveDataManager: CityLiveDataManagerInputProtocol {
    var requestHandler: CityLiveDataManagerOutputProtocol?
    private var isSocketConnected = false
    private var selectedCity: String?
    private lazy var socket: WeatherSocket = {
        let socket =  WeatherSocket.shared
        socket.configure(url: WeatherSocket.WeatherHerokuUrl)
        socket.delegate = self
        return socket
    }()
    
    func fetchCityAQI(_ city: String) {
        selectedCity = city
        socket.connect()
    }
    
}

extension CityLiveDataManager: WeatherSocketDelegate {
    func connectionChanged(_ isConnected: Bool) {
        isSocketConnected = isConnected
    }
    
    func recievedData(_ result: Result<[AQIData], Error>) {
        switch result {
        case .success(let list):
            
            let filtered = list.filter { data in
                return selectedCity == data.city
            }
            if let selectedData = filtered.first {
                selectedData.timestamp = Date.currentTimestamp()
                requestHandler?.cityLive(.success(selectedData))
            }

        case .failure(let error):
            requestHandler?.cityLive(.failure(error))
        }
    }
    
    
}
