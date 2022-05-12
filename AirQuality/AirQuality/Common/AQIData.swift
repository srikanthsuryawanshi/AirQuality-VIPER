//
//  AQIData.swift
//  AirQuality
//
//  Created by Srikanth SP on 10/05/22.
//

import Foundation

class AQIDataList: Codable{
    
    var aqiDataList: [AQIData]?
}

class AQIData: Codable {
    var city: String?
    var aqi: Double?
    var timestamp: Double?
}
