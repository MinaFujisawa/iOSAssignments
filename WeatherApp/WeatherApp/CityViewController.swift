//
//  CityViewController.swift
//  WeatherApp
//
//  Created by MINA FUJISAWA on 2017/09/20.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    let city : City
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
//    var detailedVC : DetailedViewController? = nil
    
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        //Image
        let image = UIImage(named: city.icon)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        addImageViewConstraints()
        
        //Label
        label.frame = CGRect(x: 0, y: 200, width: screenWidth, height: 100)
        label.text = city.weather
        label.font = label.font.withSize(28)
        label.textAlignment = .center;
        label.textColor = UIColor.white
        view.addSubview(label)
        
        //Button
        button.frame = CGRect.zero
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.orange, for: .normal)
        button.setTitle("Detail", for: .normal)
        button.addTarget(self, action: #selector(showWeatherDetails), for: .touchUpInside)
        button.tag = 1
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        addButtonConstraints()
        
    }
    
    func showWeatherDetails() {
        let detailedVC = DetailedViewController(city: city)
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func addImageViewConstraints() {
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide,
                           attribute: .top, multiplier: 1.0, constant: 120).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func addButtonConstraints() {
        NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil,
                           attribute: .notAnAttribute, multiplier: 1.0, constant: 80).isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil,
                           attribute: .notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: label,
                           attribute: .bottom, multiplier: 1.0, constant: 40).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    
}

