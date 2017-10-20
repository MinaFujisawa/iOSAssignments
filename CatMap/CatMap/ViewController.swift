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
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=feadd15b72fc41f22223d740a0c346a5&tags=cat&has_geo=&extras=url_m&format=json&nojsoncallback=1")
        let urlRequest = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    if let photos = json ["photos"] as? [String: Any] {
                        if let photo = photos["photo"] as? [Dictionary<String, Any>] {
                            for i in 0...photo.count - 1 {
                                let title = photo[i]["title"] as? String
                                let id = photo[i]["id"] as? String
                                let url = photo[i]["url_m"] as? String
                                self.photoList.append(Photo(title: title, id: id, url: url))
                            }
                        }
                    }

                } catch {
                    print(error.localizedDescription)
                }
            }

        }
        task.resume()
    }

}
