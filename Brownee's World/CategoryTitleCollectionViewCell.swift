//
//  CategoryTitleCollectionViewCell.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 7/25/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
// class for each Educational Category cell (TriviaViewController)
class CategoryTitleCollectionViewCell: UICollectionViewCell {
    
    // Hidden labels for each collection view cell
    @IBOutlet weak var categoryLabel: UILabel!
    // Text labels for each collection view cell
    @IBOutlet weak var descriptionLabel: UILabel!
    // dog image for each collection view cell
    @IBOutlet weak var dogImage: UIImageView!
    
    var category: String? {
        didSet {
            self.categoryLabel.text = category
        }
    }
    
    var details: String? {
        didSet {
            self.descriptionLabel.text = details
        }
    }
    
    var image: UIImage? {
        didSet {
            self.dogImage.image = image
            self.dogImage.layer.cornerRadius = 4.0
            self.dogImage.clipsToBounds = true
        }
    }
}
