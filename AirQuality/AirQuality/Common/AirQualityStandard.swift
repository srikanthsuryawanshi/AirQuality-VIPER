//
//  AirQualityStandard.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import Foundation
import UIKit

enum AirQualityStandard {
    case Good
    case Satisfactory
    case Moderate
    case Poor
    case VeryPoor
    case Severe
    
    static func withValue(_ value: Int) -> AirQualityStandard {
        
        switch value {
        case 0...50: return Good
        case 51...100: return Satisfactory
        case 101...200: return Moderate
        case 201...300: return Poor
        case 301...400: return VeryPoor
        case 401...500: return Severe
        default: fatalError("Invalid Air Quality value")
            
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .Good:
            return  UIColor(rgb: 0x4DD637)
        case .Satisfactory:
            return  UIColor(rgb: 0x66AD47)
        case .Moderate:
            return  UIColor(rgb: 0xDDD101)
        case .Poor:
            return  UIColor(rgb: 0xE07C24)
        case .VeryPoor:
            return  UIColor(rgb: 0xD82E2F)
        case .Severe:
            return  UIColor(rgb: 0xB4161B)
        }
    }
}
