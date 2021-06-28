//
//  ViewController.swift
//  WeatherAppT
//
//  Created by Jameel Shehadeh on 13/12/2020.
//

import UIKit
import CoreLocation


class ViewController: UIViewController , CLLocationManagerDelegate {
   

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        //get the permission from user
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location function printed")
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.getWeather(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
   
    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//
//    }
    
}

//MARK: - UITextfieldDelegate

extension ViewController : UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            print(searchTextField.text!)
            return true
        }
        else {
            textField.placeholder = " Enter valid city name"
            return false
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cityName = searchTextField.text {
            weatherManager.getWeather(cityName : cityName)
        }
        searchTextField.text = ""
        searchTextField.placeholder = "Search"
    }

    }

//MARK: - WeatherManagerDelegate

extension ViewController : WeatherManagerDelegate {

    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherDegreeLabel.text = weather.tempAsString
            self.weatherConditionImage.image = UIImage(systemName: weather.weatherCondition)
            self.cityNameLabel.text = weather.cityName
        }
    }
    
        func didFailWithError(error: Error) {
        print(error)
        }
    
}
