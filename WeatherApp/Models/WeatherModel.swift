//
//  WeatherModel.swift
//  WeatherAppT
//
//  Created by Jameel Shehadeh on 13/12/2020.
//

import Foundation


struct WeatherModel {
    
    let temp : Float
    let id : Int
    let cityName : String
    
//    init(temp : Float , id : Int , cityName : String) {
//
//        self.temp = temp
//        self.id = id
//        self.cityName = cityName
//
//    }
    
    var tempAsString : String {
        
        return String(format: "%.1f", temp)
        
    }
    
    var weatherCondition : String {
        
        switch id {
        case 200 ... 232 :
            return "cloud.bolt"
        case 300...321 :
            return "cloud.drizzle"
        case 500 ... 531 :
            return "cloud.rain"
        case 600 ... 622 :
            return "cloud.snow"
        case 800 :
            return "sun.max"
        case 801 ... 804:
            return "cloud"
//        case 701 :
//            return
        case 711:
            return "smoke"
//        case 721 :
//            return
//        case 731 :
//            return
        case 741:
            return "cloud.fog"
//        case 751 :
//            return
        case 761:
            return "sun.dust"
//        case 762 :
//            return
//        case 771:
//            return
        case 781:
            return "tornado"
        default:
            return "cloud"
        }
    }
    
    
    
    
}
