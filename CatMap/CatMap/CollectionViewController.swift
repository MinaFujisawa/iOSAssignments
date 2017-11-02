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

    var photos = [Photo]()
    var filterdPhotos = [Photo]()
    let imageStore = ImageStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        let width = collectionView!.frame.size.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)


        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=feadd15b72fc41f22223d740a0c346a5&tags=cat&has_geo=1&extras=url_m&format=json&nojsoncallback=1")!


        FlickerAPI.fetchBasicData(url: url) { (photos) in
            self.photos = photos
            self.collectionView?.reloadData()
        }
    }

    func hasFilteredPhotos() -> Bool {
        return filterdPhotos.count > 0
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if hasFilteredPhotos() {
            return filterdPhotos.count
        } else {
            return photos.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell

        let photo: Photo
        if hasFilteredPhotos() {
            photo = filterdPhotos[indexPath.row]
        } else {
            photo = photos[indexPath.row]
        }
        cell.titleLabel.text = photo.title

        // Image
        let imageFromCache = imageStore.image(forKey: photo.id)
        if let image = imageFromCache {
            cell.image.image = image
        } else {
            let data = NSData(contentsOf: photo.url)
            if let image = UIImage(data: data! as Data) {
                cell.image.image = image
                imageStore.setImage(image, forkey: String(describing: photo.id))
//                collectionView.reloadItems(at: [indexPath])
            }
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! MyCollectionViewCell
            if let indexPath = self.collectionView!.indexPath(for: cell) {
                if hasFilteredPhotos() {
                    detailVC.photo = filterdPhotos[indexPath.row]
                } else {
                    detailVC.photo = photos[indexPath.row]
                }
            }
        } else if segue.identifier == "GoToSearch" {
            let searchVC = segue.destination as! SearchViewController
            searchVC.allPhotos = photos
            var allTags = Set<String>()
            for photo in photos {
                for tag in photo.tags {
                    allTags.insert(tag.lowercased())
                }
            }
            searchVC.allTags = Array(allTags)
        }
    }
}
