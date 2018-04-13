//
//  SuppliesTableViewCell.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/13/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit

class SuppliesTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    // text
    @IBOutlet weak var labelCell: UILabel!
    // image
    @IBOutlet weak var supplyImage: UIImageView!
    
    var categorySupply: String? {
        didSet {
            self.labelCell.text = categorySupply
        }
    }
    
    var imageSupply: UIImage? {
        didSet {
            self.supplyImage.image = imageSupply
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
