//
//  CategoryTitleCollectionViewCell.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 7/25/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit

class CategoryTitleCollectionViewCell: UICollectionViewCell {
    
    // Labels for each collection view cell
    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    
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
