//
//  CityListDataManager.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import Foundation

class CityListDataManager: CityListDataManagerInputProtocol {
    var requestHandler: CityListDataManagerOutputProtocol?
    private var isSocketConnected = false
    
    lazy var socket: WeatherSocket = {
        let socket = WeatherSocket.shared
        socket.delegate = self
        socket.configure(url: WeatherSocket.WeatherHerokuUrl)
        return socket
    }()
    
    func fetchCityListAQI() {
        socket.connect()
    }
}

extension CityListDataManager: WeatherSocketDelegate {
    func connectionChanged(_ isConnected: Bool) {
        isSocketConnected = isConnected
    }
    
    func recievedData(_ result: Result<[AQIData], Error>) {
        switch result {
        case .success(let list):
            let updatedlist:[AQIData] =  list.map { data in
                let aqi = data
                aqi.timestamp = Date.currentTimestamp()
                return aqi
            }
            requestHandler?.cityList(.success(updatedlist))
        case .failure(let error):
            requestHandler?.cityList(.failure(error))
        }
        
        
    }
    
    
}
