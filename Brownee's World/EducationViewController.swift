//  EducationViewController.swift
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

class EducationViewController: UIViewController {
    
    //MARK: Properties
    
    // Titles for cells
    let descriptionCategories = ["Before Rescuing", "Visiting Shelters", "First Days Together", "Travelling", "Meeting Other Dogs", "Family Life", "Food Safety", "Home Safety", "Commitments"]
    // Images for cells
    let dogImages = ["dog1", "dog2", "dog3", "dog4", "dog5", "dog6", "dog7", "dog8", "dog9"]
    // Create dictionary where each key : String, value : struct Question array
    var allQuestionsDictionary = [String:[Question]]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Custom background gradient
        let topColor = UIColorFromHex(0xFFF7F0, alpha: 1.0)
        let bottomColor = UIColorFromHex(0xECDACC, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Populate json data for questions
        _ = loaddata()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Load json data from local file
    func loaddata() -> Bool {
        guard let jsonURL = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("Could not find json!")
            return false
        }
        // Load json data from jsonURL
        let jsonData = try? Data(contentsOf: jsonURL)
        // questionsData now contains a JSON object representing all the data in the JSON file.
        let questionsData = try? JSON(data: jsonData! as Data)
        // Loop over questionsData.arrayValue
        let allQuestionsData = questionsData!["questions"].arrayValue
        // Create array to hold all Question
        var allQuestions: [Question] = []
        
        for question in allQuestionsData {
            // Each currentQuestion equals a new Question struct
            let currentQuestion = Question(json: question)
            // Add each struct into allQuestions array
            allQuestions.append(currentQuestion)
        }
        
        // Create Question arrays
        var beforeArray = [Question]()
        var travelArray = [Question]()
        var visitingArray = [Question]()
        var otherDogsArray = [Question]()
        var firstDaysArray = [Question]()
        var familyArray = [Question]()
        var homeSafeArray = [Question]()
        var foodSafeArray = [Question]()
        var commitmentsArray = [Question]()
        
        // Loop through allQuestions to fill separate arrays based on category
        for question in allQuestions {
            
            switch question.category {
            case "Travelling":
                travelArray.append(question)
            case "Before Rescuing":
                beforeArray.append(question)
            case "Visiting Shelters":
                visitingArray.append(question)
            case "Meeting Other Dogs":
                otherDogsArray.append(question)
            case "First Days Together":
                firstDaysArray.append(question)
            case "Family Life":
                familyArray.append(question)
            case "Home Safety":
                homeSafeArray.append(question)
            case "Food Safety":
                foodSafeArray.append(question)
            case "Commitments":
                commitmentsArray.append(question)
            default:
                print("Error appending question")
            }
            
        }
        // Populate dictionary based on String: category = question array
        self.allQuestionsDictionary["Travelling"] = travelArray
        self.allQuestionsDictionary["Before Rescuing"] = beforeArray
        self.allQuestionsDictionary["Visiting Shelters"] = visitingArray
        self.allQuestionsDictionary["Meeting Other Dogs"] = otherDogsArray
        self.allQuestionsDictionary["First Days Together"] = firstDaysArray
        self.allQuestionsDictionary["Family Life"] = familyArray
        self.allQuestionsDictionary["Food Safety"] = foodSafeArray
        self.allQuestionsDictionary["Home Safety"] = homeSafeArray
        self.allQuestionsDictionary["Commitments"] = commitmentsArray
        
        return true
    }
    
    // MARK: - Navigation
    
    @IBAction func cancelSegue(_ segue: UIStoryboardSegue) {
    
    }
    
    @IBAction override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "triviaSegue" {
                // figure out which cell was selected
                if let selectedIndexPath = collectionView.indexPathsForSelectedItems?[0] {
                    // grab the array of questions matching the category that was selected
                    let selectedCategory = descriptionCategories[selectedIndexPath.row]
                    // pass that array to the destination view controller
                    if let questionViewController = segue.destination as? QuestionViewController {
                        questionViewController.questionArray = allQuestionsDictionary[selectedCategory]!
                    }
                    
                }
            }
        }
    }
    
}

// MARK: - Extensions

extension EducationViewController : UICollectionViewDataSource {
    // Set the number of individual collection view cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return descriptionCategories.count
    }
    
    // Set properties of each individual cell
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cast cell as custom EducationCollectionViewCell so it has label
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "educationCell", for: indexPath as IndexPath) as! EducationCollectionViewCell
        
        // Set details of each cell to be String index of descriptionCategories array
        cell.details = descriptionCategories[indexPath.row]
        // Set image of each cell to be String index of dogImages array
        cell.image =  UIImage(named: dogImages[indexPath.row])
        // Style cell
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
    
}

extension EducationViewController : UICollectionViewDelegateFlowLayout {
    // Function called when cell of collection view is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Trigger segue
        self.performSegue(withIdentifier: "triviaSegue", sender: self)
    }
}
