//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by MINA FUJISAWA on 2017/09/20.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    let city : City
    let imageView = UIImageView()
    let detailLabel = UILabel()
    let tempLabel = UILabel()
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        //Label
        detailLabel.frame = CGRect(x: 0, y: 200, width: screenWidth, height: 100)
        detailLabel.text = city.detail
        detailLabel.font = detailLabel.font.withSize(28)
        detailLabel.textAlignment = .center;
        detailLabel.textColor = UIColor.white
        view.addSubview(detailLabel)
        
        tempLabel.frame = CGRect(x: 0, y: 240, width: screenWidth, height: 100)
        tempLabel.text = "Temperature:\(city.temperature)℃"
        tempLabel.font = tempLabel.font.withSize(28)
        tempLabel.textAlignment = .center;
        tempLabel.textColor = UIColor.white
        view.addSubview(tempLabel)
    }

}
