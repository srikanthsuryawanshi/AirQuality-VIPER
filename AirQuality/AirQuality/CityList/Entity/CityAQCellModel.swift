//
//  CityAQCellModel.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import Foundation


class CityAQCellModel {
    var cityName: String = ""
    var aqValue: Double = -1.0
    var standard: AirQualityStandard = .Good
    var lastUpdated: String = "Last Updated:"
    
    func updateLastUpdateTime(_ time: Double) {
        let lastUpdatedTime = Date(timeIntervalSince1970: time)
        let difference = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now, to: lastUpdatedTime)
        
        if let hrs = difference.hour, hrs > 0 {
            lastUpdated = lastUpdated + "\(hrs) hr(s) ago"
            return
        }
        
        if let minutes = difference.minute, minutes > 0 {
            lastUpdated = lastUpdated + "\(minutes) minute(s) ago"
            return
        }
        
        if let seconds = difference.second, seconds > 0 {
            lastUpdated = lastUpdated + "\(seconds) second(s) ago"
            return
        }
        
        lastUpdated = lastUpdated + "Just Now"

    }
}
