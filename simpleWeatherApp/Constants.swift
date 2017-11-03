//
//  Constants.swift
//  simpleWeatherApp
//
//  Created by Felipe Montoya on 11/2/17.
//  Copyright © 2017 Felipe Montoya. All rights reserved.
//

import Foundation



typealias DowloadComplete = () -> ()
let LOCATION_WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\((Location.sharedInstance.latitude)!)&lon=\((Location.sharedInstance.longitude)!)&APPID=3085b1dd5342a2fc1e2327189c7dfa0a"
var BYCITY_WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?q=\((Location.sharedInstance.city)!)&APPID=3085b1dd5342a2fc1e2327189c7dfa0a"
