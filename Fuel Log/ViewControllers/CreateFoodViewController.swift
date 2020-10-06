//
//  FoodCreatorViewController.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-04.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
import UIKit

protocol CreateFoodViewDelegate {
    func knownFoodEntry(foodItem: Food)
}

class CreateFoodViewController: UIViewController {
    var delegate: CreateFoodViewDelegate?
    
    

    @IBOutlet weak var mealNameTextField: UITextField!
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var carbTextField: UITextField!
    @IBOutlet weak var fatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealNameTextField.delegate = self
        calorieTextField.delegate = self
        proteinTextField.delegate = self
        carbTextField.delegate = self
        fatTextField.delegate = self
        
    }
    
    @IBAction func createFoodItem(_ sender: Any) {
        guard let foodText = mealNameTextField.text, foodText.count > 0,
            let caloriesText = calorieTextField.text, caloriesText.count > 0,
            let proteinText = proteinTextField.text, proteinText.count > 0,
            let carbText = carbTextField.text, carbText.count > 0,
            let fatText = fatTextField.text, fatText.count > 0 else {
                 displayError(erroTitle: "Error", errorMessage: "Missing required attributes.")
                 return
         }
         
         
         guard let name = foodText as String? else {
             displayError(erroTitle: "Error", errorMessage: "Invalid meal name.")
             return
         }
         
         guard let calories = Int(caloriesText) else {
             displayError(erroTitle: "Error", errorMessage: "Invalid calorie entry.")
             return
         }
        
        guard let protein = Int(proteinText) else {
            displayError(erroTitle: "Error", errorMessage: "Invalid protein entry.")
            return
        }
        
        guard let carbs = Int(carbText) else {
            displayError(erroTitle: "Error", errorMessage: "Invalid carbohydrate entry.")
            return
        }
        
        guard let fats = Int(fatText) else {
            displayError(erroTitle: "Error", errorMessage: "Invalid fat entry.")
            return
        }
         
         let newFood = Food(foodName: name, cals: calories, protein: protein, fats: fats, carbs: carbs)
         delegate?.knownFoodEntry(foodItem: newFood)
         
         dismiss(animated: true, completion: nil)
    }
    
    private func displayError(erroTitle:String, errorMessage: String){
        let errorAlertContoller = UIAlertController(title: erroTitle, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        errorAlertContoller.addAction(okAction)
        present(errorAlertContoller, animated: true, completion: nil)
    }
    

    
    private func configureTapGuestureRecognizer(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateFoodViewController.didDetectTap))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func didDetectTap() {
        view.endEditing(true)
    }
    
}

extension CreateFoodViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

