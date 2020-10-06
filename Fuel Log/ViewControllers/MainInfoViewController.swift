//
//  ViewController.swift
//  Fuel Log
//
//  Created by Aidan on 2020-09-30.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
import UIKit

class MainInfoViewController: UIViewController {

    var user: User!
    
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var calCount: UILabel!
    @IBOutlet weak var proteinCount: UILabel!
    @IBOutlet weak var carbCount: UILabel!
    @IBOutlet weak var fatCount: UILabel!
    
    @IBOutlet weak var calorieProgress: UIProgressView!
    @IBOutlet weak var carbProgress: UIProgressView!
    @IBOutlet weak var proteinProgress: UIProgressView!
    @IBOutlet weak var fatProgress: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        foodTableView.dataSource = self
        user = User(calorieGoal: 0, proteinGoal: 0, fatGoal: 0, carbGoal: 0)
        
        if user.needsSetup == true{
            performSegue(withIdentifier: "setupApp", sender: nil)
            user.needsSetup = false
        }
        updateInputLabels()
       // tempAddFood()
    }
    
    
//    func tempAddFood(){
//        user.knownFoods.append(Food(foodName: "Chicken", cals: 300, protein: 30, fats: 2, carbs: 1))
//        user.knownFoods.append(Food(foodName: "Carrot Soup", cals: 600, protein: 30, fats: 10, carbs: 10))
//        user.knownFoods.append(Food(foodName: "Rice", cals: 200, protein: 12, fats: 6, carbs: 5))
//
//        let date = Date()
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//        print(dateFormatterPrint.string(from: date))
//
//
//        user.addNewFood(foodEntry: FoodEntry(foodItem: Food(foodName: "Chicken", cals: 300, protein: 30, fats: 2, carbs: 1), servingCount: 3))
//        user.addNewFood(foodEntry: FoodEntry(foodItem: Food(foodName: "Carrot Soup", cals: 600, protein: 30, fats: 10, carbs: 10), servingCount: 3))
//        user.addNewFood(foodEntry: FoodEntry(foodItem: Food(foodName: "Rice", cals: 200, protein: 12, fats: 6, carbs: 5), servingCount: 3))
//        updateInputLabels()
//        user.pastLogs.insert(PastLogs(pastLogs: user.dailyLog, date: date ), at: 0)
//    }
    
    private func updateInputLabels() {
        calCount.text = "\(user.calCount) / \(user.calorieGoal)"
        proteinCount.text = "\(user.proteinCount) / \(user.proteinGoal)"
        carbCount.text = "\(user.calCount) / \(user.carbGoal)"
        fatCount.text = "\(user.fatCount) / \(user.fatGoal)"
        calorieProgress.setProgress(Float(user.calCount)/Float(user.calorieGoal), animated: false)
        carbProgress.setProgress(Float(user.carbCount)/Float(user.carbGoal), animated: false)
        proteinProgress.setProgress(Float(user.proteinCount)/Float(user.proteinGoal), animated: false)
        fatProgress.setProgress(Float(user.fatCount)/Float(user.fatGoal), animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let foodViewController = segue.destination as? FoodTableViewController{
            foodViewController.delegate = self
            foodViewController.datasource = self
        }
        
        if let dailyGoalVC = segue.destination as? DailyGoalsViewController{
            dailyGoalVC.delegate = self
            dailyGoalVC.dataSource = self
        }
        
        if let dateVC = segue.destination as? DateTableViewController{
            dateVC.logSource = self
        }
    }
    
}

extension MainInfoViewController: FoodViewDataSource, FoodViewDelegate{
    func addKnownFood(food: Food) {
        user.knownFoods.append(food)
    }
    
    func showEmptyTable(tableView: UITableView) {
        showEmptyTableView(message: "Add Some Grub", tableView: tableView)
    }
    
    func getFoodItem(index: Int) -> Food {
        return user.knownFoods[index]
    }
    
    func getItemsCount() -> Int {
        return user.knownFoods.count
    }
    
    func foodRemoved(index: Int) {
        user.knownFoods.remove(at: index)
    }
    
    func mealAdded(foodEntry: FoodEntry) {
        user.addNewFood(foodEntry: foodEntry)
        updateInputLabels()
        foodTableView.reloadData()
    }
    
}

extension MainInfoViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if user.dailyLog.count == 0{
            showEmptyTableView(message: "FUEL UP!", tableView: foodTableView)
        }
        else{
            foodTableView.backgroundView = nil
        }
        return user.dailyLog.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            user.removeFood(index: indexPath.row)
            foodTableView.deleteRows(at: [indexPath], with: .fade)
        }
        updateInputLabels()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "foodEntry", for: indexPath) as? FoodEntryViewCell{
            let foodEntry = user.dailyLog[indexPath.row]
            tableViewCell.configureCell(foodEntry: foodEntry, sender: self)
            cell = tableViewCell
            }
        return cell
    }
    
    private func showEmptyTableView(message:String, tableView:UITableView){
        let infoLabel = UILabel()
        infoLabel.text = message
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        infoLabel.textColor = UIColor(named: "Dark-Grey-Color")
        tableView.backgroundView = infoLabel
    }
    
}

extension MainInfoViewController: DailyGoalsDelegate{
    func updateUserInfo(calories: Int, proteins: Int, carbs: Int, fats: Int) {
        if user == nil{
            user = User(calorieGoal: calories, proteinGoal: proteins, fatGoal: fats, carbGoal: carbs)
        }
        else{
            user.updateGoals(calorieGoal: calories, proteinGoal: proteins, fatGoal: fats, carbGoal: carbs)
        }
        updateInputLabels()
    }
}

extension MainInfoViewController: DailyGoalsDataSource{
    
    func getCalorieGoal() -> Int {
        return user.calorieGoal
    }
    
    func getProteinGoal() -> Int {
        return user.proteinGoal
    }
    
    func getCarbGoal() -> Int {
        return user.carbGoal
    }
    
    func getFatGoal() -> Int {
        return user.fatGoal
    }
}

extension MainInfoViewController: LogSource{
    func getPastLog(index: Int) -> PastLogs {
        return user.pastLogs[index]
    }
    
    func getLogCount() -> Int {
        return user.pastLogs.count
    }
    
}

