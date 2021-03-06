//
//  ProductsViewController.swift
//  RWClean
//
//  Created by MINA FUJISAWA on 2017/11/16.
//  Copyright © 2017 Razeware, LLC. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    internal var productType: Product.ProductType! {
        didSet { title = productType.title }
    }
    // MARK - Network Client Intjection
    internal var networkClient = NetworkClient.shared

    // MARK: - Instance Properties
    internal var imageTasks: [IndexPath: URLSessionDataTask] = [:]
    internal var products: [Product] = []
    internal let session = URLSession.shared

    // MARK: - Outlets
    @IBOutlet internal var collectionView: UICollectionView! {
        didSet {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(loadProducts), for: .valueChanged)
            collectionView.refreshControl = refreshControl

            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            collectionView.collectionViewLayout = CollectionViewCenterFlowLayout(layout: layout)
        }
    }

    internal func loadProducts() {
        collectionView.refreshControl?.beginRefreshing()
        networkClient.getProducts(forType: productType, success: { [weak self] products in
            guard let strongSelf = self else { return }
            strongSelf.products = products
            strongSelf.collectionView.reloadData()
            strongSelf.collectionView.refreshControl?.endRefreshing()
        }) { [weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.collectionView.refreshControl?.endRefreshing()
            print("Product dwonload failded: \(error)")
        }

    }

    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        guard let selectedItem = collectionView.indexPathsForSelectedItems else { return }
        selectedItem.forEach { collectionView.deselectItem(at: $0, animated: false) }
    }

    // MARK: - Segue
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ProductDetailsViewController else { return }
        let indexPath = collectionView.indexPathsForSelectedItems!.first!
        let product = products[indexPath.row]
        viewController.product = product
    }
}

// MARK: - UICollectionViewDataSource
extension ProductsViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "ProductCell"

        let product = products[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! ProductCollectionViewCell
        cell.label.text = product.title

        imageTasks[indexPath]?.cancel()

        if let url = product.imageURL {
            let task = session.dataTask(with: url, completionHandler: { [weak cell]
                (data, response, error) in

                if let error = error {
                    print("Image download failed: \(error)")
                    return
                }

                guard let cell = cell,
                    let data = data,
                    let image = UIImage(data: data) else {
                        print("Image download failed: invalid image data!")
                        return
                }
                DispatchQueue.main.async { [weak cell] in
                    guard let cell = cell else { return }
                    cell.imageView.image = image
                }
            })
            imageTasks[indexPath] = task
            task.resume()
        }
        return cell
    }
}
