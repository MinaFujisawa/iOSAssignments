//
//  MyCollectionViewCell.swift
//  CatMap
//
//  Created by MINA FUJISAWA on 2017/10/23.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleBgView: UIView!
    @IBOutlet weak var image: UIImageView!
    
    private var effectView : UIVisualEffectView!
    private var mySegcon : UISegmentedControl!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let effect = UIBlurEffect(style: UIBlurEffectStyle.light)
        effectView = UIVisualEffectView(effect: effect)
        image.addSubview(effectView)
    }
}
