//
//  CollectionViewController.swift
//  PhotoManager
//
//  Created by MINA FUJISAWA on 2017/10/18.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit
import Photos
//import AssetsLibrary

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    var photos = [Photo]()
    var sectionsByLocation = [String]()
    let imagePicker = UIImagePickerController()

    @IBAction func addButton(_ sender: Any) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            self.pickImageFromLibrary()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }


// MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsByLocation.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let nationalParks = citiesForSection(section)
        return nationalParks.count
    }

    // MARK: Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeaderView

        sectionHeaderView.title = sectionsByLocation[indexPath.row]

        return sectionHeaderView
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        let photo : Photo
        if indexPath.section > 0 {
            let section = citiesForSection(indexPath.section)
            photo = section[indexPath.item]
        } else {
            photo = photos[indexPath.item]
        }
        
        cell.imageView.image = photo.image
        
//        PHImageManager.default().requestImage(for: photo, targetSize: CGSize(width: 100, height: 100), contentMode: .default, options: nil, resultHandler: { (image, info) in
//            cell.imageView.image = image
//        })

        return cell
    }

    fileprivate func citiesForSection(_ section: Int) -> [Photo] {
        let cityName = sectionsByLocation[section]
        let parksInSection = photos.filter { (photo: Photo) -> Bool in
            photo.city == cityName
        }
        return parksInSection
    }
}

extension CollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {

        let asset = info[UIImagePickerControllerPHAsset] as! PHAsset
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage

        let geocoder = CLGeocoder()
        if let location = asset.location {
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                guard let city = placemarks?[0].locality else { return }
                let newPhoto = Photo(city: city, image: image)
                self.photos.append(newPhoto)
                if !self.sectionsByLocation.contains(city) {
                    self.sectionsByLocation.append(city)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            }
        }

        collectionView?.reloadData()

        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

