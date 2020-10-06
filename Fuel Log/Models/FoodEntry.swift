//
//  FoodEntry.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-02.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation

import Foundation
class FoodEntry {
    let foodItem: Food
    let servingCount: Int
  
    init( foodItem: Food, servingCount: Int){
        self.foodItem = foodItem
        self.servingCount = servingCount
    }
}
