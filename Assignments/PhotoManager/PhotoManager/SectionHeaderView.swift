//
//  SectionHeaderView.swift
//  PhotoManager
//
//  Created by MINA FUJISAWA on 2017/10/18.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    var title: String? {
        didSet {
            headerLabel.text = title
        }
    }
}
