//
//  ViewController.swift
//  NetWorkingBasic
//
//  Created by MINA FUJISAWA on 2017/10/18.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iPhoneImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://i.imgur.com/CoQ8aNl.png")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        // Task that will actually download the image from the server
        let downloadTask = session.downloadTask(with: url!, completionHandler:  { url, response, error in
            if error != nil {
                //  Handle  the  error
                print(error!.localizedDescription)
                return
            }
            
            if let url = url {
                let data = NSData(contentsOf: url)
                OperationQueue.main.addOperation {
                    self.iPhoneImageView.image = UIImage(data: data! as Data)
                }
            }
        })
        
        downloadTask.resume()
    }
}

