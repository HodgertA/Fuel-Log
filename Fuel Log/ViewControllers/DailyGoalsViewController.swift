//
//  DailyViewController.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-04.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
import UIKit

protocol DailyGoalsDelegate {
    func updateUserInfo(calories: Int, proteins: Int, carbs: Int, fats: Int)
}
protocol DailyGoalsDataSource {
    func getCalorieGoal() -> Int
    func getProteinGoal() -> Int
    func getCarbGoal() -> Int
    func getFatGoal() -> Int
}

class DailyGoalsViewController: UIViewController {
    
    var dataSource: DailyGoalsDataSource?
    var delegate: DailyGoalsDelegate?
    
    @IBOutlet weak var calorieText: UITextField!
    @IBOutlet weak var proteinText: UITextField!
    @IBOutlet weak var carbText: UITextField!
    @IBOutlet weak var fatText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(true)
        configureTextFields()
    }
    
    
    private func configureTextFields(){
        calorieText.delegate = self
        proteinText.delegate = self
        carbText.delegate = self
        fatText.delegate = self
        if dataSource != nil{
            calorieText.text = String(dataSource!.getCalorieGoal())
            proteinText.text = String(dataSource!.getProteinGoal())
            carbText.text = String(dataSource!.getCarbGoal())
            fatText.text = String(dataSource!.getFatGoal())
        }
    }
        
        
    @IBAction func updateGoals(_ sender: Any) {

        guard let cals = calorieText.text, cals.count > 0,
            let prtn = proteinText.text, prtn.count > 0,
            let crb = carbText.text, crb.count > 0,
            let fts = fatText.text, fts.count > 0 else {
                 displayError(erroTitle: "Error", errorMessage: "Missing required attributes.")
                 return
         }
         
         guard let calorieGoal = Int(cals) else {
             displayError(erroTitle: "Error", errorMessage: "Invalid calorie entry.")
             return
         }
        
        guard let proteinGoal = Int(prtn) else {
            displayError(erroTitle: "Error", errorMessage: "Invalid protein entry.")
            return
        }
        
        guard let carbGoal = Int(crb) else {
            displayError(erroTitle: "Error", errorMessage: "Invalid carbohydrate entry.")
            return
        }
        
        guard let fatGoal = Int(fts) else {
            displayError(erroTitle: "Error", errorMessage: "Invalid fat entry.")
            return
        }
        
        
         delegate?.updateUserInfo(calories: calorieGoal, proteins: proteinGoal, carbs: carbGoal, fats: fatGoal)
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

extension DailyGoalsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.resignFirstResponder()
        return true
    }
}


