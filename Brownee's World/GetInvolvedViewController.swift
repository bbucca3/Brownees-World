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
    
    @IBOutlet weak var zipSearch: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var pinsArray: [CustomPointAnnotation] = []
    
    @IBAction func clearMapButton(sender: UIButton) {
        pinsArray = []
        mapView.removeAnnotations(pinsArray)
        
        let worldRegion = MKCoordinateRegionForMapRect(MKMapRectMake(20.0, 20.0, 500.0, 500.0))
        
        mapView.region = worldRegion
        
    }
    
    // function to make keyboard go down when return is pressed
    func textFieldShouldClear(textField: UITextField) -> Bool {
        zipSearch.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        zipSearch.delegate = self
        
        // custom styling for search field
        zipSearch.leftViewMode = UITextFieldViewMode.Always
        let imageView = UIImageView(frame: CGRectMake(0, 0, 25, 25))
        let image = UIImage(named: "dog_house_tab_filled")
        imageView.image = image
        zipSearch.leftView = imageView
        
        let topColor = UIColorFromHex(0xFFF7F0, alpha: 1.0)
        let bottomColor = UIColorFromHex(0xECDACC, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // if the UITextField for zipcode is empty AND without 5 characters
        if ((textField.text != nil && textField.text?.characters.count != 5)) {
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                JSSAlertView().show(
                    self,
                    title: "Error",
                    text: "please clear map then enter 5 digit zip",
                    buttonText: "Ok",
                    color: UIColorFromHex(0x942522, alpha: 1))
            }            
            
        } else {
            // Clears array of annotations
            pinsArray.removeAll()
            // function to drop keyboard on return
            textFieldShouldClear(zipSearch)
            // function to send zipcode to API
            requestSheltersForZipcode(textField.text!)
        }

        return true
    }
    
    func requestSheltersForZipcode(zipcode: String) {
        
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
                "resultLimit": "100",
                "resultSort": "orgID",
                "resultOrder": "asc",
                "filters": [
                    [
                        "fieldName": "orgLocation",
                        "operation": "equals",
                        "criteria": zipcode
                    ],
                    [
                        "fieldName": "orgLocationDistance",
                        "operation": "radius",
                        "criteria": "20"
                    ]
                ],
                "fields": ["orgID", "orgLocation", "orgName", "orgAddress", "orgCity", "orgState", "orgPostalcode", "orgCountry", "orgPhone", "orgEmail", "orgWebsiteUrl", "orgAbout", "orgServices", "orgType", "orgLocationDistance"]
            ]
        ]
        
        
        var allOrganizations: [Organization] = []
        
        let apiToContact = "https://api.rescuegroups.org/http/v2.json"
        
        Alamofire.request(.POST, apiToContact, headers: headers, parameters: parameters, encoding: .JSON).validate().responseJSON() { [unowned self] response in
            //let httpResponse = response! as NSHTTPURLResponse
            
            print("response is\(response)")
            
            // In the closure handle success and failure with a switch statement
            switch response.result {
            // If successful, create a JSON object from the response.result's value
            case .Success:
                if let value = response.result.value {
                    //print(value)
                    let json = JSON(value)
                    let resultsDictionary = json.dictionaryValue
                    
                    if let dataDictionary = resultsDictionary["data"]?.dictionaryValue {
                        
                        for (_, value) in dataDictionary {
                            // construction an Organization object, passing in the value(s) to the initializer
                            let currentOrg = Organization(json: value)
                            // add each Organization object to the allOrganizations array
                            allOrganizations.append(currentOrg)
                        }
                    }
                    
                    let geoCoder = CLGeocoder()
                    // holds all operations one by one
                    let operationQueue = NSOperationQueue()
                    // sets number of concurrent operations
                    operationQueue.maxConcurrentOperationCount = 1
                    
                    // runs at the end of operations
                    let completionOperation = NSBlockOperation(block: { 
                        self.mapView.showAnnotations(self.pinsArray, animated: true)
                    })
                    
                    for org in allOrganizations {
                        
                        if org.address != "" {
                            
                            let operation = NSBlockOperation(block: {
                                
                                let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0);
                                
                                let orgLocation = org.address + " " + org.city + " " + org.state + " " + org.zipcode
                                
                               
                                
                                geoCoder.geocodeAddressString(orgLocation, completionHandler: { placemarks, error in
                                    if error != nil {
                                        print(error!)
                                        return
                                    }
                                    if let placemarks = placemarks {
                                        // Get the first placemark
                                        let placemark = placemarks[0]
                                        // Add annotation
                                        if let location = placemark.location {
                                            
                                            let pointAnnotation = CustomPointAnnotation()
                                            pointAnnotation.coordinate = location.coordinate
                                            //pointAnnotation.title = placemark.name
                                            pointAnnotation.title = org.name
                                            pointAnnotation.subtitle = orgLocation + "\n\n" + org.phone
                                                                                    
                                            // append newly created annotation to array.
                                            self.pinsArray.append(pointAnnotation)
                                            
                                            // Display the annotation
                                            self.mapView.showAnnotations(self.pinsArray, animated: true)
                                            // self.mapView.selectAnnotation(pointAnnotation, animated: true)
                                        }
                                    }
                                    dispatch_semaphore_signal(semaphore)
                                })
                                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
                                
                            })
                            // completionOperation dependent on each operation
                            completionOperation.addDependency(operation)
                            // add each operation to queue
                            operationQueue.addOperation(operation)
                        }
                    }
                    NSOperationQueue.mainQueue().addOperation(completionOperation)
                    
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }

    }
    
  
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) ->
        MKAnnotationView? {
            
            let identifier = "MyPin"
            if annotation.isKindOfClass(MKUserLocation) {
                return nil
            }
            // Reuse the annotation if possible
            var annotationView:MKPinAnnotationView? =
                mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as?
            MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation,
                                                     reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            }
            let leftIconView = UIImageView(frame: CGRectMake(0, 0, 35, 35))
            leftIconView.image = UIImage(named: "dog_house_tab_filled")
            annotationView?.leftCalloutAccessoryView = leftIconView
            
            annotationView?.pinTintColor = UIColorFromHex(0x7B492A)
            
            annotationView!.canShowCallout = true
            annotationView!.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            // Darkest brown color hex
            annotationView!.rightCalloutAccessoryView?.tintColor = UIColorFromHex(0x442C1D)
            
            
            
            
            return annotationView
    }
    
    
    
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            // print("Disclosure Pressed!")
            
            let title = annotationView.annotation?.title ?? ""
            let text = annotationView.annotation?.subtitle ?? ""
            //let website = annotationView.annotation?.website ?? ""
            
            let customIcon:UIImage! = UIImage(named: "dog_house_tab_filled")
            // Modal view for each org detail disclosure
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                // show the JSS Alert View here
                let alertView = JSSAlertView().show(
                    self,
                    title: title ?? "",
                    text: text ?? "",
                    buttonText: "Ok",
                    color: UIColorFromHex(0xFFF7F0, alpha: 0.95),
                    iconImage: customIcon)
                alertView.setTitleFont("Helvetica")
                alertView.setTextFont("Helvetica")
                alertView.setButtonFont("Helvetica")
            }
            
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // print("The screen was touched")
        self.view.endEditing(true)
    }
    
    
}

