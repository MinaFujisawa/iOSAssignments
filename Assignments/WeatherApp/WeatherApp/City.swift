//
//  City.swift
//  WeatherApp
//
//  Created by MINA FUJISAWA on 2017/09/20.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

class City {
    let cityName : String
    let weather : String
    let detail : String
    let temperature : Int
    let icon : String
    init(cityName :String , weather :String, detail:String, temperature:Int, icon:String) {
        self.cityName = cityName
        self.weather = weather
        self.detail = detail
        self.temperature = temperature
        self.icon = icon
    }
}
