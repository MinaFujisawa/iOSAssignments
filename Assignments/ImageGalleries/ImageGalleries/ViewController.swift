//
//  ViewController.swift
//  ImageGalleries
//
//  Created by MINA FUJISAWA on 2017/10/13.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!

    // Enable tapping the UIPageControl to scroll to the next page
    @IBAction func pageControl(_ sender: Any) {
        let pager = sender as! UIPageControl
        let page = pager.currentPage
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    var imageViews: [UIImageView]?

    override func viewDidLoad() {
        super.viewDidLoad()


        // MARK: layout
        let imageView1 = UIImageView(frame: CGRect.zero)
        let imageView2 = UIImageView(frame: CGRect.zero)
        let imageView3 = UIImageView(frame: CGRect.zero)

        imageView1.image = UIImage(named: "01")
        imageView2.image = UIImage(named: "02")
        imageView3.image = UIImage(named: "03")
        imageView1.backgroundColor = UIColor.black
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        imageView3.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView1)
        scrollView.addSubview(imageView2)
        scrollView.addSubview(imageView3)


        NSLayoutConstraint(item: imageView1, attribute: .width, relatedBy: .equal, toItem: nil,
                           attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: imageView1, attribute: .height, relatedBy: .equal, toItem: nil,
                           attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: imageView2, attribute: .width, relatedBy: .equal, toItem: nil,
                           attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: imageView2, attribute: .height, relatedBy: .equal, toItem: nil,
                           attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: imageView3, attribute: .width, relatedBy: .equal, toItem: nil,
                           attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint(item: imageView3, attribute: .height, relatedBy: .equal, toItem: nil,
                           attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true

        NSLayoutConstraint(item: imageView1, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1.0, constant: 8.0).isActive = true
        NSLayoutConstraint(item: imageView1, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 8.0).isActive = true

        NSLayoutConstraint(item: imageView2, attribute: .left, relatedBy: .equal, toItem: imageView1, attribute: .right, multiplier: 1.0, constant: 8.0).isActive = true
        NSLayoutConstraint(item: imageView2, attribute: .top, relatedBy: .equal, toItem: imageView1, attribute: .top, multiplier: 1.0, constant: 1.0).isActive = true

        NSLayoutConstraint(item: imageView3, attribute: .left, relatedBy: .equal, toItem: imageView2, attribute: .right, multiplier: 1.0, constant: 8.0).isActive = true
        NSLayoutConstraint(item: imageView3, attribute: .top, relatedBy: .equal, toItem: imageView1, attribute: .top, multiplier: 1.0, constant: 1.0).isActive = true

        // MARK: Gesture
        imageViews = [imageView1, imageView2, imageView3]
        for (index, iv) in imageViews!.enumerated() {
            iv.tag = index + 1
            iv.isUserInteractionEnabled = true
        }

        let gestureRec = UITapGestureRecognizer(target: self, action: #selector (self.tapped (_:)))
        scrollView.addGestureRecognizer(gestureRec)

        // MARK: Page Controll
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 3, height: scrollView.frame.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        pageControl.currentPage = 0
    }

    @objc func tapped(_ sender: UITapGestureRecognizer) {
        let view = sender.view
        let loc = sender.location(in: view)
        let subview = view?.hitTest(loc, with: nil)

        if (subview?.tag)! > 0 {
            performSegue(withIdentifier: "GoToDetail", sender: subview)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            guard let imageView = sender as? UIImageView else { return }
            let destVC = segue.destination as! DetailViewController
            destVC.image = imageView.image
        }
    }



}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
//        floor((_scrollView.contentOffset.x – pageWidth / 2) / pageWidth ) + 1;
        pageControl.currentPage = Int((floor(scrollView.contentOffset.x - pageWidth / 2)) / pageWidth + 1)
    }

}
