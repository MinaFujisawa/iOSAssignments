//
//  Photo.swift
//  CatMap
//
//  Created by MINA FUJISAWA on 2017/10/20.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import Foundation
import MapKit

class Photo: NSObject, MKAnnotation {

    var title: String?
    var id: String
    var url: URL
    var coordinate : CLLocationCoordinate2D

    init(title: String?, id: String, url: URL, coordinate : CLLocationCoordinate2D) {
        self.title = title
        self.id = id
        self.url = url
        self.coordinate = coordinate
    }
}

