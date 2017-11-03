//
//  CurrentWeather.swift
//  simpleWeatherApp
//
//  Created by Felipe Montoya on 11/2/17.
//  Copyright © 2017 Felipe Montoya. All rights reserved.
//

import Foundation

class CurrentWeather {
    fileprivate var _cityName: String!
    fileprivate var _date: String!
    fileprivate var _weatherType: String!
    fileprivate var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = currentDate
        return _date
        
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
 
    func downloadWeatherDetails(_ CURRENT_WEATHER_URL: String, completed: @escaping DowloadComplete){
         let session = URLSession.shared
        let url = URL(string: CURRENT_WEATHER_URL)!
        session.dataTask(with: url) { (data,response, error) in
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
        do {
            let rawJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            if let json = rawJSON as? [String:AnyObject]{
                if let name = json["name"] as? String {
                    self._cityName = name.capitalized
                }
                if let weather = json["weather"] as? [[String:AnyObject]] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                if let main = json["main"] as? [String:AnyObject]{
                    if let currentTempInKelvin = main["temp"] as? Double {
                        self._currentTemp = currentTempInKelvin.rounded() - 273.1
                    }
                }
            }
        } catch {
            print("Could not serialize")
        }
    }
            completed()
        }.resume()
    }
    
    
}
