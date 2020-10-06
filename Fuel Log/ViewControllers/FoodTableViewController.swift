//
//  FoodTableViewController.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-02.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
import UIKit

protocol FoodViewDelegate{
    func foodRemoved(index: Int)
    func mealAdded(foodEntry: FoodEntry)
    func showEmptyTable(tableView: UITableView)
    func addKnownFood(food: Food)
}

protocol FoodViewDataSource{
    func getFoodItem(index: Int) -> Food
    func getItemsCount() -> Int
}

class FoodTableViewController: UIViewController {
    
    var delegate: FoodViewDelegate?
    var datasource: FoodViewDataSource?
    var currCellIndex: Int?
    
    @IBOutlet weak var foodView: UITableView!
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        foodView.delegate = self
        foodView.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let createViewController = segue.destination as? CreateFoodViewController{
           createViewController.delegate = self
       }
    }

}


extension  FoodTableViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    
        if let foodItem = datasource?.getFoodItem(index: currCellIndex!){
            let newMeal = FoodEntry(foodItem: foodItem, servingCount: row)
            if row>0{
                delegate?.mealAdded(foodEntry: newMeal)
                foodAddedMessage(message: "\(newMeal.servingCount) servings of \(newMeal.foodItem.foodName)")
                
            }
        }
        pickerView.removeFromSuperview()
        
        currCellIndex = nil
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    private func foodAddedMessage(message: String){
        let alertContoller = UIAlertController(title: "Meal Added", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertContoller.addAction(okAction)
        present(alertContoller, animated: true, completion: nil)
    }

}

extension FoodTableViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsInSec: Int = 0
        if datasource?.getItemsCount() == 0{
            delegate?.showEmptyTable(tableView: foodView)
        }
        else if (datasource?.getItemsCount()) != nil{
            foodView.backgroundView = nil
            rowsInSec =  datasource!.getItemsCount()
        }
        return rowsInSec
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            delegate?.foodRemoved(index: indexPath.row)
            foodView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as? FoodViewCell{
            if let food = datasource?.getFoodItem(index: indexPath.row){
                tableViewCell.configureCell(food: food)
                cell = tableViewCell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currCellIndex == nil{
            currCellIndex = indexPath.row
            let servingPicker: UIPickerView = UIPickerView()
            servingPicker.delegate = self
            servingPicker.dataSource = self
            view.addSubview(servingPicker)
            servingPicker.center = self.view.center
            servingPicker.backgroundColor = UIColor.opaqueSeparator
        }
    }
}

extension FoodTableViewController: CreateFoodViewDelegate{
    func knownFoodEntry(foodItem: Food) {
        delegate?.addKnownFood(food: foodItem)
        foodView.reloadData()
    }
    
    
}
