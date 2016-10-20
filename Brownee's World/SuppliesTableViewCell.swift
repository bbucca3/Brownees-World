//
//  SuppliesTableViewCell.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/13/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
// class for each cell for donation items (SuppliesTableViewController)
class SuppliesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCell: UILabel!
    
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
