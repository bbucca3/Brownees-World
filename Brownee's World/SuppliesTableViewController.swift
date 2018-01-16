//  SuppliesTableViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/13/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.

import UIKit
import SafariServices
import JSSAlertView

class SuppliesTableViewController: UITableViewController {
    
    var suppliesList = ["All Kinds of Pet Food", "Newspaper", "Paper Towels", "Trash Bags", "Blankets", "Dog Toys", "Pig Ear Chews", "Laundry Detergent", "Leashes", "Sheets (New or Used)"]
    
    var supplyImages = ["tableCell_dogbowl", "tableCell_news", "tableCell_paper", "tableCell_trash", "tableCell_blanket", "tableCell_toy", "tableCell_pig", "tableCell_laundry", "tableCell_dogleash", "tableCell_sheets"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // sets nav bar color to match home tab bar
        self.navigationController?.toolbar.barTintColor = UIColorFromHex(0xFFF7F2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // function for back button press
    @IBAction func backToInfo(_ sender: Any) {
        // print("Hello from backToInfo press!")
        performSegue(withIdentifier: "unwindToInfo", sender: self)
    }
    // function for home button press
    @IBAction func infoToHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return suppliesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create each cell custom SuppliesTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! SuppliesTableViewCell
        // sets each cell label
        cell.categorySupply = suppliesList[indexPath.row]
        // sets each cell image
        cell.imageSupply = UIImage(named: supplyImages[indexPath.row])
        // border details for each cell
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 35
        return cell
    }
}
