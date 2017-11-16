//
//  SearchViewController.swift
//  CatMap
//
//  Created by MINA FUJISAWA on 2017/11/01.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var allPhotos: [Photo]!
    var allTags: [String]!
//    var allTags = ["aa", "bb", "ccc"]
    let searchController = UISearchController(searchResultsController: nil)
    var filteredTags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.isActive = true
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search by tag"
        
        // Prevent overlaps
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
    }

    // MARK: navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredTags = allTags.filter({ (tag: String) -> Bool in
            return tag.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }

    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredTags.count
        }

        return allTags.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        let tag: String
        if isFiltering() {
            tag = filteredTags[indexPath.row]
        } else {
            tag = allTags[indexPath.row]
        }
        cell.label.text = tag
        return cell
    }


    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: send back data
        
        navigationController?.popViewController(animated: true)
    }
}
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
}
