//
//  EducationCollectionViewCell.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 7/25/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit

class EducationCollectionViewCell: UICollectionViewCell {
    
    // Text label for each collection view cell
    @IBOutlet weak var descriptionLabel: UILabel!
    // dog image for each collection view cell
    @IBOutlet weak var dogImage: UIImageView!
    
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
