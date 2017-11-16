//
//  TableViewController.swift
//  NetWorkingBasicJSON
//
//  Created by MINA FUJISAWA on 2017/10/18.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var repoNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://api.github.com/users/MinaFujisawa/repos")

        //specifying if this is a GET or POST request, or how we should cache data
        let urlRequest = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }

            if let data = data, let response = response {
                print(response)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    if let rows = json as? [[String: Any]] {
                        for row in rows {
                            let name = row["name"] ?? ""
                            print(name)
                            self.repoNames.append(name as! String)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                } catch {
                    print("error")
                }
            }
        }
        task.resume()

    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return repoNames.count


    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = repoNames[indexPath.row]

        return cell
    }
}
