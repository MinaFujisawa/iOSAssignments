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
//            for i in 0..<self.photoList.count {
//                print(self.photoList[i].coordinate)
//            }
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
