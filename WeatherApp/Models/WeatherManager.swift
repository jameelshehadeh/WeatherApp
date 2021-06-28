//
//  WeatherManager.swift
//  WeatherAppT
//
//  Created by Jameel Shehadeh on 13/12/2020.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error : Error)
}

struct WeatherManager {
    //api key : 5876d6fbd63d83148617c003c471f916
    
    let apiLink = "https://api.openweathermap.org/data/2.5/weather?appid=5876d6fbd63d83148617c003c471f916&units=metric&q="
    
    var delegate: WeatherManagerDelegate?
    
    func getWeather(cityName: String) {
        
        let urlLink = "\(apiLink)\(cityName)"
        print(urlLink)
        performRequest(urlLink : urlLink)
    }
    
    
    func getWeather(lat : CLLocationDegrees , lon : CLLocationDegrees) {
        let apiLink = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=5876d6fbd63d83148617c003c471f916&units=metric"
        performRequest(urlLink : apiLink)
        
        
    }
    
    
    func performRequest(urlLink : String) {
        
        if let url = URL(string: urlLink) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //let stringData = String(data: safeData, encoding: .utf8)
                    if let weather = ParseJSON(data: safeData){
                            delegate?.didUpdateWeather(weather : weather)
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    
    
    func ParseJSON(data: Data)  -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let cityName = decodedData.name
            let temprature = decodedData.main.temp
            let weatherId = decodedData.weather[0].id
            print(cityName,temprature,weatherId)
            let weatherModel = WeatherModel(temp: temprature, id: weatherId, cityName: cityName)
            return weatherModel
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
            // if parsing didnt go well
        }
    }
    
    
    
    
    
}
