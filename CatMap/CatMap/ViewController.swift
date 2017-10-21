//
//  ViewController.swift
//  CatMap
//
//  Created by MINA FUJISAWA on 2017/10/20.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var photoList = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=feadd15b72fc41f22223d740a0c346a5&tags=cat&has_geo=1&extras=url_m&format=json&nojsoncallback=1")!
        
        FlickerAPI.fetchBasicData(url: url) { (photos) in
            self.photoList = photos
//            self.tableView.reloadData()
            FlickerAPI.fetchCoordinate(photos: photos) { (photos) in
                self.photoList = photos
                print(photos)
            }
        }
        
        
        
    }

}
