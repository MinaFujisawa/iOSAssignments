//
//  FlickerAPI.swift
//  CatMap
//
//  Created by MINA FUJISAWA on 2017/10/21.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import Foundation
import MapKit

class FlickerAPI {
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
                                let id = photo[i]["id"] as! String
                                let urlString = photo[i]["url_m"] as! String
                                let url = URL(string: urlString)!
                                self.fetchCoordinate(id: id) { (coordinate) in
                                    self.fetchTags(id: id) { (tagList) in
                                        photoList.append(Photo(title: title, id: id, url: url, coordinate: coordinate, tags: tagList))
                                        DispatchQueue.main.async {
                                            completion(photoList)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        getBasicInfotask.resume()
    }

    static func fetchCoordinate(id: String, completion: @escaping (CLLocationCoordinate2D) -> ()) {
        var coordinate = CLLocationCoordinate2D()
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=feadd15b72fc41f22223d740a0c346a5&photo_id=" + id + "&format=json&nojsoncallback=1&")!
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
                            coordinate = CLLocationCoordinate2D(latitude: lan, longitude: lon)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(coordinate)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    static func fetchTags(id: String, completion: @escaping ([String]) -> ()) {
        var tagList = [String]()
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.tags.getListPhoto&api_key=feadd15b72fc41f22223d740a0c346a5&photo_id=" + id + "&format=json&nojsoncallback=1&")!

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
                    
                    if let photos = json["photo"] as? [String: Any] {
                        if let tags = photos["tags"] as? [String: Any] {
                            if let tag = tags["tag"] as? [[String: Any]] {
                                for i in 0...tag.count - 1 {
                                    let tag = tag[i]["raw"] as? String
                                    if let tag = tag {
                                        tagList.append(tag)
                                    }
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        completion(tagList)
                    }

                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
