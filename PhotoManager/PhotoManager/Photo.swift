//
//  Photo.swift
//  PhotoManager
//
//  Created by MINA FUJISAWA on 2017/10/18.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import Foundation
import UIKit

struct Photo {
    var city : String
    var image : UIImage
    
    init(city : String, image : UIImage) {
        self.city = city
        self.image = image
    }
}
