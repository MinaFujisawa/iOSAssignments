//
//  ViewController.swift
//  MyScrollView
//
//  Created by MINA FUJISAWA on 2017/10/11.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class MyScrollView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let redView = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        redView.backgroundColor = UIColor.red
        let greenView = UIView(frame: CGRect(x: 150, y: 150, width: 150, height: 200))
        greenView.backgroundColor = UIColor.green
        let blueView = UIView(frame: CGRect(x: 40, y: 400, width: 200, height: 150))
        blueView.backgroundColor = UIColor.blue
        let yellowView = UIView(frame: CGRect(x: 100, y: 600, width: 180, height: 150))
        yellowView.backgroundColor = UIColor.yellow
        
        let margins = view.layoutMarginsGuide
//        redView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
//        redView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
        
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        view.addSubview(yellowView)
        
        let gestureRec = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(gestureRec)

    }

    override func viewDidAppear(_ animated: Bool) {
        //Move the origin of the bounds of your root view down 100 point in the y direction
//        let bounds = view.bounds
//        let newY = view.bounds.origin.y + 100
//
//        view.bounds = CGRect(x: bounds.origin.x, y: newY, width: bounds.width, height: bounds.height)
    }
    
    @objc func handleGesture(gestureRec: UIPanGestureRecognizer) {
        let translation = gestureRec.translation(in: view)
        print(translation)

        let bounds = view.bounds
        let newX = view.bounds.origin.x - translation.x
        let newY = view.bounds.origin.y - translation.y

        view.bounds = CGRect(x: view.bounds.origin.x, y: newY, width: bounds.size.width, height: bounds.size.height)
        gestureRec.setTranslation(CGPoint.zero, in: view)
    }


}

