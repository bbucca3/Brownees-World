//
//  InfoViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/11/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
import SafariServices
class InfoViewController: UIViewController {

    
    @IBAction func donateButton(sender: AnyObject) {
        
        if let url = NSURL(string:
            "http://animalassistance.org/donate.html") {
            let safariController = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
            presentViewController(safariController, animated: true, completion: nil)
        }
        
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
