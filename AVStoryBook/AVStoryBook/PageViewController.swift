//
//  PageViewController.swift
//  AVStoryBook
//
//  Created by MINA FUJISAWA on 2017/10/19.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var index : Int!
    var pages = [Page(image: nil, recordURL: nil), Page(image: nil, recordURL: nil) , Page(image: nil, recordURL: nil),
                 Page(image: nil, recordURL: nil), Page(image: nil, recordURL: nil)]
    let pageNum = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for _ in 0...pageNum{
//            pages.append(Page(image: nil, recordURL: nil))
//        }

        index = 0
        self.setViewControllers([getStoryPartVC()!], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    func getStoryPartVC() -> StoryPartViewController? {
        if 0 <= index && index <= 5{
            let vc =  storyboard!.instantiateViewController(withIdentifier: "ViewController") as! StoryPartViewController
            vc.page = pages[index]
            vc.pageIndex = index
            print(index)
            return vc
        }
        return nil
    }
}

extension PageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // ???: why not woking?
//        index -= 1
        index = index - 1
        return getStoryPartVC()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        index = index + 1
        return getStoryPartVC()
    }
}
