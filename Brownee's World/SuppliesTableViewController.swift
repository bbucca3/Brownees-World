//  SuppliesTableViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/13/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.

import UIKit
import SafariServices
import JSSAlertView

class SuppliesTableViewController: UITableViewController {
    
    //MARK: Properties
    
    let suppliesList = ["All Kinds of Pet Food", "Newspaper", "Paper Towels", "Trash Bags", "Blankets", "Dog Toys", "Pig Ear Chews", "Laundry Detergent", "Leashes", "Sheets (New or Used)"]
    
    let supplyImages = ["tableCell_dogbowl", "tableCell_news", "tableCell_paper", "tableCell_trash", "tableCell_blanket", "tableCell_toy", "tableCell_pig", "tableCell_laundry", "tableCell_dogleash", "tableCell_sheets"]
    
    // Back button press
    @IBAction func backToInfo(_ sender: Any) {
        performSegue(withIdentifier: "unwindToInfo", sender: self)
    }
    // Home button press
    @IBAction func infoToHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set nav bar color to root tab bar
        self.navigationController?.toolbar.barTintColor = UIColorFromHex(0xFFF7F2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suppliesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create each cell as custom SuppliesTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "supplyCell", for: indexPath as IndexPath) as! SuppliesTableViewCell
        // Set each cell label
        cell.categorySupply = suppliesList[indexPath.row]
        // Check invalid asset name error
        if(supplyImages.count > 0) {
            // Set each cell image
           cell.imageSupply = UIImage(named: supplyImages[indexPath.row])
        }        
        // Style cell
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 35
        return cell
    }
}
