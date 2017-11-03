//
//  DetailViewController.swift
//  CatMap
//
//  Created by MINA FUJISAWA on 2017/10/23.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    var photo : Photo?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let photo = photo else { return }
        let data = NSData(contentsOf: photo.url)
        imageView.image = UIImage(data: data! as Data)
        navigationItem.title = photo.title
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5);
        self.mapView.region = MKCoordinateRegion(center: photo.coordinate, span: span)
        self.mapView.addAnnotation(photo)
    }

}
