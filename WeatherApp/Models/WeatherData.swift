//
//  WeatherData.swift
//  WeatherAppT
//
//  Created by Jameel Shehadeh on 13/12/2020.
//

import Foundation


struct WeatherData :  Decodable {
    
    let main : Main
    let weather : [Weather]
    let name : String
    
}


struct Main : Decodable {
    
    let temp : Float
    
    
}

struct Weather : Decodable {
    
    let id : Int
    
    
}
