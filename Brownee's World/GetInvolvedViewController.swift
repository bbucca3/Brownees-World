//
//  GetInvolvedViewController.swift
//  Brownee's World
//
//  Created by Benjamin Bucca on 7/20/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.

import Foundation
import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import JSSAlertView
import SafariServices

class GetInvolvedViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate{
    // zip code search
    @IBOutlet weak var zipSearch: UITextField!
    // radius selector
    @IBOutlet weak var radiusSelect: UISegmentedControl!
    // map kit map view
    @IBOutlet weak var mapView: MKMapView!
    // array of annotations for mapView
    var pinsArray: [MKPointAnnotation] = []
    
    @IBAction func searchMapButton(_ sender: UIButton) {
        OperationQueue.main.cancelAllOperations()
        // remove all annotations from map and clear pinsArray
        mapView.removeAnnotations(mapView.annotations)
        self.pinsArray.removeAll()
        // call function to check zipcode
        // print("Search Button Pressed")
        _ = textFieldShouldReturn(zipSearch)
    }
    
    @IBAction func clearMapButton(_ sender: UIButton) {
        OperationQueue.main.cancelAllOperations()
        // removes all annotations from map and clear pinsArray
        mapView.removeAnnotations(mapView.annotations)
        self.pinsArray.removeAll()
        // resets map to North America region
        let regionNorthAmerica = mapView.regionThatFits(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(46.828, -101.759), 4900000, 4900000))
        mapView.region = regionNorthAmerica
        // clears zipcode entry field
        zipSearch.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        zipSearch.delegate = self
        // customize search field with house image on left
        zipSearch.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let image = UIImage(named: "dog_house_tab_filled")
        imageView.image = image
        zipSearch.leftView = imageView
        // custom background gradient
        let topColor = UIColorFromHex(0xFFF7F0, alpha: 1.0)
        let bottomColor = UIColorFromHex(0xECDACC, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // func checks ZIP code text for 5 digits exact
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // cast text from textfield as an int otherwise string will be nil
        let enteredText = Int(textField.text!)
        // if the UITextField for zipcode is empty AND without 5 characters
        if ((textField.text != nil && textField.text?.characters.count != 5) || enteredText == nil) {
            // show error message modal
            DispatchQueue.main.async { [unowned self] in
                JSSAlertView().show(
                    self,
                    title: "Error",
                    text: "Please Enter a 5 Digit ZIP Code",
                    buttonText: "Ok",
                    color: UIColorFromHex(0xED3F3B, alpha: 0.65))
            }
        }
        else {
            // function to drop keyboard on return
            _ = textFieldShouldClear(zipSearch)
            // function to send zipcode to API call
            requestSheltersForZipcode(textField.text!)
        }
        return true
    }
    
    // function to make keyboard go down when (zipcode entered) return is pressed
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        zipSearch.resignFirstResponder()
        return true
    }
    
    func requestSheltersForZipcode(_ zipcode: String) {
        // remove all annotations from map and clear pinsArray
        mapView.removeAnnotations(mapView.annotations)
        
        let resultLimit: String = "50"
        var radiusInput: String = "0"
        
        switch radiusSelect.selectedSegmentIndex {
        case 0:
            radiusInput = "5"
        case 1:
            radiusInput = "10"
        case 2:
            radiusInput = "15"
        case 3:
            radiusInput = "20"
        default:
            break
        }
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            "postman-token": "26660d94-985f-be19-5477-10f48cf5f578"
        ]
        let parameters = [
            "apikey": "m5bDD5yd",
            "objectType": "orgs",
            "objectAction": "publicSearch",
            "search": [
                "resultStart": "0",
                "resultLimit": resultLimit,
               
                "filters": [
                    [
                        "fieldName": "orgLocationDistance",
                        "operation": "radius",
                        "criteria": radiusInput
                    ],
                    [
                        "fieldName": "orgLocation",
                        "operation": "equals",
                        "criteria": zipcode
                    ]
                ],
                "fields": ["orgID", "orgLocation", "orgName", "orgAddress", "orgCity", "orgState", "orgPostalcode", "orgCountry", "orgPhone", "orgEmail", "orgWebsiteUrl", "orgAbout", "orgServices", "orgType", "orgLocationDistance"]
            ]
        ] as [String : Any]
        
        // array of (struct) Organization objects fed from API call
        var allOrganizations: [Organization] = []
        // API request address
        let apiToContact = "https://api.rescuegroups.org/http/v2.json"
        
        Alamofire.request(apiToContact, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON() { [unowned self] response in
            // In the closure handle success and failure with a switch statement
            switch response.result {
            // If successful, create a JSON object from the response.result's value
            case .success:
                if let value = response.result.value {
                    //print(value)
                    let json = JSON(value)
                    let resultsDictionary = json.dictionaryValue
                    print("RESULTS: ", resultsDictionary)
                    
                    // checks for errors within json response object before populating dictionary of search results
                    if( resultsDictionary["foundRows"] == 0 || resultsDictionary["status"] == "error" ) {
                        // show error message modal
                        DispatchQueue.main.async { [unowned self] in
                            JSSAlertView().show(
                                self,
                                title: "0 Results Found",
                                text: "Please try searching with another zipcode.",
                                buttonText: "Ok",
                                color: UIColorFromHex(0xED3F3B, alpha: 0.65))
                        }
                    }
                    
                    if let dataDictionary = resultsDictionary["data"]?.dictionaryValue {
                        
                        for (_, value) in dataDictionary {
                            // construction an Organization object, passing in the value(s) to the initializer
                            let currentOrg = Organization(json: value)
                            //print(currentOrg)
                            // add each currentOrg object to the allOrganizations (fed Organization struct) array
                            allOrganizations.append(currentOrg)
                        }
                    }
                    //print(allOrganizations)
                    // geoCoder object handles locating orgs based on data from API call
                    let geoCoder = CLGeocoder()
                    // object holds each annotation-creation operation
                    let operationQueue = OperationQueue()
                    
                    // sets number of able concurrent operations
                    operationQueue.maxConcurrentOperationCount = 1
                    // runs at end of operation
                    let completionOperation = BlockOperation(block: {
                        // display all pin annotations on map
                        self.mapView.showAnnotations(self.pinsArray, animated: false)
                        operationQueue.cancelAllOperations()
                        
                    })
                    
                    // loop through each org to create geocode operation
                    for org in allOrganizations {
                        
                        if (org.address != "") {
                            
                            let operation = BlockOperation(block: {
                                
                                let semaphore = DispatchSemaphore(value: 0);
                                
                                let orgLocation = org.address + " " + org.city + " " + org.state + " " + org.zipcode + " " + org.country
                                
                                geoCoder.geocodeAddressString(orgLocation, completionHandler: { placemarks, error in
                                    if error != nil {
                                        //print(error?.localizedDescription.)
                                        OperationQueue.main.cancelAllOperations()
                                        // show error message modal
                                        DispatchQueue.main.async() { [unowned self] in
                                            JSSAlertView().show(
                                                self,
                                                title: "Error",
                                                text: "Search Overload (Please Wait 60 seconds Before Searching Again).",
                                                buttonText: "Ok",
                                                color: UIColorFromHex(0x942522, alpha: 0.85))
                                        }
                                        print("error inside geoCoder", error!)
                                        return
                                    }
                                    
                                    if let placemarks = placemarks {
                                        
                                        // Get the first placemark
                                        let placemark = placemarks[0]
                                        // Add annotation
                                        if let location = placemark.location {
                                            
                                            let pointAnnotation = MKPointAnnotation()
                                            pointAnnotation.coordinate = location.coordinate
                                            
                                            pointAnnotation.title = org.name
                                            
                                            if (org.website == "http://" || org.website == "" || org.website == " "){
                                                pointAnnotation.subtitle = "No Website Found"
                                            }
                                            else {
                                                pointAnnotation.subtitle = org.website
                                            }
                                            // append newly created annotation to array.
                                                self.pinsArray.append(pointAnnotation)
                                        }
                                    }
                                    semaphore.signal()
                                })
                                // replace d_time with FOREVER
                                _ = semaphore.wait(timeout: DispatchTime.distantFuture)
                                
                            })
                            // completionOperation dependent on each operation
                            completionOperation.addDependency(operation)
                            // add each operation to queue
                            operationQueue.addOperation(operation)
                        }
                    }
                    
                    OperationQueue.main.addOperation(completionOperation)
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }

    }
    
    // function that creates custom annotation pin properties
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) ->
        MKAnnotationView? {
            
            let identifier = "MyPin"
            if annotation.isKind(of: MKUserLocation.self) {
                return nil
            }
            // Reuse the annotation if possible
            var annotationView:MKPinAnnotationView? =
                mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as?
            MKPinAnnotationView
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation,
                                                     reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            }
            // sets icon in each pin description
            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
            leftIconView.image = UIImage(named: "dog_house_tab_filled")
            annotationView?.leftCalloutAccessoryView = leftIconView
            // sets pin tint color for each
            annotationView?.pinTintColor = UIColorFromHex(0x442C1D)
            // sets callout visible
            annotationView!.canShowCallout = true
            annotationView!.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            // sets color for callout disclosure
            annotationView!.rightCalloutAccessoryView?.tintColor = UIColorFromHex(0x442C1D)
            return annotationView
    }
    
    
    // function that creates modal when tapping on callout disclosure
    // modal contains shelter name and possible website
    func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // specific annotation callout control tapped
        if control == annotationView.rightCalloutAccessoryView {
            let title = annotationView.annotation?.title ?? ""
            var text = annotationView.annotation?.subtitle ?? ""
            
            // function that opens website
            func visitwebSiteCallback() {
                // check for http prefix
                if ( text?[(text?.startIndex)!] != "h") {
                    text = "http://www"+text!
                }
                
                guard let url = URL(string: text!) else {
                    return //be safe
                }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            
            // sets custom icon for modal
            let customIcon:UIImage! = UIImage(named: "dog_house_tab_filled")
            // modal for no website
            if(text == "No Website Found"){
                // Modal view for each org detail disclosure with website
                DispatchQueue.main.async { [unowned self] in
                    let alertView = JSSAlertView().show(
                        self,
                        title: title ?? "",
                        text: text ?? "",
                        buttonText: "Close",
                        color: UIColorFromHex(0xFFF7F0, alpha: 0.95),
                        iconImage: customIcon)
                    alertView.setTitleFont("Helvetica")
                    alertView.setTextFont("Helvetica")
                    alertView.setButtonFont("Helvetica")
                }
            }
            // modal for website
            else {
                // Modal view for each org detail disclosure with website
                DispatchQueue.main.async { [unowned self] in
                    let alertView = JSSAlertView().show(
                        self,
                        title: title ?? "",
                        text: text ?? "",
                        buttonText: "Open Link",
                        cancelButtonText: "Close", // two-button alert
                        color: UIColorFromHex(0xFFF7F0, alpha: 0.95),
                        iconImage: customIcon)
                    alertView.setTitleFont("Helvetica")
                    alertView.setTextFont("Helvetica")
                    alertView.setButtonFont("Helvetica")
                    alertView.addAction(visitwebSiteCallback)
                }
            }
        }
    }
    
    // function that drops keyboard upon single screen tap
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

