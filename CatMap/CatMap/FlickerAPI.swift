//
//  FlickerAPI.swift
//  CatMap
//
//  Created by MINA FUJISAWA on 2017/10/21.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import Foundation
import MapKit

struct FlickerAPI {

    static func fetchBasicData(url: URL, completion: @escaping ([Photo]) -> ()) {
        var photoList = [Photo]()

        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let getBasicInfotask = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    if let photos = json ["photos"] as? [String: Any] {
                        if let photo = photos["photo"] as? [[String: Any]] {
                            for i in 0...photo.count - 1 {
                                let title = photo[i]["title"] as? String
                                let id = photo[i]["id"] as? String
                                let url = photo[i]["url_m"] as? String
//                                print(title)
                                photoList.append(Photo(title: title, id: id, url: url, coordinate: nil))
                            }
                        }
                    }

                    DispatchQueue.main.async {
                        completion(photoList)
                    }

                } catch {
                    print(error.localizedDescription)
                }
            }

        }
        getBasicInfotask.resume()
    }

    static func fetchCoordinate(photos: [Photo], completion: @escaping ([Photo]) -> ()) {
        var photoList = photos

        for index in 0...photoList.count - 1 {
            let id = photoList[index].id
            let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=feadd15b72fc41f22223d740a0c346a5&photo_id=" + id! + "&format=json&nojsoncallback=1&")!
            let urlRequest = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default)

            let task = session.dataTask(with: urlRequest) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }

                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                        if let photos = json ["photo"] as? [String: Any] {
                            if let location = photos["location"] as? [String: Any] {
                                let lan = Double (location["latitude"] as! String)!
                                let lon = Double (location["longitude"] as! String)!
                                let coordinate = CLLocationCoordinate2D(latitude: lan, longitude: lon)
                                photoList[index].coordinate = coordinate
                            }
                        }

                        DispatchQueue.main.async {
                            completion(photoList)
                        }

                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Photo has no location information?")
                }

            }
            task.resume()
        }

    }
}
