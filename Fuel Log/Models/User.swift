//
//  User.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-02.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation

class User{
    var needsSetup: Bool = true
    var calorieGoal: Int
    var proteinGoal: Int
    var fatGoal: Int
    var carbGoal: Int
    
    var calCount: Int = 0
    var proteinCount: Int = 0
    var fatCount: Int = 0
    var carbCount: Int = 0
    
    var dailyLog: [FoodEntry] = []
    var knownFoods: [Food] = []
    var pastLogs:[PastLogs] = []
    
    init( calorieGoal: Int, proteinGoal: Int, fatGoal: Int, carbGoal: Int){
        self.calorieGoal = calorieGoal
        self.proteinGoal = proteinGoal
        self.fatGoal = fatGoal
        self.carbGoal = carbGoal
        
        
    }
    
    func addNewFood(foodEntry: FoodEntry){
        calCount = calCount + foodEntry.foodItem.cals
        proteinCount = proteinCount + foodEntry.foodItem.protein
        fatCount = fatCount + foodEntry.foodItem.fats
        carbCount = carbCount + foodEntry.foodItem.carbs
        dailyLog.append(foodEntry)
    }
    
    func removeFood(index: Int){
        let deletedEntry = dailyLog[index]
        dailyLog.remove(at: index)
        calCount = calCount - deletedEntry.foodItem.cals
        proteinCount = proteinCount - deletedEntry.foodItem.protein
        fatCount = fatCount - deletedEntry.foodItem.fats
        carbCount = carbCount - deletedEntry.foodItem.carbs
    }
    
    func updateGoals(calorieGoal: Int, proteinGoal: Int, fatGoal: Int, carbGoal: Int){
        self.calorieGoal = calorieGoal
        self.proteinGoal = proteinGoal
        self.fatGoal = fatGoal
        self.carbGoal = carbGoal
    }
}
