//
//  SuppliesTableViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/13/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
import SafariServices
import JSSAlertView


class SuppliesTableViewController: UITableViewController {
    
    var suppliesList = ["All Kinds of Pet Food", "Newspaper", "Paper Towels", "Trash Bags", "Blankets", "Dog Toys", "Pig Ear Chews", "Laundry Detergent", "Leashes", "Sheets (New or Used)"]
    
    var supplyImages = ["tableCell_dogbowl", "tableCell_news", "tableCell_paper", "tableCell_trash", "tableCell_blanket", "tableCell_toy", "tableCell_pig", "tableCell_laundry", "tableCell_dogleash", "tableCell_sheets"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return suppliesList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create each cell custom SuppliesTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SuppliesTableViewCell
        // sets each cell label
        cell.categorySupply = suppliesList[indexPath.row]
        // sets each cell image
        cell.imageSupply = UIImage(imageLiteral: supplyImages[indexPath.row])
        // border details for each cell
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 35
        // custom background gradient
        let topColor = UIColorFromHex(0xFFF7F0, alpha: 1.0)
        let bottomColor = UIColorFromHex(0xECDACC, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
