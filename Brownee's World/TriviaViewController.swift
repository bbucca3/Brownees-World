//
//  TriviaViewController.swift
//  Brownee's World
//
//  Created by Benjamin Bucca on 7/20/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//
import Foundation
import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import JSSAlertView
import SafariServices

class TriviaViewController: UIViewController {
    
    // titles of cells
    var specficCategories = ["Before Rescuing", "Visiting Shelters", "First Days Together", "Travelling", "Meeting Other Dogs", "Family Life", "Food Safety", "Home Safety", "Commitments"]
    // links to cells
    var descriptionCategories = ["Before Rescuing", "Visiting Shelters", "First Days Together", "Travelling", "Meeting Other Dogs", "Family Life", "Food Safety", "Home Safety", "Commitments"]
    
    var dogImages = ["dog1", "dog2", "dog3", "dog4", "dog5", "dog6", "dog7", "dog8", "dog9"]
    
    // key : String, value : struct Question array
    var allQuestionsDictionary = [String:[Question]]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topColor = UIColorFromHex(0xFFF7F0, alpha: 1.0)
        let bottomColor = UIColorFromHex(0xECDACC, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        loaddata()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //comment 
    }
    
    // load json data from local file
    func loaddata() -> [Question] {
        guard let jsonURL = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("Could not find json!")
            return []
        }
        
        
        let jsonData = try? Data(contentsOf: jsonURL)
        // Enter SwiftyJSON!
        // questionsData now contains a JSON object representing all the data in the JSON file.
        let questionsData = JSON(data: jsonData! as Data)
        // loop over questionsData.arrayValue
        let allQuestionsData = questionsData["questions"].arrayValue
        // create a var for every single question allQuestions: array of struct Question
        var allQuestions: [Question] = []
        
        for question in allQuestionsData {
            // each currentQuestion equals a new Question struct
            let currentQuestion = Question(json: question)
            // add/append each struct into allQuestions array
            allQuestions.append(currentQuestion)
        }
        
        // Question arrays
        var beforeArray = [Question]()
        var travelArray = [Question]()
        var visitingArray = [Question]()
        var otherDogsArray = [Question]()
        var firstDaysArray = [Question]()
        var familyArray = [Question]()
        var homeSafeArray = [Question]()
        var foodSafeArray = [Question]()
        var commitmentsArray = [Question]()
        
        // looping through allQuestions to split questions into separate arrays based on category
        for question in allQuestions {
            if(question.category.contains("Travelling")){
                travelArray.append(question)
            }
            if(question.category.contains("Before Rescuing")){
                beforeArray.append(question)
            }
            if(question.category.contains("Visiting Shelters")){
                visitingArray.append(question)
            }
            if(question.category.contains("Meeting Other Dogs")){
                otherDogsArray.append(question)
            }
            if(question.category.contains("First Days Together")){
                firstDaysArray.append(question)
            }
            if(question.category.contains("Family Life")){
                familyArray.append(question)
            }
            if(question.category.contains("Home Safety")){
                homeSafeArray.append(question)
            }
            if(question.category.contains("Food Safety")){
                foodSafeArray.append(question)
            }
            if(question.category.contains("Commitments")){
                commitmentsArray.append(question)
            }
        }
        // Sort arrays into dictionary based on String of category = question array
        self.allQuestionsDictionary["Travelling"] = travelArray
        self.allQuestionsDictionary["Before Rescuing"] = beforeArray
        self.allQuestionsDictionary["Visiting Shelters"] = visitingArray
        self.allQuestionsDictionary["Meeting Other Dogs"] = otherDogsArray
        self.allQuestionsDictionary["First Days Together"] = firstDaysArray
        self.allQuestionsDictionary["Family Life"] = familyArray
        self.allQuestionsDictionary["Food Safety"] = foodSafeArray
        self.allQuestionsDictionary["Home Safety"] = homeSafeArray
        self.allQuestionsDictionary["Commitments"] = commitmentsArray
        
        return allQuestions
        
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
                    let selectedCategory = specficCategories[selectedIndexPath.row]
                    // pass that array to the destination view controller
                    if let questionViewController = segue.destination as? QuestionViewController {
                        questionViewController.questionArray = allQuestionsDictionary[selectedCategory]!
                    }
                    
                }
            }
        }
    }
    
}

extension TriviaViewController : UICollectionViewDataSource {    
    // set the number of individual collection view cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specficCategories.count
    }
    
    // set properties of each individual cell
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cast cell as custom CategoryTitleCollectionViewCell so it has label
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath as IndexPath) as! CategoryTitleCollectionViewCell
        
        // set labels of each cell to be String index of specificCategories array
        cell.category = specficCategories[indexPath.row]
        cell.details = descriptionCategories[indexPath.row]
        cell.image =  UIImage(named: dogImages[indexPath.row])
        
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 5
        return cell
    }
    
    
}

extension TriviaViewController : UICollectionViewDelegateFlowLayout {
    // Function called when cell of collection view is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // trigger our segue!
        self.performSegue(withIdentifier: "triviaSegue", sender: self)
    }
}
