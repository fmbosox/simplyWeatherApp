//
//  Location.swift
//  simpleWeatherApp
//
//  Created by Felipe Montoya on 11/2/17.
//  Copyright © 2017 Felipe Montoya. All rights reserved.
//

import CoreLocation


class Location {
    static var sharedInstance = Location ()
    private init(){}
    
    var longitude: Double!
    var latitude: Double!
    var city: String!
    
    
}
