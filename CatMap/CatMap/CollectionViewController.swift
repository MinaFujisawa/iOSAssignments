//
//  CollectionViewController.swift
//  CatMap
//
//  Created by MINA FUJISAWA on 2017/10/23.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    var photoList = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let width = collectionView!.frame.size.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)


        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=feadd15b72fc41f22223d740a0c346a5&tags=cat&has_geo=1&extras=url_m&format=json&nojsoncallback=1")!

        FlickerAPI.fetchBasicData(url: url) { (photos) in
            self.photoList = photos
            self.collectionView?.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        let data = NSData(contentsOf: photoList[indexPath.row].url)
        cell.image.image = UIImage(data: data! as Data)
        cell.titleLabel.text = photoList[indexPath.row].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! MyCollectionViewCell
            if let indexPath = self.collectionView!.indexPath(for: cell){
                detailVC.photo = photoList[indexPath.row]
            }
        }
    }
}
