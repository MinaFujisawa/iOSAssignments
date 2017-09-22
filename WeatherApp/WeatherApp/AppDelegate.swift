//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Derrick Park on 2017-05-26.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let vancouver = City(cityName: "Vancouver", weather: "Sunny", detail: "very good", temperature: 20, icon:"clear-day")
        let tokyo = City(cityName: "Tokyo", weather: "Cloudy", detail: "Mostoly cloudy currently.", temperature: 20, icon:"cloudy")
        let NY = City(cityName: "New York", weather: "Partly Cloudy", detail: "Partly Cloudy currently", temperature: 12, icon:"partly-cloudy")
        let london = City(cityName: "London", weather: "Rain", detail: "Rain rain rain", temperature: 20, icon:"rain")
        let beijing = City(cityName: "Beijing", weather: "fine", detail: "very good", temperature: 20, icon:"clear-day")
        
        let tabBarControllers = UITabBarController()
        
        let vancouverVC = CityViewController(city: vancouver)
        vancouverVC.title = "Vancouver"
        let tokyoVC = CityViewController(city: tokyo)
        tokyoVC.title = "Tokyo"
        let NYVC = CityViewController(city: NY)
        NYVC.title = "New York"
        let londonVC = CityViewController(city: london)
        londonVC.title = "London"
        let beijingVC = CityViewController(city: beijing)
        beijingVC.title = "Beijing"
        
        let controllers = [vancouverVC, tokyoVC, NYVC, londonVC,beijingVC]
        
        //Navi bar
        tabBarControllers.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        
        //Set icon fot the navi bar
        for item in tabBarControllers.tabBar.items! {
            item.image = UIImage(named:"city")
        }

        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = tabBarControllers
        
        window?.makeKeyAndVisible()
        return true
    }
}



