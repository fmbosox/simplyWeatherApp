//
//  ViewController.swift
//  simpleWeatherApp
//
//  Created by Felipe Montoya on 11/2/17.
//  Copyright © 2017 Felipe Montoya. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var currentWeather: CurrentWeather!
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        temperatureLabel.text = "\(currentWeather.currentTemp)ºC"
        
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentCityLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude =
                currentLocation.coordinate.latitude.binade
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude.binade
            print(currentLocation.coordinate.latitude.binade)
            print(currentLocation.coordinate.longitude.binade)
            currentWeather.downloadWeatherDetails(LOCATION_WEATHER_URL,completed: { () in
                
                DispatchQueue.main.async {
                    self.updateMainUI()
                }
            })
            
        } else {
            
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startMonitoringSignificantLocationChanges()
            currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationAuthStatus()
    }
    
    @IBAction func byCityButtonPressed(_ sender: Any) {
       Location.sharedInstance.city = cityTextField.text!
      currentWeather.downloadWeatherDetails(BYCITY_WEATHER_URL,completed: { () in
            
            DispatchQueue.main.async {
                self.updateMainUI()
            }
        })
        cityTextField.text = ""
    }
    
    
}

