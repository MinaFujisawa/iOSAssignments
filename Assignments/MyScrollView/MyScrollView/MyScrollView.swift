//
//  MyScrollView.swift
//  MyScrollView
//
//  Created by MINA FUJISAWA on 2017/10/11.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class MyScrollView: UIView {

    var contentSize : CGRect?
    var pgr : UIPanGestureRecognizer?
    
//    @objc func handleGesture(gestureRec: UIPanGestureRecognizer) {
//        let translation = gestureRec.translation(in: view)
//        print(translation)
//        
//        let bounds = view.bounds
//        let newX = view.bounds.origin.x - translation.x
//        let newY = view.bounds.origin.y - translation.y
//        
//        view.bounds = CGRect(x: newX, y: newY, width: bounds.size.width, height: bounds.size.height)
//        gestureRec.setTranslation(CGPoint.zero, in: view)
//        
//    }
}
