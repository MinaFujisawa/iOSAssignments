//
//  Page.swift
//  AVStoryBook
//
//  Created by MINA FUJISAWA on 2017/10/17.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit
import Foundation

struct Page {
    var image: UIImage?
    var recordURL: URL?

    init(image: UIImage?, recordURL: URL?) {
        self.image = image
        self.recordURL = recordURL
    }   
}

