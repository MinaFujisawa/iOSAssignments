//
//  PageViewController.swift
//  AVStoryBook
//
//  Created by MINA FUJISAWA on 2017/10/19.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var pageCollection: [UIViewController]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let page1 = Page(image: nil, recordURL: nil)
        let page2 = Page(image: nil, recordURL: nil)
        let page3 = Page(image: nil, recordURL: nil)
        let page4 = Page(image: nil, recordURL: nil)
        let page5 = Page(image: nil, recordURL: nil)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let storyPartViewController1 = storyboard.instantiateViewController(withIdentifier: "storyPage") as! StoryPartViewController
        storyPartViewController1.page = page1

        let storyPartViewController2 = storyboard.instantiateViewController(withIdentifier: "storyPage") as! StoryPartViewController
        storyPartViewController2.page = page2

        let storyPartViewController3 = storyboard.instantiateViewController(withIdentifier: "storyPage") as! StoryPartViewController
        storyPartViewController3.page = page3

        let storyPartViewController4 = storyboard.instantiateViewController(withIdentifier: "storyPage") as! StoryPartViewController
        storyPartViewController4.page = page4

        let storyPartViewController5 = storyboard.instantiateViewController(withIdentifier: "storyPage") as! StoryPartViewController
        storyPartViewController5.page = page5

        pageCollection = [storyPartViewController1, storyPartViewController2, storyPartViewController3,
            storyPartViewController4, storyPartViewController5]
        
        self.setViewControllers([storyPartViewController1], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = pageCollection.index(of: viewController) else { return nil }
        if (index-1 < 0) {
            return nil;
        }
        return pageCollection[index-1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageCollection.index(of: viewController) else { return nil }
        if (index+1 >= pageCollection.count) {
            return nil;
        }
        return pageCollection[index+1]
    }
}
